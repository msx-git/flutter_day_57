part of 'cart_cubit.dart';

sealed class CartState {
  double cartSum;

  CartState(this.cartSum);
}

final class InitialCartState extends CartState {
  InitialCartState(super.cartSum);
}

final class LoadingCartState extends CartState {
  LoadingCartState(super.cartSum);
}

final class LoadedCartState extends CartState {
  List<Product> products;

  LoadedCartState(super.cartSum, {required this.products});
}

final class ErrorCartState extends CartState {
  final String errorText;

  ErrorCartState(super.cartSum, {required this.errorText});
}
