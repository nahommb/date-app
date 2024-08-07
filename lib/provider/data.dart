import 'dart:convert';
import 'dart:io';
import 'package:date_app/module/constants.dart';
import 'package:date_app/screen/admin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Data with ChangeNotifier{

  File? image;
  final _picker = ImagePicker();


  List<dynamic>_allPosts = [];
  List<dynamic> get allPosts {
    return [..._allPosts];
}

  List<dynamic> _allAnnouncement = [];
  List<dynamic> get allAnnouncement {
    return [..._allAnnouncement];
  }

  Future<void> getImage(context) async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    if(pickedFile!=null){
      image = File(pickedFile.path);

      print('leeeeeeee $image');
    }
    else{
      print('no image picked');
    }

    if(image!=null){
      print('not null');

      Navigator.pushNamed(context, AdminScreen.routName,arguments: {'imageUrl':image});

    }

  }


  Future<void> getAnnouncementImage(context) async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 90);
    if(pickedFile!=null){
      image = File(pickedFile.path);

      print('leeeeeeee $image');
    }
    else{
      print('no image picked');
    }

    if(image!=null){
      print('not null');


      //Navigator.pushNamed(context, AdminScreen.routName,arguments: {'imageUrl':image});

    }
  }


  Future <void> postUser(name,tg_username,ig_username,address,phone_number,imageUrl) async{
    final url = Uri.parse(UserApi);

    http.post(url,body: json.encode({
      'name':name,
      'tg_username':tg_username,
      'ig_username':ig_username,
      'address':address,
      'phone_number':phone_number,
      'imageUrl':imageUrl,
    }),);
  }
  Future <void> getUser() async{
    final url = Uri.parse(UserApi);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> bd = jsonDecode(response.body);

      _allPosts.clear(); // Clear previous posts

      // Iterate through the map and add each post to the list
      List<dynamic> recievedData = [];
      bd.forEach((key, value) {
        //print(value);
        recievedData.add(value);
      });
      _allPosts = recievedData.reversed.toList();
     // print(allPosts);
    }
  }

  Future <dynamic> postImage(imageUrll) async{

    final ref = await FirebaseStorage.instance.ref().child('user_image').child('${imageUrll} .jpg');
    await ref.putFile(image!);
    final imageUrl = await ref.getDownloadURL();

    return imageUrl;
  }


  Future <void> postAnnouncement(announcementImage,description) async{
    final url = Uri.parse(AnnouncementApi);
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toLocal());
    http.Response response = await http.post(url,body:json.encode({
      'imageUrl':announcementImage,
      'description':description,
      'date':formattedDate,
    }));



  }
  Future <void> getAnnouncement() async{
    final url = Uri.parse(AnnouncementApi);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> bd = jsonDecode(response.body);

      _allAnnouncement.clear(); // Clear previous posts

      // Iterate through the map and add each post to the list
      List<dynamic> recievedData = [];
      bd.forEach((key, value) {
        //print(value);
        recievedData.add(value);
      });
      _allAnnouncement = recievedData.reversed.toList();
      // print(allPosts);
    }


  }
}
