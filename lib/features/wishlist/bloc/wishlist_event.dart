part of 'wishlist_bloc.dart';

@immutable
sealed class WishlistEvent {}

class WishlistInitialEvent extends WishlistEvent{}

class WishlistRemoveItemEvent extends WishlistEvent{
  final ProductDataModel likedItem;
  WishlistRemoveItemEvent({required this.likedItem});
}
