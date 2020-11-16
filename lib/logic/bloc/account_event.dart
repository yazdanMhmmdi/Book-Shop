part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class GetDefaultEvent extends AccountEvent {
  String userId;
  GetDefaultEvent(this.userId);
  @override
  List<Object> get props => [userId];
}

class EditEvent extends AccountEvent {}
