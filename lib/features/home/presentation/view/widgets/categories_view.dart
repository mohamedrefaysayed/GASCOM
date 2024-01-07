import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/category_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/categories_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    context.read<CategoriesCubit>().getAllCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesSuccess) {
          return ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.categoriesModel.categories!.length,
              itemBuilder: (context, index) {
                final Categories category =
                    state.categoriesModel.categories![index];

                return CategoryContainer(
                  catName: category.categoryName!,
                  catDes: category.description!,
                  subCategories: category.subCategories!,
                );
              });
        }
        return const CategoriesPlaceHolder();
      },
    );
  }
}
