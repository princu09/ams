// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:ams/main.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Announcement extends StatefulWidget {
  const Announcement({Key? key}) : super(key: key);

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {

  getUserData() async{
    var response = await http.get(Uri.parse('http://ams123hm.000webhostapp.com/announcement.php'));
    var jsonData = jsonDecode(response.body);
    List<User> users = [];

    for(var u in jsonData){
      User user = User(u['title'], u['description'], u['date']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcement"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed('/account');
              }, icon: const Icon(FontAwesomeIcons.solidUserCircle)),
            ),
          ]
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: FutureBuilder(
          future: getUserData(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return const Center(child: Text("Loading..."),);
            }
            else{
            return ListView.separated(
              itemCount: snapshot.data.length,
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.black,
                height: 50.0,
              ),
              itemBuilder: (BuildContext context , int id){
                return ListTile(
                  title: Text(snapshot.data[id].title + "\n" , style: const TextStyle(fontSize: 18 , fontWeight: FontWeight.w600),),
                  subtitle: Text(snapshot.data[id].description +  "\n\nDate : " +  snapshot.data[id].date),
                  // : Text(snapshot.data[id].date),
                );
              },
            );
          }},
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class User{
  final String title , description , date;
  User( this.title , this.description , this.date);
}