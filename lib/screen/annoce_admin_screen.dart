

import 'package:date_app/provider/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostAnnouncement extends StatefulWidget {
  const PostAnnouncement({super.key});
  static final routName = 'post_announcemet';
  @override
  State<PostAnnouncement> createState() => _PostAnnouncementState();
}

class _PostAnnouncementState extends State<PostAnnouncement> {

  var description;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Create Annonce '),backgroundColor: Colors.black,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: data.image==null?Text('Image not Selected'):Image.file(data.image!),
            ),
            TextButton(onPressed: ()async{
              await data.getAnnouncementImage(context);
              setState(() {
                
              });
            }, child: Text('Select Image')),
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (val){
                  description = val;
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  label: Text('Write Announcemet'),
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                ),
              ),
            ),
            ElevatedButton(onPressed: ()async{
              final image = await data.postImage(data.image);
              print(image);
              data.postAnnouncement(image, description);
            }, child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
