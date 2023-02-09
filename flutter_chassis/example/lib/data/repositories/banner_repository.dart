mixin IBannerRepository {
  Future<dynamic> getData(String slug);
}

class BannerRepository implements IBannerRepository {
  @override
  Future<dynamic> getData(String slug) {
    return Future.delayed(const Duration(seconds: 3)).then((value) => {
          "asset":
              "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fpizza_4_1.png?alt=media&token=bb399238-8c46-4081-b472-5f6725c587ea",
          "placeholder":
              "https://firebasestorage.googleapis.com/v0/b/nattariit.appspot.com/o/banner%2Fplace_holder.png?alt=media&token=52ae3f33-ab3f-4118-82b3-0a86b4708ba9"
        });
  }
}
