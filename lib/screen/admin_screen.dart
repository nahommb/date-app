import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import '../provider/data.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();

  static final routName = 'amin screen';
}

class _AdminScreenState extends State<AdminScreen> {

 var name;
var tg_username = 'unknown';
var ig_username = 'unknown';
var address ;
var phone_number;
final nameController = TextEditingController();
 final tgController = TextEditingController();
 final igController = TextEditingController();
 final addressController = TextEditingController();
 final phoneController = TextEditingController();

final nameFocus = FocusNode();
 final tgFocus = FocusNode();
 final igFocus = FocusNode();
 final addressFocus = FocusNode();
 final phoneFocus = FocusNode();


 @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =  ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final data = Provider.of<Data>(context);

    return Scaffold(
      body:SingleChildScrollView(
        child:Column(
          children: [
            Container(
              child: Image.file(args['imageUrl'],fit: BoxFit.cover,),
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: nameController,
                      focusNode: nameFocus,
                      onChanged: (val){
                        name = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tgController,
                      focusNode: tgFocus,
                      onChanged: (val){
                        tg_username = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Telegram Username'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: igController,
                      focusNode: igFocus,
                      onChanged: (val){
                        ig_username = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Instagram Username'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: addressController,
                      focusNode: addressFocus,
                      onChanged: (val){
                        address = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Address'
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: phoneController,
                      focusNode: phoneFocus,
                      onChanged: (val){
                        phone_number = val;
                      },
                      decoration: InputDecoration(
                          labelText: 'Phone Number'
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: () async{
                     final imageUrl =  await data.postImage(args['imageUrl']);
                    data.postUser(name, tg_username, ig_username, address, phone_number,imageUrl);
                    nameController.clear();
                    nameFocus.unfocus();
                    tgController.clear();
                    igController.clear();
                    igController.clear();
                    addressController.clear();
                    phoneFocus.unfocus();

                    Navigator.pop(context);
                  }, child: Text('Submit'))
                ],
              ),
            )


          ],
        ),
      )

    );
  }
}
