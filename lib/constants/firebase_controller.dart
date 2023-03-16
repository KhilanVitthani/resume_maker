import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

import '../models/resumeModel.dart';

class FireController {
  static FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  final CollectionReference _postCollectionReferance =
      _firebaseFirestore.collection("resume");

  Future<void> addData({required resumeModel resumeData}) async {
    if (resumeData.image == null) return;
    final fileName = basename(resumeData.image.toString());
    final destination = '$fileName';

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(File(resumeData.image!));
      String urlUploaded = (await ref.getDownloadURL()).toString();
      if (urlUploaded != "") {
        // String skills="";

        // print(skills);
        // addResumeController.selected_skills.forEach((element) {
        //   skills   = skills+element+",";
        // });
        await _postCollectionReferance
            .doc(resumeData.uId)
            .set(resumeData.toJson());
      }
      print(urlUploaded);
    } catch (e) {
      print('error occured');
    }
  }

  Stream<QuerySnapshot> getResumeData() {
    return _postCollectionReferance.snapshots();
  }
}
