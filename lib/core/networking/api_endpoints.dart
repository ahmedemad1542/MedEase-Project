class ApiEndpoints {
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
  static const String getPatients = "/patient/all";

  static String createAppointment(id) => "/appointments/doctor/$id";
  static String deleteAdvertisement(id) => "/advertisements/$id";

  // 👉 Advice Endpoints
  static const String getAllAdvices = '/advices/';
  static const String createAdvice = '/advices/';
  static const String createFullAdvice = '/advices/'; // نفس create العادي
  static const String likeAdvice = "/advice/"; // زائد ID و '/like'
  static const String dislikeAdvice = "/advice/"; // زائد ID و '/dislike'

  static const String updateAdvice = '/advices/'; // زائد ID ديناميك في الريبو
  static const String deleteAdvice = '/advices/';
  static const String getCategories = '/diseasescategories/';

  // ✅ AI Chatbot Endpoints
  static const String aiStartSession = "/ai/start_session";
  static const String aiSendMessage = "/ai/send_message";
  static const String aiGetSymptoms = "/ai/symptoms"; // غالباً من local API

  static String deleteDoctor(id) => "/doctor/$id";
  static String updateDoctor(id) => "/doctor/$id";
  static String deletePatient(id) => "/patient/$id";
  static String updatePatient(id) => "/patient/$id";
}// زائد ID ديناميك في الريبو

