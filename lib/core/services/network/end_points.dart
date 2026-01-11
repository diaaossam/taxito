class EndPoints {
  ///////// Auth ////////////////////////

  static const String mapSuggestions =
      "https://api.mapbox.com/search/searchbox/v1/suggest";
  static const String placeLocation =
      "https://api.mapbox.com/search/searchbox/v1/retrieve";
  static const String addressBaseUrl =
      "https://api.mapbox.com/geocoding/v5/mapbox.places";
  static const String profile = "profile/me";

  static getUserByUid(String ulid) => 'auth/user/$ulid';
  static const String endTrip = "driver/end-trip/";
  static const String governorates = "provinces";

  static const String loginUser = "auth/login";
  static const String socialLogin = "auth/social";
  static const String cancelTrip = "driver/cancel-trip/";
  static const String toggleAvailabilty = "driver/availability";
  static const String driverAcceptPayment = "driver/accept-payment-request/";
  static const String updateDriverLocation = "driver/current-location";
  static const String orders = "driver/orders";
  static const String pendingOrders = "driver/pending-orders";

  static const String verifyUser = "auth/verify-otp";
  static const String acceptTrip = "driver/accept-trip";
  static const String rejectTrip = "driver/reject-trip";

  static updateUserRegister(String ulid) => "auth/update/$ulid";
  static String logOut = "profile/logout";
  static String deleteUser = "profile/delete-account";

  ///////// Public ////////////////////////

  static const String introOnBoarding = "intro-images";
  static const String uploadImage = "temp-media";

  static deleteImage(String uid) => "profile/delete-image$uid";
  static const String sliders = "banners";
  static const String categories = "supplier-categories";
  static const String brands = "brands";
  static const String skinProblem = "skin-problems";

  static const String provinces = "provinces";
  static const String region = "regions";

  //////////////////////////// Notification //////////////////
  static const String notfications = "notification";
  static const String updateNotfications = "profile/update-notification";
  static const String notificationCount = "notification-count";
  static const String markAllAsRead = "mark-all-notifications-as-read";

  ///////// Register //////////////////

  static const String register = "driver/profile";

  //////////////////// Users /////////////////////////////
  static user(String userId) => 'users/$userId';
  static const String language = "profile/language";
  static const String explore = "explore";
  static const String deletionReasons = "deletion-reasons";

  static const String block = "blocklists";
  static const String report = "report-types";

  static pages(String id) => "pages/$id";
  static const String faqQuestions = "faq-questions";
  static const String appSettings = "app-settings";

  //////////////////// Trip ///////////////////////
  static String updateFcm = "profile/update-device-token";
  static String getTripById = "driver/trips";
  static String sendChat = "driver/chats";
  static String statistics = "driver/statistics";
  static String acceptOrder = "driver/accept-order";
  static String rejectOrder = "driver/reject-order";
  static const String pendingTrips = "driver/current-trip";
  static const String supportChat = "support-chat";

  static const String supplierAcceptPayment =
      "supplier/accept-payment-request/";

  //////////////////// Trip ///////////////////////
  static const String supplierCategories = "supplier-categories";
  static const String supplierCategoriesV2 = "supplier/categories";
  static const String supplierAttributes = "supplier/attributes";
  static const String products = "supplier/products";
}
