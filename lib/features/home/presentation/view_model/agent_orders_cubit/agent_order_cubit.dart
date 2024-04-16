import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:dinar_store/core/cubits/app_cubit/cubit/app_cubit_cubit.dart';
import 'package:dinar_store/core/errors/server_failure.dart';
import 'package:dinar_store/features/home/data/models/orders_model.dart';
import 'package:dinar_store/features/home/data/models/suppliers_model.dart';
import 'package:dinar_store/features/home/data/services/orders_services.dart';

part 'agent_order_state.dart';

class AgentOrderCubit extends Cubit<AgentOrderState> {
  AgentOrderCubit({required OrdersServices ordersServices})
      : super(OrderInitial()) {
    _ordersServices = ordersServices;
  }

  late OrdersServices _ordersServices;

  static OrdersModel? agentOrdersModel;

  getAllAgentOrders() async {
    agentOrdersModel == null ? emit(GetagentsOrdersLoading()) : null;
    Either<ServerFailure, OrdersModel> result =
        await _ordersServices.getAllAgentOrders(
      token: AppCubit.token!,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          GetagentsOrdersFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (ordersmodel) async {
        ordersmodel.orders = ordersmodel.orders!.reversed.toList();
        agentOrdersModel = ordersmodel;
        emit(GetagentsOrdersSuccess(ordersModel: ordersmodel));
      },
    );
  }

  changePrice({required String newPrice}) async {
    emit(ChangePriceLoading());
    Either<ServerFailure, void> result = await _ordersServices.changePrice(
      token: AppCubit.token!,
      newPrice: newPrice,
    );

    result.fold(
      //error
      (serverFailure) {
        emit(
          ChangePriceFailuer(errMessage: serverFailure.errMessage),
        );
      },
      //success
      (_) async {
        emit(ChangePriceSuccess());
      },
    );
  }
}
