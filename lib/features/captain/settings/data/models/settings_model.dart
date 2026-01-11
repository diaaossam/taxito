class SettingsModel {
  SettingsModel({
    this.title,
    this.description,
    this.firstEmail,
    this.secondEmail,
    this.firstPhone,
    this.secondPhone,
    this.whatsappPhone,
    this.facebookLink,
    this.twitterLink,
    this.instagramLink,
    this.linkedinLink,
    this.snapchatLink,
    this.tiktokLink,
    this.youtubeLink,
    this.telegramLink,
    this.whatsappLink,
    this.pinterestLink,
    this.logo,
    this.userProfileImage,
    this.orderShippingCostPerKm,
    this.fetchRequiredAndroidVersion,
    this.fetchRequiredIosVersion,
    this.showCopyright,
  });

  SettingsModel.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    firstEmail = json['first_email'];
    secondEmail = json['second_email'];
    firstPhone = json['first_phone'];
    secondPhone = json['second_phone'];
    whatsappPhone = json['whatsapp_phone'];
    facebookLink = json['facebook_link'];
    twitterLink = json['twitter_link'];
    instagramLink = json['instagram_link'];
    linkedinLink = json['linkedin_link'];
    snapchatLink = json['snapchat_link'];
    tiktokLink = json['tiktok_link'];
    youtubeLink = json['youtube_link'];
    telegramLink = json['telegram_link'];
    whatsappLink = json['whatsapp_link'];
    pinterestLink = json['pinterest_link'];
    logo = json['logo'];
    userProfileImage = json['user_profile_image'];
    orderShippingCostPerKm = json['order_shipping_cost_per_km'];
    fetchRequiredAndroidVersion = json['fetchRequiredAndroidVersion'] ?? "";
    fetchRequiredIosVersion = json['fetchRequiredIosVersion'] ?? "";
    showCopyright = json['show_copyright'] == 1;
  }

  String? title;
  String? description;
  String? firstEmail;
  dynamic secondEmail;
  String? firstPhone;
  dynamic secondPhone;
  String? whatsappPhone;
  String? facebookLink;
  String? twitterLink;
  String? instagramLink;
  String? linkedinLink;
  String? snapchatLink;
  String? tiktokLink;
  String? youtubeLink;
  String? telegramLink;
  String? whatsappLink;
  String? pinterestLink;
  String? logo;
  String? userProfileImage;
  num? orderShippingCostPerKm;
  String? fetchRequiredAndroidVersion;
  String? fetchRequiredIosVersion;
  bool? showCopyright;
}
