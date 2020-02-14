import 'dart:convert';
import 'dart:io';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/Business.dart';
import 'package:test1/Entertainment.dart';
import 'package:test1/Explore.dart';
import 'package:test1/Health.dart';
import 'package:test1/Science.dart';
import 'package:test1/Sports.dart';
import 'package:test1/Technology.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  TabController controller;
  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  int index;
  var url =
      "https://newsapi.org/v2/top-headlines?country=in&apiKey=b98abb72aa334a3c9ec2609b31f873d5";
  var data;
  Future<String> getJsonData(url) async {
    var responce = await http.get(
      Uri.encodeFull(url),
    );

    setState(() {
      var convertdata = json.decode(responce.body);
      data = convertdata['articles'];
    });
    debugPrint(responce.body);
  }

  @override
  void initState() {
    controller = new TabController(length: 7, vsync: this);
    getJsonData(url);
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage("https://getdrawings.com/free-icon/geek-icon-51.png")),
                  accountName: Text("Tushar Nikam"),
                  accountEmail: Text("champ96k@gmail.com")),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.account_circle),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Profile"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.category),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Categories"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.bookmark_border),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Bookmark"), 
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.notifications),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Notification"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.share),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Share"),
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(Icons.assistant_photo),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("About App"),
              ),
              Divider(
                height: 0.85,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  changeBrightness();
                },
                leading: CircleAvatar(
                  child: Icon(Icons.wb_sunny),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Dark Theme"),
              ),
              ListTile(
                onTap: () {
                  exit(0);
                },
                leading: CircleAvatar(
                  child: Icon(Icons.exit_to_app),
                  backgroundColor: Colors.grey[300],
                ),
                title: Text("Exit"),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Text(
                "News",
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
              Text(
                "Hours",
                style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 19, 
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: null),
            IconButton(icon: Icon(Icons.notifications_none), onPressed: null)
          ],
          bottom: TabBar(
             controller : controller,
             isScrollable: true,
             indicatorColor: Colors.lime, 
             indicatorSize: TabBarIndicatorSize.label, 
            tabs: <Widget>[
              Tab(text: "Explore"),
              Tab(text: "Business"), 
              Tab(text: "Entertainment"),
              Tab(text: "Technology"),  
              Tab(text: "Sports"),
              Tab(text: "Science"), 
              Tab(text: "Health"),
            ], 
          ),
        ),
        body: TabBarView( 
          controller: controller, 
          children: <Widget>[
            Explore(),
            Business(),
            Entertainment(),
            Technology(),
            Sports(),
            Science(),
            Health(),
          ],
        )
    );
  }
}
