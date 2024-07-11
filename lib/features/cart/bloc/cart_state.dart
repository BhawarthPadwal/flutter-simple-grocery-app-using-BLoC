part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

abstract class CartActionState extends CartState {}

class CartSuccessState extends CartState {
  final List<ProductDataModel> cartList;
  CartSuccessState({required this.cartList});
}