part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

/// Action state class for Actionable Events
abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

/// For building loading ui till fetching data
class HomeLoadingState extends HomeState {}

/// For building list of data after fetching data
class HomeLoadedSucessState extends HomeState {
  final List<ProductDataModel> product;
  HomeLoadedSucessState({required this.product});
}

/// For building error ui if any error occurs
class HomeErrorState extends HomeState {}

/// For Navigating from home page to Wishlist page
class HomeNavigateToWishlistPageActionState extends HomeActionState {}

/// For Navigating from home page to cart page
class HomeNavigateToCartPageActionState extends HomeActionState {}

class HomePageItemWishListedActionState extends HomeActionState {}

class HomePageItemCartListedActionState extends HomeActionState {}



