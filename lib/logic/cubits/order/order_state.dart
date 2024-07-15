part of 'order_cubit.dart';

sealed class OrderState {
  double cartSum;

  OrderState(this.cartSum);
}

final class InitialOrderState extends OrderState {
  InitialOrderState(super.cartSum);
}

final class LoadingOrderState extends OrderState {
  LoadingOrderState(super.cartSum);
}

final class LoadedOrderState extends OrderState {
  List<Product> products;

  LoadedOrderState(super.cartSum, {required this.products});
}

final class ErrorOrderState extends OrderState {
  final String errorText;

  ErrorOrderState(super.cartSum, {required this.errorText});
}
