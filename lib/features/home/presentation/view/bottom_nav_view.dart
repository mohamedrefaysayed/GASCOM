// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/features/home/presentation/view/home_view.dart';
import 'package:dinar_store/features/home/presentation/view_model/bottom_nav_cubit.dart/cubit/bottton_nav_bar_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarView extends StatelessWidget {
  const BottomNavBarView({Key? key}) : super(key: key);

  static const id = '/BottomNavBarView';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return PopScope(
          canPop: false,
          child: Scaffold(
            body: IndexedStack(
              index: BottomNavBarCubit.index,
              children: const [
                Center(
                  child: Text("1"),
                ),
                Center(
                  child: Text("2"),
                ),
                Center(
                  child: Text("3"),
                ),
                Center(
                  child: Text("4"),
                ),
                HomeView(),
              ],
            ),
            bottomNavigationBar: BottomBarCreative(
              items: BottomNavBarCubit.items,
              backgroundColor: Colors.white,
              color: Colors.grey,
              colorSelected: AppColors.kASDCPrimaryColor,
              indexSelected: BottomNavBarCubit.index,
              highlightStyle: const HighlightStyle(),
              onTap: (int tappedIndex) {
                BottomNavBarCubit.index = tappedIndex;
                context.read<BottomNavBarCubit>().emit(BottomNavBarUpdate());
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
        );
      },
    );
  }
}
