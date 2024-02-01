import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  Future<void> logOut() async {
    emit(LogOutLoading());

    AppCubit.token = null;
    await const FlutterSecureStorage().deleteAll();

    await Future.delayed(const Duration(seconds: 2));
    emit(LogOutSuccess());
    // Either<ServerFailure, Map<String, dynamic>> result =
    //     await _logInServices.register(
    //   countryCode: phoneNumber!.countryCode,
    //   phoneNumber: phoneNumber!.number,
    // );

    // result.fold(
    //   //error
    //   (serverFailure) {
    //     emit(
    //       LogOutFailure(errMessage: serverFailure.errMessage),
    //     );
    //   },
    //   //success
    //   (data) async {
    //     emit(LogOutSuccess());
    //   },
    // );
  }
}
