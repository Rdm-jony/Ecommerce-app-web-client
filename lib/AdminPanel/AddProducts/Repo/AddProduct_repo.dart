import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProductRepo {
  static Future<String> upLoadIamgeFile(fileData) async {
    final metadata = SettableMetadata(contentType: "image/jpeg");
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('products');

    //reference to file directory
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      if (kIsWeb) {
        await referenceImageToUpload.putData(fileData, metadata);
      } else {
        await referenceImageToUpload.putFile(File(fileData));
      }

      var imageUrl = await referenceImageToUpload.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print(e);
    }
    return "";
  }

  static Future<bool> addProductData(formData) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.213.133:5000/addProduct"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(formData));
      if (response.statusCode == 200) {
        var jsonRsponse = jsonDecode(response.body);
        if (jsonRsponse["insertedId"] != null) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
