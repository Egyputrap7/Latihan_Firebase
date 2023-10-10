import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latihan_firebase/model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');  // Mengakses koleksi "contacts" di Firebase Firestore
  
    // Membuat StreamController untuk mengelola aliran data dari koleksi kontak
  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();


    // Getter untuk mengakses aliran data yang dihasilkan oleh StreamController
  Stream<List<DocumentSnapshot>> get stream => streamController.stream; 
   

     // Menambahkan kontak baru ke Firebase Firestore
  Future addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();
    
     // Menambahkan data kontak ke koleksi "contacts" dan mendapatkan referensi dokumen baru
    final DocumentReference docRef = await contactCollection.add(contact);

     // Mengambil ID dokumen yang baru dibuat
    final String docId = docRef.id;


    // Membuat objek ContactModel dengan ID yang baru, dan memperbarui dokumen dengan ID tersebut
    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }


  // Mengambil semua kontak dari Firebase Firestore dan mengirimkannya melalui aliran data
  Future getContact() async {
    final contact = await contactCollection.get();

    // Mengirim daftar dokumen (kontak) melalui aliran data
    streamController.sink.add(contact.docs);

    return contact.docs;
  }


  // Memperbarui kontak yang ada di Firebase Firestore
  Future updateContact(ContactModel contactModel) async {

    // Membuat objek ContactModel baru dengan data yang diperbarui
    final ContactModel ctmModel = ContactModel(
        id: contactModel.id,
        name: contactModel.name,
        phone: contactModel.phone,
        email: contactModel.email,
        address: contactModel.address);

     // Memperbarui dokumen kontak yang sesuai dengan ID yang diberikan
    await contactCollection.doc(contactModel.id).update(contactModel.toMap());

      // Memperbarui aliran data setelah perubahan
    await getContact();
  }


  // Menghapus kontak dari Firebase Firestore berdasarkan ID
  Future deleteContact(String id) async {

        // Menghapus dokumen kontak yang sesuai dengan ID yang diberikan
    final contact = await contactCollection.doc(id).delete();
    return contact;
  }
}