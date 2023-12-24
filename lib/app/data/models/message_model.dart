import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  String? id;
  String? sender;
  String? message;
  bool? isSeen;
  DateTime? createdAt;

  MessageModel({
    required this.id,
    required this.sender,
    required this.message,
    required this.isSeen,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'sender': sender,
      'message': message,
      'isSeen': isSeen,
      'createdAt': Timestamp.fromDate(createdAt!),
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] != null ? json['id'] as String : null,
      sender: json['sender'] != null ? json['sender'] as String : null,
      message: json['message'] != null ? json['message'] as String : null,
      isSeen: json['isSeen'] != null ? json['isSeen'] as bool : null,
      createdAt: json['createdAt'] != null
          ? (json['createdAt'] as Timestamp).toDate()
          : null,
    );
  }
}
