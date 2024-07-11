import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_using_bloc/data/cart_list_data.dart';
import 'package:meta/meta.dart';

import '../../home/data_model/home_data_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveCartItemsEvent>(cartRemoveCartItemsEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartList: cartListItems));
  }

  FutureOr<void> cartRemoveCartItemsEvent(
      CartRemoveCartItemsEvent event, Emitter<CartState> emit) {
    cartListItems.remove(event.cartItem);
    emit(CartSuccessState(cartList: cartListItems));
  }
}
