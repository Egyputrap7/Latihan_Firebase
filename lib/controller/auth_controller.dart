import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan_firebase/model/user_model.dart';
import 'package:latihan_firebase/view/login.dart';


// AuthController adalah kelas yang bertanggung jawab untuk mengelola proses otentikasi pengguna.
class AuthController{

  // komponen Firebase yang digunakan untuk mengelola otentikasi pengguna.
  final FirebaseAuth auth = FirebaseAuth.instance;
  // variabel yang digunakan untuk mengakses koleksi Firebase Firestore dengan nama "users",yang di gunakan untuk menyimpan data user
  final CollectionReference userCollection = 
  FirebaseFirestore.instance.collection('users');

  bool get success => false; //adalah getter yang mengembalikan nilai boolean
   // metode yang digunakan untuk mengotentikasi pengguna dengan email dan kata sandi yang diberikan
  Future<UserModel?> signInWithEmailAndPassword(
    String email, String password
  ) async{

    try{

    
    final UserCredential userCredential = await auth.
    signInWithEmailAndPassword(email: email, password: password);
    final User? user = userCredential.user;

    if(user !=null){
      final DocumentSnapshot snapshot =
      await userCollection.doc(user.uid).get();

      final UserModel currentUser = UserModel(
        name: snapshot['name']?? '',
        email: user.email ??'',
        uId:user.uid
        );

        return currentUser;
    }
    }catch(e){
      print('Error Signing in: $e');
    }

    return null;
  }
   //  metode yang digunakan untuk mendaftarkan pengguna baru dengan email, kata sandi, dan nama yang diberikan
  Future<UserModel?> registerWithEmailAndPassword(
    String email, String password, String name
  ) async{
    try{
      //membuat pengguna baru dengan email dan kata sandi menggunakan 
      final UserCredential userCredential = await auth
      .createUserWithEmailAndPassword(email: email,
       password: password);
       final User? user = userCredential.user;

       if (user !=null){
        final UserModel newUser =UserModel(
          uId: user.uid,
           email: user.email ??'', 
           name: name);

           await userCollection.doc(newUser.uId).set(newUser.toMap());

           return newUser;
       }
       
    }catch(e){
      print('Error register user: $e');
    }
    return null;
  }
//metode yang digunakan untuk mendapatkan pengguna saat ini yang sedang masuk. Ini mengembalikan 
//objek UserModel yang mewakili pengguna saat ini jika ada pengguna yang masuk, dan null jika tidak ada pengguna yang masuk
  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }
//adalah metode yang digunakan untuk keluar (log out)
  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();

}
  
  

}