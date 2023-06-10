import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan_firebase/model/user_model.dart';
import 'package:latihan_firebase/view/login.dart';

class AuthController{
  final FirebaseAuth auth = FirebaseAuth.instance;

  final CollectionReference userCollection = 
  FirebaseFirestore.instance.collection('users');

  bool get success => false;

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

  Future<UserModel?> registerWithEmailAndPassword(
    String email, String password, String name
  ) async{
    try{
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

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();

}
  
  

}