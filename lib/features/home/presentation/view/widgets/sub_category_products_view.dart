// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/sub_category_product_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/all_companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/search_rows/search_row.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_category_products_cubit/sub_category_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryProductsView extends StatefulWidget {
  const SubCategoryProductsView({
    super.key,
    required this.subcategory,
  });

  final SubCategories subcategory;

  @override
  State<SubCategoryProductsView> createState() =>
      _SubCategoryProductsViewState();
}

class _SubCategoryProductsViewState extends State<SubCategoryProductsView> {
  @override
  void initState() {
    context
        .read<SubCategoryProductCubit>()
        .getSubCategoryWithProduct(catId: widget.subcategory.id!);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        SubCategoryProductCubit.subCategoriesController.clear();
      },
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<SubCategoryProductCubit>()
                .getSubCategoryWithProduct(catId: widget.subcategory.id!);
          },
          child: Padding(
            padding: EdgeInsets.only(top: 50.h, right: 20.w, left: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SearchRow(
                  textEditingController:
                      SubCategoryProductCubit.subCategoriesController,
                  hintText: 'ابحث عن المنتج',
                  canGoBack: true,
                  whenBack: () {
                    Navigator.pop(context);
                  },
                  haveFilter: true,
                  onFilter: () {},
                  onChanged: (val) {
                    context.read<SubCategoryProductCubit>().searchInProducts();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  widget.subcategory.categoryName!,
                  style: TextStyles.textStyle18
                      .copyWith(fontWeight: FontWeight.w700),
                  textDirection: TextDirection.rtl,
                ),
                Text(
                  widget.subcategory.description!,
                  style: TextStyles.textStyle12.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                  textDirection: TextDirection.rtl,
                ),
                SizedBox(
                  height: 30.h,
                ),
                BlocConsumer<SubCategoryProductCubit, SubCategoryProductState>(
                  listener: (context, state) {
                    if (state is SubCategoryProductSuccess) {
                      SubCategoryProductCubit.subCategoryProductsModel =
                          state.subCategoryProductsModel;
                    }
                  },
                  builder: (context, state) {
                    if (state is SubCategoryProductSuccess) {
                      return SubCategoryProductCubit
                              .subCategoriesController.text.isEmpty
                          ? SubCategoryProductCubit
                                  .subCategoryProductsModel.products!.isEmpty
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(
                                      height: 150.h,
                                      child: Center(
                                        child: Text(
                                          'لا يوجد عناصر',
                                          style: TextStyles.textStyle14,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: SubCategoryProductCubit
                                      .subCategoryProductsModel
                                      .products!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return SubCategoryProductContainer(
                                      product: SubCategoryProductCubit
                                          .subCategoryProductsModel
                                          .products![index],
                                    );
                                  },
                                  addAutomaticKeepAlives: true,
                                )
                          : SubCategoryProductCubit
                                  .subCategoryProductsModelSearch
                                  .products!
                                  .isEmpty
                              ? ListView(
                                  shrinkWrap: true,
                                  children: [
                                    SizedBox(
                                      height: 150.h,
                                      child: Center(
                                        child: Text(
                                          'لا يوجد',
                                          style: TextStyles.textStyle14,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: SubCategoryProductCubit
                                      .subCategoryProductsModel
                                      .products!
                                      .length,
                                  itemBuilder: (context, index) {
                                    return SubCategoryProductContainer(
                                      product: SubCategoryProductCubit
                                          .subCategoryProductsModel
                                          .products![index],
                                    );
                                  },
                                  addAutomaticKeepAlives: true,
                                );
                    }
                    if (state is SubCategoryProductFaliuer) {
                      return Text(state.errMessage);
                    }
                    return const Expanded(
                      child: AllCompaniesPlaceHolder(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
