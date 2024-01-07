import 'package:dinar_store/core/animations/right_slide_transition.dart';
import 'package:dinar_store/core/utils/text_styles.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/all_companies_view.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/containers/company_container.dart';
import 'package:dinar_store/features/home/presentation/view/widgets/place_holders/companies_place_holder.dart';
import 'package:dinar_store/features/home/presentation/view_model/companies_cubit/companies_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  @override
  void initState() {
    context.read<CompaniesCubit>().getAllCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<CompaniesCubit, CompaniesState>(
      builder: (context, state) {
        if (state is CompaniesSuccess) {
          return SizedBox(
            height: 200.h,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'الشركـــــــــــات',
                      style: TextStyles.textStyle16
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Wrap(
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.end,
                  spacing: 10.w,
                  runSpacing: height / 3.3 / 20,
                  children: List.generate(
                    state.companiesModel.companies!.length < 8
                        ? state.companiesModel.companies!.length
                        : 8,
                    (index) {
                      state.companiesModel.companies![index].logo =
                          'https://pngfre.com/wp-content/uploads/Burger-45.png';
                      if (state.companiesModel.companies!.length > 7 &&
                          index == 4) {
                        return CompanyContainer(
                          index: index,
                          isMore: true,
                          companyName: 'عرض المزيد',
                          onTap: () {
                            Navigator.push(
                                context,
                                RightSlideTransition(
                                    page: AllCompaniesView(
                                  companiesModel: state.companiesModel,
                                )));
                          },
                        );
                      }
                      return CompanyContainer(
                        index: index,
                        companyName:
                            state.companiesModel.companies![index].companyName!,
                        compantIconImage:
                            state.companiesModel.companies![index].logo!,
                        onTap: () {},
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const CompaniesPlaceHolder();
      },
    );
  }
}
