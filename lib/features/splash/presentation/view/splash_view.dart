import 'package:dinar_store/features/splash/presentation/view/widgets/future_builder/splash_view_future_builder.dart';
import 'package:dinar_store/features/splash/presentation/view_model/manage_navigation_cubit/manage_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ManageNavigationCubit>(
      create: (context) => ManageNavigationCubit(
        secureStorage: const FlutterSecureStorage(),
      ),
      child: const SplashViewFutureBuilder(),
    );
  }
}
