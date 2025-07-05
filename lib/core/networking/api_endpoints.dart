class  ApiEndpoints {
  static const String baseUrl =
      "https://medeasy-backend-cgetg3arfvgfcjcq.westcentralus-01.azurewebsites.net/api";
  static const String login = "/users/login";
  static const String refreshToken = "/users/refresh";
  static const String register = "/users/register";
  static const String getUser = "/users/one/";
  static const String getAppointments = "/appointments";
  static const String getAdvices = "/advices/";
  static const String getAdvertisements = "/advertisements";

  static const String getDoctors = "/users/doctors";

  static String createAppointment(id) => "/appointments/doctor/$id";
  static String deleteAdvertisement(id) => "/advertisements/$id";

   // 👉 Advice Endpoints
  static const String getAllAdvices = '/advices/';
  static const String createAdvice = '/advices/';
  static const String createFullAdvice = '/advices/'; // نفس create العادي
  static const String createDislike = '/advices/dislike';
  static const String updateAdvice = '/advices/'; // زائد ID ديناميك في الريبو
  static const String deleteAdvice = '/advices/'; // زائد ID ديناميك في الريبو
}
