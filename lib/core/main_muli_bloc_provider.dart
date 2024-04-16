import 'package:dinar_store/features/home/data/services/location_service.dart';
import 'package:dinar_store/core/helpers/dio_helper.dart';

import 'package:dinar_store/features/auth/data/services/log_in_services.dart';
import 'package:dinar_store/features/auth/presentation/view_model/location_cubit/cubit/location_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/log_out_cubit/log_out_cubit.dart';
import 'package:dinar_store/features/auth/presentation/view_model/store_data_cubit/store_data_cubit.dart';
import 'package:dinar_store/features/home/data/services/ads_services.dart';
import 'package:dinar_store/features/home/data/services/orders_services.dart';
import 'package:dinar_store/features/home/data/services/profile_services.dart';
import 'package:dinar_store/features/home/presentation/view_model/ads_cubit/ads_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_actions_cubit/agent_order_actions_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/agent_orders_cubit/agent_order_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/bottom_nav_cubit.dart/cubit/bottton_nav_bar_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/order_cubit/cubit/order_cubit.dart';
import 'package:dinar_store/features/home/presentation/view_model/profile_cubit/profile_cubit.dart';
import 'package:dinar_store/features/splash/presentation/view_model/manage_navigation_cubit/manage_navigation_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainMultiBlocProvider extends StatelessWidget {
  const MainMultiBlocProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ManageNavigationCubit(
            secureStorage: const FlutterSecureStorage(),
          ),
        ),
        BlocProvider(
          create: (context) => LogInCubit(
              logInServices: LogInServices(
                  dioHelper: DioHelper(),
                  secureStorage: const FlutterSecureStorage()),
              locationServices: LocationServices(dioHelper: DioHelper())),
        ),
        BlocProvider(create: (context) => BottomNavBarCubit()),
        BlocProvider(
          create: (context) => AdsCubit(
              adsServices: AdsServices(
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
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ProfileCubit(
            profileServices: ProfileServices(
              dioHelper: DioHelper(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => LocationCubit(
            locationServices: LocationServices(dioHelper: DioHelper()),
          ),
        ),
        BlocProvider(
          create: (context) => OrderCubit(
              ordersServices: OrdersServices(dioHelper: DioHelper())),
        ),
        BlocProvider(
          create: (context) => AgentOrderCubit(
              ordersServices: OrdersServices(dioHelper: DioHelper())),
        ),
        BlocProvider(
          create: (context) => AgentOrderActionsCubit(
              ordersServices: OrdersServices(dioHelper: DioHelper())),
        ),
      ],
      child: child,
    );
  }
}
