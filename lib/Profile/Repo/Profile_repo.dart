import 'dart:convert';
import 'dart:io';

import 'package:e_commerce_app_bloc/Profile/Model/ProfileDataModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepo {
  static Future<Map> fatchProfileData() async {
    Map profileData;
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http
          .get(Uri.parse("http://192.168.213.133:5000/profile/${email}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        profileData = jsonResponse;
        return profileData;
      }
    } catch (e) {
      print(e);
    }
    return {};
  }

  static Future<bool> uploadImage() async {
    var imageUrl;
    //pick Image
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print(file);
    if (file == null) return false;

    //unique file name
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    //reference of root directory
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');

    //reference to file directory
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      if (imageUrl != null) {
        var updateData = {"image": imageUrl};
        bool isUpdate = await uploadToMongoDb(updateData);
        return isUpdate;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> uploadToMongoDb(updateData) async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/profile/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(updateData));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["acknowledged"] == true) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
