// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


//digunakan untuk merepresentasikan objek kontak
class ContactModel {
  
    // Variabel untuk menyimpan ID kontak (opsional) dan data kontak (wajib)
  String? id;
  final String name;
  final String phone;
  final String email;
  final String address;

    // Konstruktor untuk membuat objek ContactModel
  ContactModel({
    this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.address,
  });


  // Metode untuk mengonversi objek ContactModel ke bentuk Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'address': address,
    };
  }


  // Factory method untuk membuat objek ContactModel dari Map<String, dynamic>
  factory ContactModel.fromMap(Map<String, dynamic> map) {
    return ContactModel(
      id: map['id'],
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      email: map['email'] ?? '',
      address: map['address'] ?? '',
    );
  }


  // Metode untuk mengonversi objek ContactModel ke bentuk JSON
  String toJson() => json.encode(toMap());


  // Factory method untuk membuat objek ContactModel dari string JSON
  factory ContactModel.fromJson(String source) =>
      ContactModel.fromMap(json.decode(source));
}
