import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery_app_using_bloc/features/wishlist/bloc/wishlist_bloc.dart';
import 'package:grocery_app_using_bloc/features/wishlist/wishlist_product_tile.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistBloc, WishlistState>(
      bloc: wishlistBloc,
      listenWhen: (previous, current) => current is WishlistActionState,
      buildWhen: (previous, current) => current is !WishlistActionState,
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case WishlistSuccessState:
            final successState = state as WishlistSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Liked Items',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w600),
                ),
                backgroundColor: Colors.teal,
              ),
              body: ListView.builder(
                  itemCount: successState.wishlistItem.length,
                  itemBuilder: (context, index) {
                    return WishlistTileWidget(
                      productDataModel: successState.wishlistItem[index],
                      wishlistBloc: wishlistBloc,
                    );
                  }),
            );
          default:
            return const Center(
              child: Text('Your item list is empty'),
            );
        }
      },
    );
  }
}
