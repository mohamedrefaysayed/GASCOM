import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'bottton_nav_bar_state.dart';

class BottomNavBarCubit extends Cubit<BottomNavBarState> {
  BottomNavBarCubit() : super(BottomNavBarInitial());

  static int index = 0;
  static List<TabItem> items = [
    const TabItem(
      icon: Icons.person_2_rounded,
      title: 'البروفايل',
    ),
    const TabItem(
      icon: Icons.receipt_long_rounded,
      title: 'الطلبات',
    ),
    const TabItem(
      icon: Icons.shopping_cart_rounded,
    ),
    const TabItem(
      icon: Icons.category_rounded,
      title: 'الأقسام',
    ),
    const TabItem(
      icon: Icons.home_rounded,
      title: 'الرئيسية',
    ),
  ];
}
