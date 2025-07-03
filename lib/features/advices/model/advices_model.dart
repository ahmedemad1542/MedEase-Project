class AdvicesModel {
  String diseasesCategoryName;
  String doctorName;
  String id;
  String title;
  String description;
  String imgUrl;
  String imgPublicId;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int likesCount;
  int dislikesCount;

  AdvicesModel({
    required this.diseasesCategoryName,
    required this.doctorName,
    required this.id,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.imgPublicId,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.likesCount,
    required this.dislikesCount,
  });

  factory AdvicesModel.fromJson(Map<String, dynamic> json) => AdvicesModel(
    diseasesCategoryName: json["diseasesCategoryName"],
    doctorName: json["doctorName"] ?? "",
    id: json["_id"] ?? "",
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    imgUrl: json["ImgUrl"] ?? "",
    imgPublicId: json["ImgPublicId"] ?? "",
    createdAt: DateTime.parse(json["createdAt"] ?? ""),
    updatedAt: DateTime.parse(json["updatedAt"] ?? ""),
    v: json["__v"] ?? 0,
    likesCount: json["likesCount"] ?? 0,
    dislikesCount: json["dislikesCount"] ?? 0,
  );
}
