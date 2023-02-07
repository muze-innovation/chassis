class BannerOutput {
  final String asset;
  final String placeholder;
  BannerOutput({required this.asset, required this.placeholder});
  factory BannerOutput.fromJson(Map<String, dynamic> data) {
    final asset = data['asset'] as String?;
    final placeholder = data['placeholder'] as String?;
    if (asset == null) {
      throw UnsupportedError('Invalid data: $data -> "title" is missing');
    }
    if (placeholder == null) {
      throw UnsupportedError('Invalid data: $data -> "asset" is missing');
    }
    return BannerOutput(asset: asset, placeholder: placeholder);
  }
}
