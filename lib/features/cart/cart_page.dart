import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_using_bloc/features/cart/bloc/cart_bloc.dart';
import 'package:grocery_app_using_bloc/features/cart/cart_product_tile.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
          bloc: cartBloc,
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is !CartActionState,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartSuccessState:
                final successState = state as CartSuccessState;
                return Scaffold(
                  appBar: AppBar(
                    title: const Text(
                      'Cart Items',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  body: ListView.builder(
                      itemCount: successState.cartList.length,
                      itemBuilder: (context, index) {
                        return CartTileWidget(
                          productDataModel: successState.cartList[index],
                          cartBloc: cartBloc,
                        );
                      }),
                );
              default:
                return const Center(
                  child: Text('Your cart is empty'),
                );
            }
          },
        );
  }
}
