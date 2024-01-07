import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/data/models/companies_model.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/all_company_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/companies_cubit/companies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllCompaniesView extends StatelessWidget {
  const AllCompaniesView({super.key, required this.companiesModel});

  final CompaniesModel companiesModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Transform.rotate(
                  angle: 3,
                  child: Icon(
                    Icons.arrow_back,
                    color: AppColors.kASDCPrimaryColor,
                    size: 25.w,
                  )))
        ],
        centerTitle: true,
        title: Text(
          'الشركـــــــــــات',
          style: TextStyles.textStyle16.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SizedBox(
        height: 200.h,
        child: Column(
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: companiesModel.companies!.length,
                itemBuilder: (context, index) {
                  return AllCompanyContainer(
                    company: companiesModel.companies![index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
