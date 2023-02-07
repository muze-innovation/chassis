class QuickAccessItemOutput {
  final List<Item> item;
  QuickAccessItemOutput({required this.item});
  factory QuickAccessItemOutput.fromJson(Map<String, dynamic> data) {
    final item = (data['item'] as List<dynamic>?)
        ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
        .toList();
    if (item == null) {
      throw UnsupportedError('Invalid data: $data -> "title" is missing');
    }
    return QuickAccessItemOutput(item: item);
  }
}

class Item {
  final String title;
  final String asset;
  Item({required this.title, required this.asset});
  factory Item.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String?;
    final asset = data['asset'] as String?;
    if (title == null) {
      throw UnsupportedError('Invalid data: $data -> "title" is missing');
    }
    if (asset == null) {
      throw UnsupportedError('Invalid data: $data -> "asset" is missing');
    }
    return Item(title: title, asset: asset);
  }
}
