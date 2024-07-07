// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dinar_store/core/helpers/internet_connection/InternetConnection.dart';
import 'package:dinar_store/core/helpers/notifications.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/genrall.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/core/widgets/message_snack_bar.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dinar_store/features/home/presentation/view/home_view.dart';
import 'package:dinar_store/features/home/presentation/view/home_view_agent.dart';
import 'package:dinar_store/features/home/presentation/view/orders_view.dart';
import 'package:dinar_store/features/home/presentation/view/profile_view.dart';
import 'package:dinar_store/features/home/presentation/view_model/bottom_nav_cubit.dart/cubit/bottton_nav_bar_cubit.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarView extends StatefulWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  static const id = '/BottomNavBarView';

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView>
    with WidgetsBindingObserver {
  late Timer internetTimer;

  late Timer checkTokenTimer;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        Notifications.showNotification(
          id: DateTime.now().millisecondsSinceEpoch % 0x7FFFFFFF,
          title: message.notification!.title!,
          body: message.notification!.body!,
          localNotifications: FlutterLocalNotificationsPlugin(),
        );
      },
    );
    checkTokenTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) {
        context.read<LogOutCubit>().checkToken();
      },
    );

    BottomNavBarCubit.index = 2;
    WidgetsBinding.instance.addObserver(this);
    internetTimer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        context.checkInternet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogOutCubit, LogOutState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'usertype', (route) => false);
          ScaffoldMessenger.of(context)
              .showSnackBar(messageSnackBar(message: "تم الخروج بنجاح"));
        }
      },
      builder: (context, state) {
        return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
          builder: (context, state) {
            return PopScope(
              canPop: false,
              child: ScaffoldMessenger(
                child: Scaffold(
                  body: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: BottomNavBarCubit.controller,
                    children: [
                      const ProfileView(),
                      const OrdersView(),
                      if (isCustomer) const HomeView(),
                      if (!isCustomer) const HomeViewAgent(),
                    ],
                  ),
                  bottomNavigationBar: BottomBarDefault(
                    iconSize: 25.w,
                    items: isCustomer
                        ? BottomNavBarCubit.items
                        : BottomNavBarCubit.agentItems,
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                    colorSelected: AppColors.kASDCPrimaryColor,
                    indexSelected: BottomNavBarCubit.index,
                    titleStyle: TextStyles.textStyle12
                        .copyWith(fontWeight: FontWeight.w700),
                    onTap: (int tappedIndex) {
                      BottomNavBarCubit.index = tappedIndex;
                      BottomNavBarCubit.controller.jumpToPage(tappedIndex);
                      context
                          .read<BottomNavBarCubit>()
                          .emit(BottomNavBarUpdate());
                    },
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8.w,
                        spreadRadius: 0.5.w,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
