// ignore_for_file: use_build_context_synchronously

import 'package:dinar_store/features/home/presentation/view/widgets/adds_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/categories_view_home.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/companies_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/search_rows/search_row.dart';
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
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
                    child: SearchRow(
                      textEditingController: TextEditingController(),
                      hintText: 'إبحث عن المتجر او القطعة',
                      onPerssedFilter: () {},
                      canGoBack: false,
                      haveFilter: true,
                      onFilter: () {},
                    ),
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
                    child: const CategoriesViewHome(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
