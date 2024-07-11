import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:grocery_app_using_bloc/data/cart_list_data.dart';
import 'package:grocery_app_using_bloc/data/grocery_data.dart';
import 'package:grocery_app_using_bloc/data/wishlist_data.dart';
import 'package:grocery_app_using_bloc/features/home/data_model/home_data_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }
  /// Imp section where list is rendered from data to home screen by mapping data to product model
  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));

    /*// Ensure no null values are assigned to String variables
    final products = GroceryData.data.map((e) {
      final id = e['id'];
      final name = e['name'];
      final description = e['description'];
      final price = e['price'];
      final imageUrl = e['imageUrl'];

      // Validate each value before using it
      if (id == null || name == null || description == null || price == null || imageUrl == null) {
        throw Exception('Null value encountered in data');
      }

      return ProductDataModel(
        id: id as String,
        name: name as String,
        description: description as String,
        price: price as int,
        imgUrl: imageUrl as String,
      );
    }).toList();
    
    emit(HomeLoadedSucessState(product: products));*/

    emit(HomeLoadedSucessState(
        product: GroceryData.data
            .map((e) {
          final id = e['id'] as String?;
          final name = e['name'] as String?;
          final description = e['description'] as String?;
          final price = e['price'];
          final imageUrl = e['imageUrl'] as String?;

          return ProductDataModel(
            id: id ?? '', // Provide default value if null
            name: name ?? '', // Provide default value if null
            description: description ?? '', // Provide default value if null
            price: (price is int ? price.toDouble() : price) ?? 0.0, // Provide default value if null
            imgUrl: imageUrl ?? '', // Provide default value if null
          );
        }).toList()));

  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Wishlist button clicked');
    wishListItems.add(event.clickedProduct);
    emit(HomePageItemWishListedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    print('Cart button clicked');
    cartListItems.add(event.clickedProduct);
    print(cartListItems);
    emit(HomePageItemCartListedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }
}
