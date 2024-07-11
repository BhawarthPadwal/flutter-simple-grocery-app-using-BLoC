import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_using_bloc/features/cart/cart_page.dart';
import 'package:grocery_app_using_bloc/features/home/bloc/home_bloc.dart';
import 'package:grocery_app_using_bloc/features/home/home_product_tile.dart';
import 'package:grocery_app_using_bloc/features/wishlist/wishlist_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is !HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistPage()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        } else if (state is HomePageItemWishListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item LIKED!')));
        } else if (state is HomePageItemCartListedActionState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Item ADDED to CART!')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case HomeLoadedSucessState:
            final successState = state as HomeLoadedSucessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Grocery Shop',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateEvent());
                      },
                      icon: const Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.white,
                      )),
                ],
                backgroundColor: Colors.teal,
              ),
              body: ListView.builder(
                  itemCount: successState.product.length,
                  itemBuilder: (context, index) {
                return ProductTileWidget(productDataModel: successState.product[index], homeBloc: homeBloc,);
              }),
            );
          case HomeErrorState:
            return const Scaffold(
              body: Center(
                child: Text('Error'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }
}

