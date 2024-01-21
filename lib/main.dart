import 'package:dinar_store/core/helpers/dio_helper.dart';
import 'package:dinar_store/core/utils/app_colors.dart';
import 'package:dinar_store/core/utils/app_routes.dart';
import 'package:dinar_store/core/utils/constants.dart';
import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/store_data_cubit/store_data_cubit.dart';
import 'package:dinar_store/features/home/data/services/ads_services.dart';
import 'package:dinar_store/features/home/data/services/cart_services.dart';
import 'package:dinar_store/features/home/data/services/categories_services.dart';
import 'package:dinar_store/features/home/data/services/companies_services.dart';
import 'package:dinar_store/features/home/data/services/sub_categories_services.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/bottom_nav_cubit.dart/cubit/bottton_nav_bar_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/cart_cubit/cubit/cart_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/categories_cubit/categories_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/companies_cubit/companies_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_categories_cubit/sub_categories_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_category_products_cubit/sub_category_product_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/sub_sub_categories_cubit/sub_sub_categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //check if device is mobile or tablet
    kIsTablet = MediaQuery.sizeOf(context).width >= 600;
    //set the status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: AppColors.kTransparent,
      ),
    );
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogInCubit(
              logInServices: LogInServices(
                  dioHelper: DioHelper(),
                  secureStorage: const FlutterSecureStorage())),
        ),
        BlocProvider(create: (context) => BottomNavBarCubit()),
        BlocProvider(
          create: (context) => CompaniesCubit(
              companiesServices: CompaniesServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => CategoriesCubit(
              categoriesServices: CategoriesServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => AdsCubit(
              adsServices: AdsServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => SubCategoriesCubit(
              subCategoriesServices: SubCategoriesServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => SubSubCategoriesCubit(
              subCategoriesServices: SubCategoriesServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => SubCategoryProductCubit(
              subCategoriesServices: SubCategoriesServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => CartCubit(
              cartServices: CartServices(
            dioHelper: DioHelper(),
          )),
        ),
        BlocProvider(
          create: (context) => StoreDataCubit(
              logInServices: LogInServices(
            dioHelper: DioHelper(),
            secureStorage: const FlutterSecureStorage(),
          )),
        ),
        BlocProvider(
          create: (context) => LogOutCubit(
              logInServices: LogInServices(
            dioHelper: DioHelper(),
            secureStorage: const FlutterSecureStorage(),
          )),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 811),
        minTextAdapt: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Dinar',
          theme: ThemeData(
            fontFamily: 'SegoeUI',
            scaffoldBackgroundColor: Colors.white,
            colorScheme:
                ColorScheme.fromSeed(seedColor: AppColors.kASDCPrimaryColor),
            useMaterial3: true,
          ),
          initialRoute: '/',
          routes: AppRoutes.routes,
        ),
      ),
    );
  }
}
