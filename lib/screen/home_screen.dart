import 'package:date_app/provider/data.dart';
import 'package:date_app/screen/admin_screen.dart';
import 'package:date_app/screen/annoce_admin_screen.dart';
import 'package:date_app/widget/posts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  bool isInit = true;
  var data ;
  void didChangeDependencies() async{
    // TODO: implement didChangeDependencies
    if(isInit){
      data = Provider.of<Data>(context);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<Data>(context);
    // data.getUser();
    return DefaultTabController(
        length: 2,
        child:Scaffold(
          drawer: Drawer(
            child: Container(
              padding: EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  ListTile(title: Text('Post Photo'),onTap: (){
                   data.getImage(context);
                  },),
                  ListTile(title: Text('Post Announcement'),onTap: (){
                    Navigator.pushNamed(context, PostAnnouncement.routName);
                  },)
                ],
              ),
            ),
          ),
          appBar: AppBar(title: Text('Date App'),centerTitle: true,backgroundColor: Colors.black,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.campaign_sharp), text: "Announcement"),
            ],
          ),),
          body: TabBarView(children: [
            RefreshIndicator(
               onRefresh: (){
                 return data.getUser();
               },
                child: FutureBuilder(
                  future: data.getUser(),
                  builder: (context,snapshot){
                    if(data.allPosts.isEmpty){
                      print(data.allPosts);
                      return Center(child: CircularProgressIndicator());
                    }
                    return Posts();
                  },
                )
            ),
            Container(

            )
          ],
          )


        )
    );
  }
}
