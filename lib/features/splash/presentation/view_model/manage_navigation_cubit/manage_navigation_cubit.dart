import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/functions/show_permitions.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'manage_navigation_state.dart';

class ManageNavigationCubit extends Cubit<ManageNavigationState> {
  ManageNavigationCubit({
    required FlutterSecureStorage secureStorage,
  }) : super(ManageNavigationInitial()) {
    _secureStorage = secureStorage;
  }

  late FlutterSecureStorage _secureStorage;

  Future<void> getAppData(BuildContext context) async {
    await showPermissions();

    String? token = await _secureStorage.read(key: kSecureStorageKey);

    if (token != null) {
      AppCubit.token = token;
    }

    if (kDebugMode) {
      print(token);
    }

    emit(NavigateToLogInView());

    // if (AppCubit.userModel != null) {
    //   emit(NavigateToNavBarView());
    // } else if (AppCubit.clientModel != null) {
    //   emit(NavigateToLogInView());
    // } else {
    //   emit(NavigateToQrView());
    // }
  }
}
