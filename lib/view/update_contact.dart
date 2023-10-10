
import 'package:flutter/material.dart';

import '../controller/contact_controller.dart';
import '../model/contact_model.dart';
import 'contact.dart';

class UpdateContact extends StatefulWidget {

    // Konstruktor untuk widget UpdateContact dengan parameter yang diperlukan
  const UpdateContact(
      {super.key,
      this.id,
      this.beforenama,
      this.beforephone,
      this.beforeemail,
      this.beforeaddress});

  // Variabel untuk menyimpan data yang akan diperbarui
  final String? id;
  final String? beforenama;
  final String? beforephone;
  final String? beforeemail;
  final String? beforeaddress;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {

  // Membuat instance dari ContactController
  var contatcController = ContactController();

  // Membuat GlobalKey untuk form
  final formkey = GlobalKey<FormState>();

  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
            key: formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(hintText: 'Name'),
                  onSaved: (value) {
                    name = value;
                  },
                  initialValue: widget.beforenama,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Phone'),
                  onSaved: (value) {
                    phone = value;
                  },
                  initialValue: widget.beforephone,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Email'),
                  onSaved: (value) {
                    email = value;
                  },
                  initialValue: widget.beforeemail,
                ),
                TextFormField(
                  decoration: InputDecoration(hintText: 'Address'),
                  onSaved: (value) {
                    address = value;
                  },
                  initialValue: widget.beforeaddress,
                ),
                ElevatedButton(
                    child: const Text('Update Contact'),
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();

                        // Membuat objek ContactModel dengan data yang diperbarui
                        ContactModel cm = ContactModel(
                            id: widget.id!,
                            name: name!,
                            phone: phone!,
                            email: email!,
                            address: address!);

                            // Memanggil metode updateContact dari ContactController
                        contatcController.updateContact(cm);

                        // Menampilkan pesan sukses
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Contact Updated')));

                        // Navigasi ke halaman Contact setelah pembaruan berhasil
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Contact()));
                      }
                    })
              ],
            )),
      ),
    );
  }
}