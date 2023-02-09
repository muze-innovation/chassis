import '../../utils/readability.dart';

mixin IProductRepository {
  Future<dynamic> getData();
}

class ProductRepository implements IProductRepository {
  @override
  Future<dynamic> getData() {
    return Readability.readFrom('assets/product.json').then((data) {
      if (data == null) {
        throw UnsupportedError('Invalid data: $data -> "data" is missing');
      }
      return data;
    });
  }
}
