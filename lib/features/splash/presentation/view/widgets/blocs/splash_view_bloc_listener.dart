// ignore_for_file: use_build_context_synchronously

import 'package:dinar_store/features/home/presentation/view/bottom_nav_view.dart';
import 'package:dinar_store/features/splash/presentation/view/widgets/columns/splash_view_body_column.dart';
import 'package:dinar_store/features/splash/presentation/view_model/manage_navigation_cubit/manage_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewBlocListener extends StatefulWidget {
  const SplashViewBlocListener({super.key});

  @override
  State<SplashViewBlocListener> createState() => _SplashViewBlocListenerState();
}

class _SplashViewBlocListenerState extends State<SplashViewBlocListener> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ManageNavigationCubit, ManageNavigationState>(
      listener: (context, state) {
        if (state is NavigateToUserType) {
          Navigator.pushReplacementNamed(context, 'usertype');
        }
        if (state is NavigateToNavBarView) {
          Navigator.pushReplacementNamed(context, BottomNavBarView.id);
        }
        // else if (state is NavigateToLogInView) {
        //   Navigator.pushReplacementNamed(context, LogInView.id);
        // } else if (state is NavigateToQrView) {
        //   Navigator.pushReplacementNamed(context, QrCodeAuthView.id);
        // }
      },
      child: const SplashViewBodyColumn(),
    );
  }
}
