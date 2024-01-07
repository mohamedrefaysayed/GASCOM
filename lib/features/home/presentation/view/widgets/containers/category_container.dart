import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/categories_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/sub_category_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer(
      {super.key,
      required this.catName,
      required this.catDes,
      required this.subCategories});

  final String catName;
  final String catDes;

  final List<SubCategories> subCategories;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      color: AppColors.kWhite,
      child: Column(
        children: [
          Row(
            children: [
              TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 10.w,
                    color: Colors.grey,
                  ),
                  label: Text(
                    'عرض المزيد',
                    style: TextStyles.textStyle10.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.grey),
                  )),
              const Spacer(),
              SizedBox(
                width: 200.w,
                child: Text(
                  catName,
                  style: TextStyles.textStyle16
                      .copyWith(fontWeight: FontWeight.w700),
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 300.w,
                child: Text(
                  catDes,
                  style: TextStyles.textStyle12.copyWith(
                      fontWeight: FontWeight.w400, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          SizedBox(
            height: 220.h,
            child: subCategories.isEmpty
                ? Center(
                    child: Text(
                      'لا يوجد عناصر',
                      style: TextStyles.textStyle14,
                    ),
                  )
                : ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: subCategories.length,
                    itemBuilder: (context, index) {
                      subCategories[index].image =
                          'https://shoppermotion.com/wp-content/uploads/2020/12/20170322_100726-scaled-1.jpg';
                      return SubCategoryContainer(
                        subCategory: subCategories[index],
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
