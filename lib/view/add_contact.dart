import 'package:flutter/material.dart';
import 'package:latihan_firebase/controller/contact_controller.dart';
import 'package:latihan_firebase/model/contact_model.dart';
import 'package:latihan_firebase/view/contact.dart';

class AddContact extends StatefulWidget {

    // Konstruktor untuk widget AddContact
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {

    // Membuat instance dari ContactController
  var contatcController = ContactController();

    // Membuat GlobalKey untuk form
  final formkey = GlobalKey<FormState>();


  // Variabel untuk menyimpan input dari pengguna
  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                 // Input field untuk nama
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    name = value;
                  },
                ),
                // Input field untuk nomor telepon
                TextFormField(
                  decoration: InputDecoration(hintText: 'Phone'),
                  onChanged: (value) {
                    phone = value;
                  },
                ),
                // Input field untuk email
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                // Input field untuk alamat
                TextFormField(
                  decoration: InputDecoration(hintText: 'Address'),
                  onChanged: (value) {
                    address = value;
                  },
                ),
                // Tombol untuk menambahkan kontak
                ElevatedButton(
                  child: const Text('Add Contact'),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {

                      // Membuat objek ContactModel dari input pengguna
                      ContactModel cm = ContactModel(
                          name: name!,
                          phone: phone!,
                          email: email!,
                          address: address!);

                      // Memanggil metode addContact dari ContactController
                      contatcController.addContact(cm);

                      // Menampilkan pesan sukses
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Contact Added')));

                      // Mengarahkan pengguna ke halaman Contact setelah menambahkan kontak
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Contact()));
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}