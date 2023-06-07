import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rahbarapp/Admin/bloc/admin_event.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  AdminBloc() : super(AdminInitial());

  bool _isAdmin = false;

  @override
  Stream<AdminState> mapEventToState(AdminEvent event) async* {
    if (event is UpdateAdminStatusEvent) {
      _isAdmin = event.isAdmin;
      yield AdminStatusUpdated(_isAdmin);
    }
  }
}
