import 'package:bloc_tutorial/models/products_model.dart';
import 'package:http/http.dart' as http;

class ProductsRepo {
  Future<List<ProductsModel>> getProducts() async {
    var response =
        await http.get(Uri.parse('https://fakestoreapi.com/products/'));
    if (response.statusCode == 200) {
      // emit(ProductsLoadedState());
      return productsModelFromJson(response.body);
    } else {
      throw Exception("failed to load products");
    }
  }
}
