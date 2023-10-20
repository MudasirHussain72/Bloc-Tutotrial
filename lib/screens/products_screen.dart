import 'package:bloc_tutorial/bloc/products_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
      // body: BlocBuilder<ProductsBloc, ProductsState>(
      //   builder: (context, state) {
      //     if (state is ProductsLoadingState) {
      //       return const Center(child: CircularProgressIndicator.adaptive());
      //     } else if (state is ProductsLoadedState) {
      //       return ListView.builder(
      //         itemCount: state.productsList.length,
      //         itemBuilder: (context, index) {
      //           var data = state.productsList[index];
      //                 return ListTile(title: Text(data.title));
      //         },
      //       );
      //     } else if (state is ProductsErrorState) {
      //       return Center(child: Text('error state'));
      //     } else {
      //       return SizedBox();
      //     }
      //   },
      // ),

      // body: BlocListener<ProductsBloc, ProductsState>(
      //     listener: (context, state) {
      //       if (state is ProductsLoadedState) {
      //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //             duration: Duration(seconds: 1),
      //             content: Text('data loaded')));
      //       } else if (state is ProductsErrorState) {
      //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //             duration: Duration(seconds: 1),
      //             content: Text('data not loaded')));
      //       }
      //     },
      //     child: Center(
      //         child: Text(
      //             'The bloc listener widget is used as an observer. It requires a listener function and an optional child. It does not build or rebuild UI, but can be used to react to state changes by calling functionalities such as toasts, alert dialogs, or just executing functions.'))),

      //BlocConsumer exposes a builder and listener in order react to new states
      body: BlocConsumer<ProductsBloc, ProductsState>(
        listener: (context, state) {
          if (state is ProductsLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 1), content: Text('data loaded')));
          } else if (state is ProductsErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 1),
                content: Text('data not loaded')));
          }
        },
        builder: (context, state) {
          if (state is ProductsLoadingState) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is ProductsLoadedState) {
            return SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(12),
                child: StaggeredGrid.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: List.generate(state.productsList.length, (index) {
                    if (index == 0) {
                      // Display text before the first column
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 0.5,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: FractionallySizedBox(
                            widthFactor: 0.9, // Adjust as needed
                            child: Padding(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "${state.productsList.length} products found",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Display grid items for the second column
                      return StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount:
                            index == 4 ? 3 : 1, // Adjusted mainAxisCellCount
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: state.productsList[index - 1].image,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    }
                  }),
                ),
              ),
            );
          } else if (state is ProductsErrorState) {
            return const Center(child: Text('error state'));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
