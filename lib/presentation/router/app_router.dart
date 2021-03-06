import 'package:book_shop/logic/bloc/account_bloc.dart';
import 'package:book_shop/logic/bloc/auth_bloc.dart';
import 'package:book_shop/logic/bloc/basket_bloc.dart';
import 'package:book_shop/logic/bloc/chat_bloc.dart';
import 'package:book_shop/logic/bloc/chatlist_bloc.dart';
import 'package:book_shop/logic/bloc/details_bloc.dart';
import 'package:book_shop/logic/bloc/home_bloc.dart';
import 'package:book_shop/logic/bloc/title_bloc.dart';
import 'package:book_shop/logic/cubit/internet_cubit.dart';
import 'package:book_shop/presentation/ui/chat_list_screen.dart';
import 'package:book_shop/presentation/ui/chat_screen.dart';
import 'package:book_shop/presentation/ui/details_screen.dart';
import 'package:book_shop/presentation/ui/home_screen.dart';
import 'package:book_shop/presentation/ui/login_screen.dart';
import 'package:book_shop/presentation/ui/sign_up_screen.dart';
import 'package:book_shop/presentation/ui/socket_test_screen.dart';
import 'package:book_shop/presentation/ui/splash_screen.dart';
import 'package:book_shop/presentation/ui/title_details_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:book_shop/logic/bloc/home_event.dart';

class AppRouter {
  final AuthBloc _authBloc = new AuthBloc();

  final HomeBloc _homeBloc = new HomeBloc();

  final AccountBloc _accountBloc = new AccountBloc();

  final InternetCubit _internetCubit =
      new InternetCubit(connectivity: Connectivity());
  final _loginScreen = LoginScreen();

  Route onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _internetCubit,
            child: SplashScreen(), //_authBloc
          ),
        );
        break;
      case '/login':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
            ],
            child: _loginScreen,
          ),
        );
        break;
      case '/sign_up':
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _authBloc,
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
            ],
            child: SignUpScreen(),
          ),
        );
        break;
      case '/home':
        return PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 300),
            transitionsBuilder: (context, aniamtion, animationTime, child) {
              return FadeTransition(
                opacity: aniamtion,
                child: child,
              );
            },
            pageBuilder: (context, aniamtion, animationTime) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: _internetCubit,
                  ),
                  BlocProvider.value(
                    value: _homeBloc,
                  )
                ],
                child: HomeScreen(
                  homeBloc: _homeBloc..add(FetchEvent()),
                  accountBloc: _accountBloc
                    ..add(
                      GetDefaultEvent(),
                    ),
                ),
              );
            });
        break;
      case '/details':
        final Map<String, String> args = settings.arguments;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => DetailsBloc(),
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => BasketBloc(),
              ),
            ],
            child: DetailsScreen(
              args: args,
            ),
          ),
        );
        break;
      case '/title':
        final Map<String, String> args = settings.arguments;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, animationTime, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: _internetCubit,
              ),
              BlocProvider(
                create: (context) => TitleBloc(),
              )
            ],
            child: TitleDetailsScreen(
              category: int.tryParse(args["category"].toString()),
            ),
          ),
        );
        break;

      case '/socket':
        return MaterialPageRoute(
          builder: (_) => SocketTextScreen(),
        );
        break;
      case '/chat':
        final Map<String, String> args = settings.arguments;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 400),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (BuildContext context) => ChatBloc(),
              ),
              BlocProvider.value(
                value: _internetCubit,
              ),
            ],
            child: ChatScreen(
              args: args,
            ),
          ),
        );
      case '/chatList':
        final Map<String, String> args = settings.arguments;

        return PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 30),
          transitionsBuilder: (context, ainmation, animationTime, child) {
            return FadeTransition(opacity: ainmation, child: child);
          },
          pageBuilder: (_, __, ___) => MultiBlocProvider(providers: [
            BlocProvider(
              create: (BuildContext context) => ChatlistBloc(),
            ),
            BlocProvider.value(
              value: _internetCubit,
            ),
          ], child: ChatListScreen()),
        );
      default:
        return null;
    }
  }

  void dispose() {
    _authBloc.close();
    _homeBloc.close();
    _accountBloc.close();
    _internetCubit.close();
  }
}
