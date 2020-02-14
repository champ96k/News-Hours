import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test1/Description.dart';

class Sports extends StatefulWidget {
  @override
  _SportsState createState() => _SportsState();
}

class _SportsState extends State<Sports> {
  int index;
  var url ="https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=b98abb72aa334a3c9ec2609b31f873d5";
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
    getJsonData(url);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
            child: (data == null)
                ? CircularProgressIndicator()
                : SafeArea(
                    child: Column(
                    children: <Widget>[
                      
                      Expanded(
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () { 
                                  Navigator.push(context,MaterialPageRoute(builder: (context) =>Description(data,index,)));
                                },
                                child: Card(
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  elevation: 2,  
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18) 
                                  ),
                                    child: Column(
                                  children: <Widget>[
                                    (data[index]['urlToImage'] == null) ? Image(image: NetworkImage('https://previews.123rf.com/images/njwatchara/njwatchara1806/njwatchara180600028/106272860-global-earth-rotating-digital-world-news-studio-background-for-news-report-and-breaking-news.jpg')) :
                                     Image(
                                      image:NetworkImage(data[index]['urlToImage']),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:(data[index]['title'] == null) ? CircularProgressIndicator() 
                                    : Text( data[index]['title'],
                                        style: TextStyle(
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(left: 6.0,right: 6.0,bottom: 4.0), 
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                          alignment: Alignment.centerLeft,
                                          child:(data[index]['publishedAt'] == null) ? CircularProgressIndicator() :  Text("🕓 "+data[index]['publishedAt'], 
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.5,
                                          ),
                                         )
                                        ),
                                       (data[index]['source']['name'] == null) ? CircularProgressIndicator()
                                        :   Text(data[index]['source']['name'],
                                         style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13.5,
                                          ),
                                        )
                                       ],
                                      )
                                    ),
                                    
                                  
                                  ],
                                )),
                              );
                            }),
                      ),
                    ],
                  ))),
    );
  }
}