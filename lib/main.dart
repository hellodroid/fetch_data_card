import 'dart:convert';

import 'package:fetch_data_card/detail.dart';
import 'package:fetch_data_card/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Fetch data to card'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>> user;

  @override
  void initState() {
    super.initState();
    user = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.6,
                child: FutureBuilder<List<User>>(
                  future: fetchUser(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<User> user = snapshot.data;
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: user.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            alignment: Alignment.topCenter,
                            width: screenWidth * 0.5,
                            child: InkWell(
                              child: Card(
                                clipBehavior: Clip.antiAlias,
                                color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                elevation: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 15.0 / 11.0,
                                      child: Image.network(
                                        user[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 16.0,
                                        right: 16.0,
                                        top: 12.0,
                                        bottom: 8.0,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.center,
                                            child: Image.network(
                                              user[index].profile,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              user[index].title,
                                            ),
                                          ),
                                          Container(
                                            child: Text('${user[index].id}'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Detail(
                                      userId: user[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<List<User>> fetchUser() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/photos');

  String logResponse = response.statusCode.toString();

  if (response.statusCode == 200) {
    print('ResponseStatusCode: $logResponse'); // Check Status Code = 200
    print('ResponseBody: ' + response.body); // Read Data in Array

    List<dynamic> responseJson = json.decode(response.body);
    return responseJson.map((m) => new User.fromJson(m)).toList();
  } else {
    throw Exception('error :(');
  }
}
