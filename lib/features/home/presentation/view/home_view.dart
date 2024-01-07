// ignore_for_file: use_build_context_synchronously

import 'package:dinar_store/features/home/presentation/view/widgets/adds_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/categories_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/companies_view.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/companies_cubit/companies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await context.read<AdsCubit>().getAllAds();
        await context.read<CompaniesCubit>().getAllCompanies();
        await context.read<CategoriesCubit>().getAllCategories();
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                const AddsView(),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const CompaniesView(),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const CategoriesView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
