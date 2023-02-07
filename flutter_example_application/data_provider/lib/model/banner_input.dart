class BannerInput {
  final String slug;
  BannerInput({required this.slug});
  factory BannerInput.fromJson(Map<String, dynamic> data) {
    final slug = data['slug'] as String?;
    if (slug == null) {
      throw UnsupportedError('Invalid data: $data -> "title" is missing');
    }
    return BannerInput(slug: slug);
  }
}
