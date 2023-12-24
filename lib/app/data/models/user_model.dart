// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends Equatable {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? fullname;
  @HiveField(2)
  String? email;
  @HiveField(3)
  String? photoUrl;

  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.photoUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'photoUrl': photoUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] != null ? json['id'] as String : null,
      fullname: json['fullname'] != null ? json['fullname'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      photoUrl: json['photoUrl'] != null ? json['photoUrl'] as String : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        fullname,
        email,
        photoUrl,
      ];
}
