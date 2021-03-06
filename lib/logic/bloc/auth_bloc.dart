import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_shop/data/model/auth_model.dart';
import 'package:book_shop/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  AuthRepository _authRepository = new AuthRepository();
  SharedPreferences _prefs;
  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    AuthModel _authModel;

    _prefs = await SharedPreferences.getInstance();
    if (event is LoginEvent) {
      try {
        print('AuthInitial');
        yield AuthLoading();
        print('AuthLoading');
        _authModel =
            await _authRepository.login(event.username, event.password);
        if (_authModel.status == "true") {
          yield AuthSuccess(_authModel);

          if (await setSharedPrefes(_authModel)) {
            //executing shared prefs and test input
            print('setting login sharedPrefs successfully');
            final SharedPreferences p = await _prefs;
            print("recoverd sharedPrefs: ${p.getString("id")}");
          }

          print('AuthSuccess');
        } else {
          yield AuthWrong();
          print('AuthWrong');
        }
      } catch (e) {
        yield AuthFailure();
        print('auth failure ${e.toString()}');
      }
    } else if (event is SignUpEvent) {
      try {
        yield AuthLoading();
        print('AuthLoading');
        _authModel = await _authRepository.signUp(
            username: event.username, password: event.password);

        if (await setSharedPrefes(_authModel)) {
          //executing shared prefs and test input
          print('setting sign up sharedPrefs successfully');
          final SharedPreferences p = _prefs;
          print("recoverd sharedPrefs: ${p.getString("id")}");
        }

        yield AuthSuccess(_authModel);
        print('AuthSuccess');
      } catch (e) {
        yield AuthFailure();
        print('auth failure ${e.toString()}');
      }
    }
  }

  Future<bool> setSharedPrefes(_model) async {
    return await _prefs.setString("id", _model.id.toString());
  }
}
