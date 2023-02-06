import 'dart:convert';

import 'package:http/http.dart';

abstract class IProductRepository {
  Future<Map<String, dynamic>> getProcutReccomend();
}

class ProductRepository implements IProductRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://00b802ba-b85b-4531-ad60-1ad30116d1cd.mock.pstmn.io';

  @override
  Future<Map<String, dynamic>> getProcutReccomend() async {
    final url = Uri.parse('$_baseUrl/product/Recommend');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      // throw Exception('Failed to load Chassis API');
      return {
        "item": [
          {
            "title": "Beef Wellington",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_beef_wellington.png?alt=media&token=4d99d725-7339-4614-ad82-2457a0d5a53e"
          },
          {
            "title": "มาม่าผัดขี้เมาไฟลุก",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_fried_noodles.png?alt=media&token=9c31eab9-d377-456d-b6cb-5ce807f1f0df"
          },
          {
            "title": "เขียง",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_keang.png?alt=media&token=20c6724f-151c-4e6e-9128-3f20849608d9"
          },
          {
            "title": "ไข่เจียวปูเจ๊ใฝ",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_omelet.png?alt=media&token=51926881-c612-42c4-b128-a77d64368fe6"
          },
          {
            "title": "Pizza Home",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_pizza_home.png?alt=media&token=64b7a113-7e72-4fbc-8f84-d3e7cd8c1d97"
          },
          {
            "title": "ย่างให้",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_roast_beef.png?alt=media&token=c3ac807b-df9f-4f62-8629-97774bdfab16"
          },
          {
            "title": "Beef Wellington 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_beef_wellington.png?alt=media&token=4d99d725-7339-4614-ad82-2457a0d5a53e"
          },
          {
            "title": "มาม่าผัดขี้เมาไฟลุก 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_fried_noodles.png?alt=media&token=9c31eab9-d377-456d-b6cb-5ce807f1f0df"
          },
          {
            "title": "เขียง 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_keang.png?alt=media&token=20c6724f-151c-4e6e-9128-3f20849608d9"
          },
          {
            "title": "ไข่เจียวปูเจ๊ใฝ 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_omelet.png?alt=media&token=51926881-c612-42c4-b128-a77d64368fe6"
          },
          {
            "title": "Pizza Home 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_pizza_home.png?alt=media&token=64b7a113-7e72-4fbc-8f84-d3e7cd8c1d97"
          },
          {
            "title": "ย่างให้ 2",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_roast_beef.png?alt=media&token=c3ac807b-df9f-4f62-8629-97774bdfab16"
          },
          {
            "title": "Beef Wellington 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_beef_wellington.png?alt=media&token=4d99d725-7339-4614-ad82-2457a0d5a53e"
          },
          {
            "title": "มาม่าผัดขี้เมาไฟลุก 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_fried_noodles.png?alt=media&token=9c31eab9-d377-456d-b6cb-5ce807f1f0df"
          },
          {
            "title": "เขียง 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_keang.png?alt=media&token=20c6724f-151c-4e6e-9128-3f20849608d9"
          },
          {
            "title": "ไข่เจียวปูเจ๊ใฝ 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_omelet.png?alt=media&token=51926881-c612-42c4-b128-a77d64368fe6"
          },
          {
            "title": "Pizza Home 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_pizza_home.png?alt=media&token=64b7a113-7e72-4fbc-8f84-d3e7cd8c1d97"
          },
          {
            "title": "ย่างให้ 3",
            "asset":
                "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_recommend%2Fproduct_roast_beef.png?alt=media&token=c3ac807b-df9f-4f62-8629-97774bdfab16"
          }
        ]
      };
    }
  }
}
