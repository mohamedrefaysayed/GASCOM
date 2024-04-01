import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit({
    required LogInServices logInServices,
  }) : super(LogOutInitial()) {
    _logInServices = logInServices;
  }

  late LogInServices _logInServices;

  Future<void> logOut() async {
    emit(LogOutLoading());

    AppCubit.token = null;
    await const FlutterSecureStorage().deleteAll();

    await Future.delayed(const Duration(seconds: 2));
    emit(LogOutSuccess());
  }

  Future<void> deleteAccount() async {
    logOut();

    emit(DeleteAccountLoading());

    AppCubit.token = null;
    await const FlutterSecureStorage().deleteAll();

    Either<ServerFailure, void> result = await _logInServices.deleteAccount();

    result.fold(
      //error
      (serverFailure) {
        emit(
          LogOutFailure(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (data) async {
        emit(DeleteAccountSuccess());
      },
    );
  }
}
