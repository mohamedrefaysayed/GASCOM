// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/buttons/action_icon_button.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/cachedNetworkImage/my_cached_nework_Image.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/dividers/ginerall_divider.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/listviews/whole_sub_category_list_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/search_rows/search_row.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_category_products_cubit/sub_category_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholeSubCategoryView extends StatefulWidget {
  const WholeSubCategoryView({
    super.key,
    required this.subCategory,
    required this.subCategories,
  });

  final SubCategories subCategory;
  final List<SubCategories> subCategories;

  @override
  State<WholeSubCategoryView> createState() => _WholeSubCategoryViewState();
}

class _WholeSubCategoryViewState extends State<WholeSubCategoryView>
    with SingleTickerProviderStateMixin {
  double imageHight = 350.h;
  ScrollController scrollController = ScrollController();
  int initialIndex = 0;
  late TabController tabController;

  @override
  void initState() {
    for (int index = 0; index < widget.subCategories.length; index++) {
      if (widget.subCategories[index] == widget.subCategory) {
        initialIndex = index;
      }
    }
    tabController = TabController(
        initialIndex: initialIndex,
        length: widget.subCategories.length,
        vsync: this);
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
      child: PopScope(
        canPop: imageHight == 0 ? false : true,
        onPopInvoked: (didPop) {
          if (imageHight == 0) {
            tabController.index = initialIndex;
            SubCategoryProductCubit.subCategoriesController.clear();
            imageHight = 350.h;
            context
                .read<SubCategoryProductCubit>()
                .getSubCategoryWithProduct(catId: widget.subCategory.id!);
            setState(() {});
          }
        },
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.w)),
                    height: imageHight,
                    duration: const Duration(milliseconds: 500),
                    child: Stack(
                      children: [
                        Hero(
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
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: const Row(
                              children: [
                                ActionIconButton(
                                  icon: Icons.favorite_border_outlined,
                                ),
                                ActionIconButton(icon: Icons.share),
                                ActionIconButton(
                                  icon: Icons.search,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 15.h),
                      child: Column(
                        children: [
                          imageHight == 0
                              ? SizedBox(
                                  height: 50.h,
                                  child: TabBar(
                                      controller: tabController,
                                      onTap: (index) {
                                        context
                                            .read<SubCategoryProductCubit>()
                                            .getSubCategoryWithProduct(
                                                catId: widget
                                                    .subCategories[index].id!);
                                      },
                                      tabs: List.generate(
                                          widget.subCategories.length,
                                          (index) => Tab(
                                                text: widget
                                                    .subCategories[index]
                                                    .categoryName,
                                              ))),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        widget.subCategory.categoryName!,
                                        style: TextStyles.textStyle16.copyWith(
                                            fontWeight: FontWeight.w400),
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
                          imageHight == 0
                              ? Expanded(
                                  child: Column(
                                    children: [
                                      SearchRow(
                                          textEditingController:
                                              SubCategoryProductCubit
                                                  .subCategoriesController,
                                          hintText: 'ابحث عن المنتج',
                                          canGoBack: true,
                                          whenBack: () {
                                            tabController.index = initialIndex;
                                            SubCategoryProductCubit
                                                .subCategoriesController
                                                .clear();
                                            imageHight = 350.h;
                                            context
                                                .read<SubCategoryProductCubit>()
                                                .getSubCategoryWithProduct(
                                                    catId:
                                                        widget.subCategory.id!);
                                            setState(() {});
                                          },
                                          haveFilter: false,
                                          onChanged: (_) {
                                            context
                                                .read<SubCategoryProductCubit>()
                                                .searchInProducts();
                                            setState(() {});
                                          }),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Expanded(
                                        child: TabBarView(
                                            controller: tabController,
                                            children: List.generate(
                                              widget.subCategories.length,
                                              (index) =>
                                                  WholeSubCategoryListView(
                                                      scrollController:
                                                          scrollController),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              : Expanded(
                                  child: WholeSubCategoryListView(
                                      scrollController: scrollController),
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
      ),
    );
  }
}
