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
    String? token = await _secureStorage.read(key: kSecureStorageKey);

    if (token != null) {
      AppCubit.token = token;
    }
    // } else {
    //   AppCubit.token =
    //       "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxMSIsImp0aSI6ImNmMTFmZGQ2YThkMzI5ZGVjNWNkNGNhNjExMmEyZTQ0NWRkNWI1MDVhYmFjOWFmMDM4OWUxMTc3MmI2ZmNhOGI0NWEwNjNhZjQ4OTRhYTQ5IiwiaWF0IjoxNzA1NTU4MjU1LjQwOTU5MiwibmJmIjoxNzA1NTU4MjU1LjQwOTU5MywiZXhwIjozMzIzMDkzMTA1NS4zNzc3Mywic3ViIjoiODIiLCJzY29wZXMiOltdfQ.Y0qReE8N6M65F_ELeh5rH1HjC50EX5rdcoSZLBLDWFVsJitV4vC0rPImOa0GyTrclANRE1iiQ1HVbvx8FaAFsYSwpLWDfxCbglo-C_dTbxqAANvB53NxFpUWm1bEMr5JV_-2EArXbY0UmUxbZV39INv7bu3GUkIXhl0at6t8jm04-O7oM8orcMYvAIYzcBPg2KhuRgWGU0Cs8-7pOPNShpOXu6_BIvrtp9c6SRVfS1wLfOkXDMkKs5ExvwpkKBtXtJC8E8Mk3znqieyzEGKvutCA7UG1aPo6l9kgzLovFO95uMUf-UTA4MYRFPzPKCpGXJgvdmB24-3-xOCBx67JzK2jgWl25HBB9AV_1Bq3b8UjEdKwgBPZihZ4buAe3OiZPPnQ6aTUNOTKbj_FAc7Y6gjlsSy7KzSjD5eZmaRFwpXc1xknsys3Huq99Pa2d-SgUToAJ-GcoDFZyBu4ji8uQxu-83fYSkTFEuautbG2YBPQ9ImUTgLo18-UV7k7W3srxOnpLObWV-bwOvWddVQjPXCKyiCRNMGluoyCAum5_M3cXxaTcucU0xrNLDWkup5ajsmz-JBxc1qN1zOe6bgFKqHlT3aq1YFYu_tZSPQ-etMWMo86H7pSUnOkwq--hxOmwiFhjapkkZodwGo--gxaQ8bBAdLBuBb6Ep_Tg21gbLg";
    // }

    if (kDebugMode) {
      print(token);
    }

    await showPermissions();

    if (AppCubit.token != null) {
      emit(NavigateToNavBarView());
    } else {
      emit(NavigateToUserType());
    }
    // else {
    //   emit(NavigateToQrView());
    // }
  }
}
