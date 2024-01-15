// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/product_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/products_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_category_products_cubit/sub_category_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholeSubCategoryView extends StatefulWidget {
  const WholeSubCategoryView({
    super.key,
    required this.subCategory,
  });

  final SubCategories subCategory;

  @override
  State<WholeSubCategoryView> createState() => _WholeSubCategoryViewState();
}

class _WholeSubCategoryViewState extends State<WholeSubCategoryView> {
  double imageHight = 350.h;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    context
        .read<SubCategoryProductCubit>()
        .getSubCategoryWithProduct(catId: widget.subCategory.id!);
    scrollController.addListener(() {
      if (SubCategoryProductCubit.subCategoryProductsModel.products!.length >
          5) {
        if (scrollController.offset > 100) {
          setState(() {
            imageHight = 0;
          });
        }
        if (scrollController.offset == 0) {
          setState(() {
            imageHight = 350.h;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            context
                .read<SubCategoryProductCubit>()
                .getSubCategoryWithProduct(catId: widget.subCategory.id!);
          },
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                AnimatedContainer(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15.w)),
                  height: imageHight,
                  duration: const Duration(milliseconds: 500),
                  child: Hero(
                    tag: 'SubCat${widget.subCategory.id}',
                    child: MyCachedNetworkImage(
                      url: widget.subCategory.image!,
                      height: imageHight,
                      errorIcon: Icon(
                        Icons.image,
                        size: 150.w,
                        color: AppColors.kASDCPrimaryColor,
                      ),
                      loadingWidth: 13.w,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                widget.subCategory.categoryName!,
                                style: TextStyles.textStyle16
                                    .copyWith(fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.rtl,
                              ),
                              Text(
                                widget.subCategory.description!,
                                style: TextStyles.textStyle10.copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                                textDirection: TextDirection.rtl,
                              ),
                            ],
                          ),
                        ),
                        const GeneralDivider(),
                        Expanded(
                          child: ListView(
                            controller: scrollController,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            children: [
                              BlocConsumer<SubCategoryProductCubit,
                                  SubCategoryProductState>(
                                listener: (context, state) {
                                  if (state is SubCategoryProductSuccess) {
                                    SubCategoryProductCubit
                                            .subCategoryProductsModel =
                                        state.subCategoryProductsModel;
                                  }
                                },
                                builder: (context, state) {
                                  if (state is SubCategoryProductSuccess) {
                                    return SubCategoryProductCubit
                                            .subCategoriesController
                                            .text
                                            .isEmpty
                                        ? SubCategoryProductCubit
                                                .subCategoryProductsModel
                                                .products!
                                                .isEmpty
                                            ? ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  SizedBox(
                                                    height: 150.h,
                                                    child: Center(
                                                      child: Text(
                                                        'لا يوجد عناصر',
                                                        style: TextStyles
                                                            .textStyle14
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    SubCategoryProductCubit
                                                        .subCategoryProductsModel
                                                        .products!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  return ProductContainer(
                                                    product: SubCategoryProductCubit
                                                        .subCategoryProductsModel
                                                        .products![index],
                                                  );
                                                },
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
                                                        style: TextStyles
                                                            .textStyle14
                                                            .copyWith(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : ListView.builder(
                                                padding: EdgeInsets.zero,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount:
                                                    SubCategoryProductCubit
                                                        .subCategoryProductsModel
                                                        .products!
                                                        .length,
                                                itemBuilder: (context, index) {
                                                  return ProductContainer(
                                                    product: SubCategoryProductCubit
                                                        .subCategoryProductsModel
                                                        .products![index],
                                                  );
                                                },
                                                addAutomaticKeepAlives: true,
                                              );
                                  }

                                  return const ProductsPlaceHolder();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
