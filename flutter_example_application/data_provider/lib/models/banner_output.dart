class BannerOutput {
  BannerOutput({required this.title, required this.asset});

  final String title;
  final String asset;

  factory BannerOutput.fromJson(Map<String, dynamic> data) {
    final title = data['title'] as String?;
    final asset = data['asset'] as String?;
    if (title == null) {
      throw UnsupportedError('Invalid data: $data -> "title" is missing');
    }
    if (asset == null) {
      throw UnsupportedError('Invalid data: $data -> "asset" is missing');
    }
    return BannerOutput(title: title, asset: asset);
  }

  Map<String, dynamic> toJson() {
    return {'title': title, 'asset': asset};
  }
}
