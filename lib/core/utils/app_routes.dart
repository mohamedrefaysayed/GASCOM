import 'package:dinar_store/features/auth/presentation/view/login_view.dart';
import 'package:flutter/material.dart';

abstract class AppRoutes {
  static Map<String, Widget Function(BuildContext context)> routes = {
    // '/': (context) => const SplashView(),
    // QrCodeAuthView.id: (context) => const QrCodeAuthView(),
    LogInView.id: (context) => const LogInView(),
    // HomeView.id: (context) => const HomeView(),
  };
}
