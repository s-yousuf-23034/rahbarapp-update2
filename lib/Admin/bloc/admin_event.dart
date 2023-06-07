import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AdminEvent {}

class UpdateAdminStatusEvent extends AdminEvent {
  final bool isAdmin;

  UpdateAdminStatusEvent(this.isAdmin);
}

// States
abstract class AdminState {}

class AdminInitial extends AdminState {}

class AdminStatusUpdated extends AdminState {
  final bool isAdmin;

  AdminStatusUpdated(this.isAdmin);
}
