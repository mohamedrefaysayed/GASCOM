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
    } else {
      token =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxMSIsImp0aSI6ImM3MWFjYWE2Yjg4NDBhZjUzMjQ5OTAxNTM4ZmI2YmE2MTRkMGM4NzJjMDFhZDVhYjhmNTM3ZTk3NzgzMDA4OGJhNTA2ZGQ4ZGE3ZDA0ZGVlIiwiaWF0IjoxNzA1NDM2NzI5LjAxODU2NCwibmJmIjoxNzA1NDM2NzI5LjAxODU2NiwiZXhwIjozMzIzMDgwOTUyOC45MzExOTQsInN1YiI6IjU2Iiwic2NvcGVzIjpbXX0.EXUR5ZppFmjhK8lh0LBJiP0CCID6DgOk7qFQv414qEOrXA4NsAt3MKf_L0FNuB1Scta7eEflf-rD6oejGJwNDdvELc9D9cIYdoRxymUMK5IxCOdh4dbsher8GB_q_TTO57gPNu8TPh7WhbzsbGnS3tfCvG1g0PWBhf7BtaxhBvy50CFVbKLGNMYTY3mmLDHpS09IaymRj0kaiiwlTQc6WLuM9qdKLac4oYr3AeytqUM-2YOY5EcqAzPyx3uOSbBQ7xmRvxE_DDj25HcCaB3nSver084lLPBXwA7LRQkYlLgT42cMzR0krCtIaUQyElr72PYAATVveqv278PTWEndlJozE42VV75ljW3iqxKYolTRXXMsV4wc9laGALE6qjpgCsm-VnV_l3KrH-jHg-SyrqQTF7JES9oPg-_f0UnaYe4vHGJ3ORmfarqhHncylWc8w3-vRsz95W161hcYTj8JlrlBHRe-_5JWIqrEt-SrRI0z-VWlK_TDTi1rGYQ-fmez3Utc5tvsuhZTKFAJQb59WLYKTiJTsAAdS77jyWmfQCPv2LI_stOfckT3OMrXzV0Gz2cD0z9TS6hCMJI8wrTCRyOZIYgdSGiPh3yS0mw91gCMwO7iQ2TW3VBKH0fu5ua1XDqM5oH1YB2ZtVOOMhXiv9j7d6PyqxPboByZLZB99Mc';
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
