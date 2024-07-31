import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/data.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {

  @override
  Widget build(BuildContext context) {

    final data = Provider.of<Data>(context);

    return ListView.builder(
        itemCount: data.allAnnouncement.length,
        itemBuilder: (context,index)=>Column(
      children: [
        Container(
          child: Image.network(data.allAnnouncement[index]['imageUrl']),
        ),
        Container(
          height: 90,
          color: Colors.white,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          child: Text(data.allAnnouncement[index]['description'],style: TextStyle(fontSize: 18),),
        ),
        Divider()
      ],
    ));
  }
}
