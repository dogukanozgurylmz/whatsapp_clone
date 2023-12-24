// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String? id;
  String? uid;
  String? name;
  String? photo;
  String? lastMessage;
  bool? isSeen;
  DateTime? lastDate;

  ChatModel({
    required this.id,
    required this.uid,
    required this.name,
    required this.photo,
    required this.lastMessage,
    required this.isSeen,
    required this.lastDate,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'photo': photo,
      'lastMessage': lastMessage,
      'isSeen': isSeen,
      'lastDate': Timestamp.fromDate(lastDate!),
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] != null ? json['id'] as String : null,
      uid: json['uid'] != null ? json['uid'] as String : null,
      name: json['name'] != null ? json['name'] as String : null,
      photo: json['photo'] != null ? json['photo'] as String : null,
      lastMessage:
          json['lastMessage'] != null ? json['lastMessage'] as String : null,
      isSeen: json['isSeen'] != null ? json['isSeen'] as bool : null,
      lastDate: json['lastDate'] != null
          ? (json['lastDate'] as Timestamp).toDate()
          : null,
    );
  }
}
