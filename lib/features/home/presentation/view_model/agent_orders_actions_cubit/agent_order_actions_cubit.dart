import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/services/orders_services.dart';

part 'agent_order_actioms_state.dart';

class AgentOrderActionsCubit extends Cubit<AgentOrderActionsState> {
  AgentOrderActionsCubit({required OrdersServices ordersServices})
      : super(OrderInitial()) {
    _ordersServices = ordersServices;
  }

  late OrdersServices _ordersServices;

  approveOrder({required String orderId}) async {
    emit(ApproveOrderActionsLoading(orderId: orderId));
    Either<ServerFailure, void> result = await _ordersServices.approveOrder(
      token: AppCubit.token!,
      orderId: orderId,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          ApproveOrdersActionsFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (_) async {
        emit(ApproveOrderActionsSuccess());
      },
    );
  }

  rejectOrder({required String orderId}) async {
    emit(RejectOrderActionsLoading(orderId: orderId));
    Either<ServerFailure, void> result = await _ordersServices.rejectOrder(
      token: AppCubit.token!,
      orderId: orderId,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          RejectOrderActionsFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (_) async {
        emit(RejectOrderActionsSuccess());
      },
    );
  }

  deleverOrder({required String orderId}) async {
    emit(DeleverOrderActionsLoading());
    Either<ServerFailure, void> result = await _ordersServices.deleverOrder(
      token: AppCubit.token!,
      orderId: orderId,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          DeleverOrderActionsFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (_) async {
        emit(DeleverOrderActionsSuccess());
      },
    );
  }
}
