// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/pages_views/categories_page_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/categories_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/tabs_bars/categoris_vertical_tab_bar.dart';
import 'package:dinar_store/features/home/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    context.read<CategoriesCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Text(
              'المجموعـــــــــات',
              style: TextStyles.textStyle16.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 16.w,
              ),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    CategoriesCubit.selectedIndex = 0;
                    await context.read<CategoriesCubit>().getAllCategories();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CategoriesPgeView(
                        pageController: CategoriesCubit.pageController,
                        categoriesModel: state.categoriesModel,
                      ),
                      CategoriesVerticalTabBar(
                        categoriesModel: state.categoriesModel,
                      )
                    ],
                  ),
                );
              }
              return const CategoriesPlaceHolder();
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
