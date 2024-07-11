part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent{}

class CartRemoveCartItemsEvent extends CartEvent{
  final ProductDataModel cartItem;
  CartRemoveCartItemsEvent({required this.cartItem});
}
