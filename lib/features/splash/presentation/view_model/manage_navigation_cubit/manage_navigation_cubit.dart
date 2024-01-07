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
      AppCubit.token =
          'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxMSIsImp0aSI6IjFiYjk4NTM5Y2JjZmYzMmQxM2QxZjE5YWMzN2FjZDQwMTkxYWM3ZjgwMGFkMmE4ZTFiMGFmOTBlYTU0N2FlZjg3ZWExOTkxYTQ5NTEzNTQwIiwiaWF0IjoxNzA0NTQ5ODM4Ljg4NzUxLCJuYmYiOjE3MDQ1NDk4MzguODg3NTEyLCJleHAiOjE3MzYxNzIyMzguNzkxODg0LCJzdWIiOiI1NCIsInNjb3BlcyI6W119.kKaytt4Bedg-PU9a03qGU0mrnoxfdAdHPF71DukGlpGY8cXL2LXx1As4THwkH0K3p7yULWifGdlzjg_PKCEoGqGnm5Aow2leKEb43lLvR91sLSXF6G2yc1Z36ujWuLFHdSW9lxITWOb7JWRZkOTMTBqy5j6At_jCqERe3TkWkkJMgAkvzbWpN8CeCs_O88IUy7XdVR4IGi_4mwF1FCGv2tdqVF6fMxqOZ1Hqtmc-TUGazivTt8M961BiQ81BGHu_2p8qPuJrDFcBV_a3WYIrhYOYahKdDETYZJzp3bZnsYk2gRQdeAih5yCZC6cKMF-_evP4IHjXzmge8peswFe6ZbV0zctfRBTgh5aQIHfb7jXTxC9cSodNeHzLtx6a4mtDbeG_Dv34Pc2Men7foLTyNkhlQpxCdpHj6X8sQFff8OquKApe3Ag-VlJH2iGz95VFqhEQfwdye-e5rjdGhi-mj0loEGa4Fp4oHdiw9Co60B_v7ZKZEv2hYHsfh-PGYMY3KN5f9aQsXrh-ZLsFbyxyKBJ95KfqhYRVx0NSH5FiGIUPRDZYmYXtMxRrekvxMBuiIL345Qg9RfVcsRZwDoyHvVZCht0B9hZOXeP0Gg4qXS9X3u6a1GuRsrP0UY3ABRA2JoRITqfrEYAtOzUngSrNbasAXRDq5Fg6sVhqYNEQex4';
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
