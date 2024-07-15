import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(InitialOrderState(0));
  List<Product> products = [];

  void getOrders() {
    try {
      emit(LoadingOrderState(state.cartSum));

      emit(
        LoadedOrderState(
          state.cartSum,
          products: products,
        ),
      );
    } catch (e) {
      emit(ErrorOrderState(state.cartSum, errorText: "Couldn't get orders."));
    }
  }

  void buy({
    required List<Product> cartProducts,
    required double sum,
  }) async {
    try {
      emit(LoadingOrderState(state.cartSum));
      products.addAll(cartProducts);
      emit(
        LoadedOrderState(
          sum,
          products: products,
        ),
      );
    } catch (e) {
      emit(ErrorOrderState(state.cartSum, errorText: "Couldn't buy."));
    }
  }
}
