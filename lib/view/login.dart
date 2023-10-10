import 'package:flutter/material.dart';
import 'package:latihan_firebase/controller/auth_controller.dart';
import 'package:latihan_firebase/view/register.dart';

import '../model/user_model.dart';
import 'contact.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    // Membuat GlobalKey untuk form
  final formkey = GlobalKey<FormState>();

    // Membuat instance dari AuthController
  final authctrl = AuthController();

  // Variabel untuk menyimpan email dan password
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: formkey,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 40, 120, 0),
                  child: RichText(
                      text: const TextSpan(
                          text: "Login",
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))),
                ),

                // Input field untuk email
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
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

                // Tombol "Login"
                ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {

                      // Melakukan login menggunakan authctrl.signInWithEmailAndPassword
                      UserModel? Signing =
                          await authctrl.signInWithEmailAndPassword(
                        email!,
                        password!
                          );                                        
                      if (Signing != null) {
                        // Login berhasil, tampilkan pesan sukses
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Successful'),
                              content: const Text(
                                  'You have been successfully Login.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                       MaterialPageRoute(builder: (context) {
                                     return Contact();
                                    }));
                                    print(Signing.name);
                                    // Navigasi ke halaman berikutnya atau lakukan tindakan yang diinginkan
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Login gagal, tampilkan pesan kesalahan
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Login Failed'),
                              content: const Text(
                                  'An error occurred during Login'),
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

                // Tombol untuk navigasi ke halaman pendaftaran (Register)
                TextButton(onPressed: (){
                   {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                  };
                        
                }, child: Text('Register',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue
                ),))
              ],
            ),
          )),
    ));
       
  }

}
