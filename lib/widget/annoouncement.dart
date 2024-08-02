import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/data.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {

//  DateTime now = DateTime.now();
  String formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now().toLocal());

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<Data>(context);

    return ListView.builder(
        itemCount: data.allAnnouncement.length,
        itemBuilder: (context,index)=>Column(
      children: [
        Container(
          child: data.allAnnouncement[index]['imageUrl']!=null?Image.network(data.allAnnouncement[index]['imageUrl'],fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 1,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                );
              }
            },
          ):null,
        ),
        Container(
          //height: 90,
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data.allAnnouncement[index]['description'],style: TextStyle(fontSize: 15),),
              SizedBox(height: 10,),
              Text('07/10/24',style: TextStyle(color: Colors.deepPurpleAccent),),
            ],
          ),
        ),
        Divider(
          color: Colors.black,
          thickness: 5,
        )
      ],
    ));
  }
}
