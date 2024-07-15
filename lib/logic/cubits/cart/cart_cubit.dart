import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(InitialCartState(0));
  List<Product> products = [];

  void getCartProducts() {
    try {
      emit(LoadingCartState(state.cartSum));

      emit(
        LoadedCartState(
          state.cartSum,
          products: products,
        ),
      );
    } catch (e) {
      emit(ErrorCartState(state.cartSum,
          errorText: "Couldn't get cart products."));
    }
  }

  void addToCart({
    required String id,
    required String title,
    required double price,
    required String imageUrl,
  }) async {
    try {
      emit(LoadingCartState(state.cartSum));

      products.add(Product(
        id: id,
        title: title,
        price: price,
        imageUrl: imageUrl,
      ));
      emit(
        LoadedCartState(
          state.cartSum + price,
          products: products,
        ),
      );
    } catch (e) {
      emit(ErrorCartState(state.cartSum, errorText: "Couldn't add to cart."));
    }
  }

  void clearCart() {
    emit(LoadingCartState(state.cartSum));
    products = [];
    emit(LoadedCartState(0, products: products));
  }
}
