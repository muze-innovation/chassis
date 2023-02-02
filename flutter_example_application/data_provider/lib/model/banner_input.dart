class BannerInput {
  final Input input;

  BannerInput(this.input);
  Map<String, dynamic> toJson() => {'input': input};
  BannerInput.fromJson(Map<String, dynamic> json)
      : input = Input.fromJson(json['input']);
}

class Input {
  final String slug;
  Input(this.slug);
  Map<String, dynamic> toJson() => {'slug': slug};
  Input.fromJson(Map<String, dynamic> json) : slug = json['slug'];
}
