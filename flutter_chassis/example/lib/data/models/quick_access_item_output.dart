class QuickAccessOutput {
  final Iterable<QuickAccessItem> item;
  QuickAccessOutput.fromJson(Map<String, dynamic> json)
      : item = (json['item'] as List<dynamic>)
            .map((e) => QuickAccessItem.fromJson(e));
  Map<String, dynamic> toJson() {
    return {
      'item': item.map((e) => e.toJson()),
    };
  }
}

class QuickAccessItem {
  final String title;
  final String asset;
  QuickAccessItem.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        asset = json['asset'];
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'asset': asset,
    };
  }
}
