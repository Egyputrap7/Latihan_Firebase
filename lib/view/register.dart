import 'package:flutter/material.dart';
import 'package:latihan_firebase/view/contact.dart';

import '../controller/auth_controller.dart';
import '../model/user_model.dart';
class Register extends StatefulWidget {

    // Konstruktor untuk widget Register
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

    // Membuat GlobalKey untuk form
  final formkey = GlobalKey<FormState>();

    // Membuat instance dari AuthController
  final authCtr = AuthController();

    // Variabel untuk menyimpan nama, email, dan password
  String? name;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            key: formkey,
            child: Column(
              children: [
              // Input field untuk nama
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.people),
                    hintText: 'Name',
                  ),
                  onChanged: (value) => name = value,
                ),

                // Input field untuk Email
                TextFormField(
                  
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  onChanged: (value) => email = value,
                ),

                // Input field untuk password
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Password',
                  ),
                  onChanged: (value) => password = value,
                ),
                const SizedBox(
                  height: 20,
                ),

                // Tombol "Register"
                ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {

                      // Melakukan registrasi menggunakan authCtr.registerWithEmailAndPassword
                      UserModel? registeredUser =
                          await authCtr.registerWithEmailAndPassword(
                        email!,
                        password!,
                        name!,
                      );
                      if (registeredUser != null) {
                        // Registrasi berhasil, tampilkan pesan sukses
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Successful'),
                              content: const Text(
                                  'You have been successfully registered.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                       MaterialPageRoute(builder: (context) {
                                     return Contact();
                                    }));
                                    print(registeredUser.name);
                                    // Navigasi ke halaman berikutnya atau lakukan tindakan yang diinginkan
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Registrasi gagal, tampilkan pesan kesalahan
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Registration Failed'),
                              content: const Text(
                                  'An error occurred during registration.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
