import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/product_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/products_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_category_products_cubit/sub_category_product_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WholeSubCategoryListView extends StatefulWidget {
  const WholeSubCategoryListView({
    super.key,
    required this.scrollController,
  });

  final ValueNotifier<ScrollController> scrollController;

  @override
  State<WholeSubCategoryListView> createState() =>
      _WholeSubCategoryListViewState();
}

class _WholeSubCategoryListViewState extends State<WholeSubCategoryListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SubCategoryProductCubit, SubCategoryProductState>(
      listener: (context, state) {
        if (state is SubCategoryProductSuccess) {
          SubCategoryProductCubit.subCategoryProductsModel =
              state.subCategoryProductsModel;
        }
      },
      builder: (context, state) {
        if (state is SubCategoryProductSuccess) {
          return SubCategoryProductCubit.subCategoriesController.text.isEmpty
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
                              style: TextStyles.textStyle14
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      controller: widget.scrollController.value,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: SubCategoryProductCubit
                          .subCategoryProductsModel.products!.length,
                      itemBuilder: (context, index) {
                        return ProductContainer(
                          product: SubCategoryProductCubit
                              .subCategoryProductsModel.products![index],
                        );
                      },
                    )
              : SubCategoryProductCubit
                      .subCategoryProductsModelSearch.products!.isEmpty
                  ? ListView(
                      shrinkWrap: true,
                      children: [
                        SizedBox(
                          height: 150.h,
                          child: Center(
                            child: Text(
                              'لا يوجد',
                              style: TextStyles.textStyle14
                                  .copyWith(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: SubCategoryProductCubit
                          .subCategoryProductsModelSearch.products!.length,
                      itemBuilder: (context, index) {
                        return ProductContainer(
                          product: SubCategoryProductCubit
                              .subCategoryProductsModelSearch.products![index],
                        );
                      },
                      addAutomaticKeepAlives: true,
                    );
        }

        return const ProductsPlaceHolder();
      },
    );
  }
}
