// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

//digunakan untuk merepresentasikan objek User
class UserModel {

    // Variabel untuk menyimpan nama, email, dan ID pengguna
  String name;
  String email;
  String uId;

    // Konstruktor untuk membuat objek UserModel
  UserModel({
    required this.name,
    required this.email,
    required this.uId,
  });


  // Metode untuk mengonversi objek UserModel ke bentuk Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uId': uId,
    };
  }


  // Factory method untuk membuat objek UserModel dari Map<String, dynamic>
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uId: map['uId'] as String,
    );
  }


  // Metode untuk mengonversi objek UserModel ke bentuk JSON
  String toJson() => json.encode(toMap());


  // Factory method untuk membuat objek UserModel dari string JSON
  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);


  // Factory method untuk membuat objek UserModel dari objek Firebase User
  static UserModel? fromFirebaseUser(User user) {}
}
