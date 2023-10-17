import 'package:bloc_tutorial/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    context.read<ProductsBloc>().add(ProductsLoadedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products screen')),
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ProductsLoadedState) {
            return ListView.builder(
              itemCount: state.productsList.length,
              itemBuilder: (context, index) {
                var data = state.productsList[index];
                return Text(data.title);
              },
            );
          } else if (state is ProductsErrorState) {
            return Center(child: Text('error state'));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
