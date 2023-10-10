import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latihan_firebase/controller/contact_controller.dart';
import 'package:latihan_firebase/view/add_contact.dart';
import 'package:latihan_firebase/view/login.dart';
import 'package:latihan_firebase/view/update_contact.dart';

import '../controller/auth_controller.dart';

class Contact extends StatefulWidget {

    // Konstruktor untuk widget Contact
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {

  // Membuat instance dari ContactController
  var cc = ContactController();

  // Membuat instance dari AuthController
  final authctrl = AuthController();
  @override
  void initState() {
    super.initState();

    // Mengambil daftar kontak saat widget diinisialisasi
    cc.getContact();  
    
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Tombol logout di pojok kanan atas
        actions: [IconButton(onPressed: (){

          // Logout pengguna saat tombol logout ditekan
          FirebaseAuth.instance.signOut();

          // Navigasi kembali ke halaman login
          Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => LoginPage()),
);

        }, icon: Icon(Icons.logout_rounded))],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Contact List',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: cc.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // Menampilkan indikator loading jika data belum tersedia
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final List<DocumentSnapshot> data = snapshot.data!;
                  // Membangun daftar kontak menggunakan ListView.builder
                   return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onLongPress: () {
                            // Navigasi ke halaman UpdateContact ketika kontak ditekan lama
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateContact(
                                          beforenama:
                                              data[index]['name'].toString(),
                                          beforephone:
                                              data[index]['phone'].toString(),
                                          beforeemail:
                                              data[index]['email'].toString(),
                                          beforeaddress:
                                              data[index]['address'].toString(),
                                          id: data[index]['id'].toString(),
                                        )));
                          },
                          child: Card(
                            elevation: 10,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  data[index]['name']
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(data[index]['name']),
                              subtitle: Text(data[index]['phone']),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),

                                // Menghapus kontak ketika tombol hapus ditekan
                                onPressed: () {
                                  cc
                                      .deleteContact(
                                          data[index]['id'].toString())
                                      .then((value) {
                                    setState(() {

                                      // Memperbarui daftar kontak setelah penghapusan
                                      cc.getContact();
                                    });
                                  });

                                  // Menampilkan pesan sukses
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Contact Deleted')));
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddContact()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  
}
