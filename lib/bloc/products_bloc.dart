import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:bloc_tutorial/models/products_model.dart';
import 'package:bloc_tutorial/repo/products_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsLoadedEvent, ProductsState> {
  final ProductsRepo productsRepo;
  ProductsBloc(this.productsRepo) : super(ProductsLoadingState()) {
    on<ProductsLoadedEvent>((event, emit) async {
      try {
        emit(ProductsLoadingState());
        var productsData = await productsRepo.getProducts();
        emit(ProductsLoadedState(productsData));
      } catch (e) {
        emit(ProductsErrorState(e.toString()));
        throw Exception("failed to load products");
      }
    });
  }
}
