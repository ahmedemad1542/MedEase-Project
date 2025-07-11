class ConversationModel {
  final String id;
  final List<String> members; 

  ConversationModel({required this.id, required this.members});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      members: List<String>.from(json['members']),
    );
  }
}