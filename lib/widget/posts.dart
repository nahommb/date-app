
import 'package:date_app/provider/data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Posts extends StatefulWidget {



  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  final auth = FirebaseAuth.instance;

 // final databaseReference = FirebaseDatabase.instance.ref('https://date-app-64dea-default-rtdb.firebaseio.com/');
 //  bool isInit = true;
 //  var data ;
 //  void didChangeDependencies() async{
 //    // TODO: implement didChangeDependencies
 //    if(isInit){
 //       data = Provider.of<Data>(context);
 //    }
 //    isInit = false;
 //    super.didChangeDependencies();
 //  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Data>(context);
    return ListView.builder(
      itemCount: data.allPosts.length,
      itemBuilder: (context,index)=> Column(
        children: [
          Container(
            //height: 300,
            width: double.infinity,
            //color: Colors.pink,
            margin: EdgeInsets.all(8),
            child: Image.network(data.allPosts[index]['imageUrl'],fit: BoxFit.cover,
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
            ),
          ),
          Container(
           // height: 30,
            width: double.infinity,
            // color: Colors.purple,
            margin: EdgeInsets.all(8),
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('Address'),
                    Text(data.allPosts[index]['address'],style: TextStyle(color: Colors.lightGreen)),
                  ],
                ),
                Column(
                  children: [
                    Text('Telegram'),
                    Text(data.allPosts[index]['tg_username'],style: TextStyle(color: Colors.lightGreen)),
                  ],
                ),
                Column(
                  children: [
                    Text('Instagram'),
                    Text(data.allPosts[index]['ig_username'],style: TextStyle(color: Colors.lightGreen)),
                  ],
                ),
                Column(
                  children: [
                    Text('Phone Number'),
                    Text(data.allPosts[index]['phone_number'],style: TextStyle(color: Colors.lightGreen),),
                  ],
                ),
               // TextButton(onPressed: (){
               //   //auth.createUserWithEmailAndPassword(email: 'nahomjr17@gmail.com', password: '123456');
               //    //data.postUser();
               // }, child: Text('click'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
