import 'dart:async';
import 'dart:convert';

/// External library
import 'package:http/http.dart' show Client;

/// Internal library
import 'package:chassis/core.dart';

abstract class IChassisRepository {
  Future<dynamic> getData();
}

class ChassisRepository implements IChassisRepository {
  Client client = Client();

  static const String _baseUrl =
      'https://3f65e6d1-ab4c-44ae-a469-d4ca7553ccd3.mock.pstmn.io';

  Future<Iterable<ChassisItem>> getData() async {
    final url = Uri.parse('$_baseUrl/chassis');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final items = data['items'] as List<dynamic>?;
      if (items == null) {
        throw UnsupportedError('Invalid data: $data -> "items" is missing');
      }
      return items.map((e) => ChassisItem.fromJson(e));
    } else {
      final data = json;
      final items = data['items'] as List<dynamic>?;
      if (items == null) {
        throw UnsupportedError('Invalid data: $data -> "items" is missing');
      }
      return items.map((e) => ChassisItem.fromJson(e));
      // throw Exception('Failed to load Chassis API');
    }
  }
}

final json = {
  "version": "1.0.0",
  "name": "default-landing-page",
  "items": [
    {
      "id": "quick_access_menu",
      "viewType": "QuickAccess",
      "attributes": {"heightPolicy": "fixed", "heightValue": 200},
      "parameters": {"title": "Recommended categories"},
      "payload": {
        "type": "static",
        "data": {
          "item": [
            {
              "title": "ข้าวเหนียวไก่ยาง",
              "asset":
                  "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_category%2Fproduct_grilled_chicken.png?alt=media&token=40d1a407-167d-42e3-ab38-a6cffdee56fb"
            },
            {
              "title": "สลัดผักเพื่อสุขภาพ",
              "asset":
                  "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/product_category%2Fproduct_papaya_salad.png?alt=media&token=aa3b6e01-0723-41ae-9eb2-5cb042caaf7d"
            }
          ]
        }
      }
    },
    {
      "id": "promo_banner_mid_year",
      "viewType": "Banner",
      "attributes": {
        "heightPolicy": "ratio",
        "heightValue": "4:1",
        "color": "red"
      },
      "payload": {
        "type": "static",
        "data": {
          "asset":
              "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fchinese_food_4_1.png?alt=media&token=c418c922-13ab-48a9-ab87-612fd6c9a8eb",
          "placeholder":
              "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fplace_holder.png?alt=media&token=52ae3f33-ab3f-4118-82b3-0a86b4708ba9"
        }
      }
    },
    {
      "id": "quick_access_product",
      "viewType": "QuickAccess",
      "attributes": {"heightPolicy": "fixed", "heightValue": 200},
      "parameters": {"title": "Recommended product"},
      "payload": {"type": "remote", "resolvedWith": "GetQuickAccessItem"}
    },
    {
      "id": "promo_banner_mid_month",
      "viewType": "Banner",
      "attributes": {
        "heightPolicy": "ratio",
        "heightValue": "4:1",
        "color": "red"
      },
      "payload": {
        "type": "remote",
        "resolvedWith": "GetBanner",
        "input": {"slug": "best-seller"}
      }
    }
  ]
};
