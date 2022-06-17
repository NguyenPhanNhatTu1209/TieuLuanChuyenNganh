import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  Future<String> uploadImageToStorage(File file, String folder) async {
    String fileName = DateTime.now().toString();
    Reference ref =
        FirebaseStorage.instance.ref().child(folder).child(fileName);
    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    var downUrl = await snapshot.ref.getDownloadURL();
    String url = downUrl.toString();
    return url;
  }
}
