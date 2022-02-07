import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {

  final userEmail = FirebaseAuth.instance.currentUser!.email;

    Future<List> handleLogin() async {
      var url = Uri.parse("https://northfoxgroup123.000webhostapp.com/login.php");

      final response =  await http.post(url , body: {
        "email": userEmail,
      });

      // print(response.body);

      var jsonData = jsonDecode(response.body);

      List<User> users = [];

      for(var u in jsonData){
        // final String email , name , roll , division , degree , mobile;
        User user = User(u['email'], u['name'], u['roll'] , u['division'] , u['degree'] , u['mobile']);
        users.add(user);
      }
      return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("My Account"),
          leading: IconButton(onPressed: (){
          Navigator.of(context).pushReplacementNamed('/home');
        }, icon: const Icon(FontAwesomeIcons.chevronLeft , size: 18,)),
      ),
      body: FutureBuilder(
        future: handleLogin(),
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
                itemBuilder: (BuildContext context , int id) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SizedBox(
                            height: 150,
                            child: Image.asset('images/student.png'),
                          ),
                        ),
                        // Text(userEmail!),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(snapshot.data[id].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Roll No : " + snapshot.data[id].roll,
                            style: const TextStyle(fontSize: 18),),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                "Class : " + snapshot.data[id].division, style: const TextStyle(fontSize: 18),),
                            ),
                            const Text("|", style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text("Degree : " + snapshot.data[id].degree,
                                style: const TextStyle(fontSize: 18),),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Email : " + snapshot.data[id].email,
                            style: const TextStyle(fontSize: 18),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Mobile : " + snapshot.data[id].mobile,
                            style: const TextStyle(fontSize: 18),),
                        ),
                        const SizedBox(height: 30,),
                      //   Container(
                      //     height: 50,
                      //     width: 150,
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         gradient: const LinearGradient(
                      //             colors: [
                      //               Color.fromRGBO(167, 29, 49, .9),
                      //               Color.fromRGBO(217, 131, 36, 1),
                      //             ]
                      //         )
                      //     ),
                      //     child: Center(
                      //       child: SizedBox(
                      //         height: 50.0,
                      //         width: double.infinity,
                      //         child: ElevatedButton(
                      //           child: const Text(
                      //               "Logout",
                      //               style: TextStyle(fontSize: 20)
                      //           ),
                      //           style: ButtonStyle(
                      //             shadowColor: MaterialStateProperty.all(
                      //                 Colors.transparent),
                      //             backgroundColor: MaterialStateProperty.all(
                      //                 Colors.transparent),
                      //           ),
                      //           onPressed: () async {
                      //             await FirebaseAuth.instance.signOut();
                      //             var currentUser = FirebaseAuth.instance.currentUser;
                      //             if (currentUser == null) {
                      //               Navigator.of(context).pushReplacementNamed('/login');
                      //             }
                      //           },
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      ],
                    ),
                  );
                });
          }},
      ),
    );
  }
}

class User{
  final String email , name , roll , division , degree , mobile;
  User(this.email, this.name, this.roll, this.division, this.degree, this.mobile);
}