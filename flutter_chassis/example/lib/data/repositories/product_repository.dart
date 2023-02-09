import '../../utils/readability.dart';

mixin IProductRepository {
  Future<dynamic> getData();
}

class ProductRepository implements IProductRepository {
  @override
  Future<dynamic> getData() async {
    final products =
        await Readability.readFrom('assets/products.json').then((data) {
      return data;
    });
    return Future.delayed(const Duration(seconds: 3)).then((value) => products);
  }
}
