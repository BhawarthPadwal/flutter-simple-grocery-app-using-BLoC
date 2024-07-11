import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_using_bloc/data/wishlist_data.dart';
import 'package:grocery_app_using_bloc/features/home/data_model/home_data_model.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<WishlistRemoveItemEvent>(wishlistRemoveItemEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistSuccessState(wishlistItem: wishListItems));
  }

  FutureOr<void> wishlistRemoveItemEvent(
      WishlistRemoveItemEvent event, Emitter<WishlistState> emit) {
    wishListItems.remove(event.likedItem);
    emit(WishlistSuccessState(wishlistItem: wishListItems));
  }
}
