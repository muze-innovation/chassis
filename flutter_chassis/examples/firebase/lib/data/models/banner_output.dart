class BannerOutput {
  final String asset;
  final String placeholder;
  BannerOutput.fromJson(Map<String, dynamic> json)
      : asset = json['asset'],
        placeholder = json['placeholder'];
  Map<String, dynamic> toJson() {
    return {
      'asset': asset,
      'placeholder': placeholder,
    };
  }
}
