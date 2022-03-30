import 'dart:convert';
import 'package:ams/account.dart';
import 'package:ams/announcement.dart';
import 'package:ams/attedance.dart';
import 'package:ams/login.dart';
import 'package:ams/securityChecking.dart';
import 'package:ams/takeLeave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'about.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _email = "";

  Future getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _email = prefs.getString('email')!;
    });
  }

  @override
  void initState() {
    getEmail();
    super.initState();
  }

  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance Management System',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: _email != "" ? MyHomePage() : Login(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => MyHomePage(),
          '/login': (BuildContext context) => const Login(),
          '/account': (BuildContext context) => const Account(),
        });
    // const MyHomePage(),
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // getThisMonthAttendance.php
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();

  var totalPresentDay;

  var userName;

  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email')!;
    });
  }

  Future userAttedance() async {
    var url = Uri.parse(
        "https://ams123hm.000webhostapp.com/getThisMonthAttendance.php");

    final response = await http.post(url, body: {
      "email": userEmail,
    });

    setState(() {
      totalPresentDay = response.body;
    });

    return totalPresentDay;
  }

  Future userNameGet() async {
    var url = Uri.parse("https://ams123hm.000webhostapp.com/login.php");

    final response = await http.post(url, body: {
      "email": userEmail,
    });

    var jsonData = jsonDecode(response.body);
    userName = jsonData[0]['name'];

    return userName;
  }

  @override
  void initState() {
    userNameGet();
    userAttedance();
    getEmail();
    super.initState();
  }

  Future<List> leaveData() async {
    var url = Uri.parse(
        "https://ams123hm.000webhostapp.com/attendance_data.php");

    final response = await http.post(url, body: {
      "email": userEmail,
    });

    // print(response.body);

    var jsonData = jsonDecode(response.body);

    List<Leave> leaves = [];

    for (var u in jsonData) {
      Leave leave = Leave(u['date'], u['reason']);
      leaves.add(leave);
    }
    return leaves;
  }

  Future<List> leaveDeniedData() async {
    var url = Uri.parse(
        "https://ams123hm.000webhostapp.com/decline_attendance_data.php");

    final response = await http.post(url, body: {
      "email": userEmail,
    });

    // print(response.body);

    var jsonData = jsonDecode(response.body);

    List<Leave> leaves = [];

    for (var u in jsonData) {
      Leave leave = Leave(u['date'], u['reason']);
      leaves.add(leave);
    }
    return leaves;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"), actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/account');
              },
              icon: const Icon(FontAwesomeIcons.solidUserCircle)),
        ),
      ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            child: Column(
              children: [
                if (totalPresentDay != null && userName != null)
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userName,
                            style: const TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const Text("You are attend lectures.",
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(totalPresentDay + " Days",
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  child: TableCalendar(
                    firstDay: DateTime.utc(2010, 10, 16),
                    lastDay: DateTime.utc(2030, 3, 14),
                    focusedDay: DateTime.now(),
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50)),
                        todayTextStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.white)),
                    headerStyle: const HeaderStyle(
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),
                    calendarFormat: CalendarFormat.week,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(colors: [
                          Color.fromRGBO(0, 0, 0, 1),
                          Color.fromRGBO(0, 0, 0, 1),
                        ])),
                    child: Center(
                      child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                        child: FlatButton.icon(
                            label: const Text("Fill Attendance",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            icon: const Icon(
                              FontAwesomeIcons.qrcode,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Attendance()),
                              );
                            }),
                      ),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: FutureBuilder(
                      future: leaveData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text("Loading..."),
                          );
                        } else {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: const Text(
                                    "Accepted Leave",
                                    style: TextStyle(
                                        fontSize: 19,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.black,
                                    height: 50.0,
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                      children: [
                                        Text(
                                            "Date : " +
                                                snapshot.data[index].date,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "Reason : " +
                                                snapshot.data[index].reason,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ));
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Container(
                    child: FutureBuilder(
                      future: leaveDeniedData(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                            child: Text("Loading..."),
                          );
                        } else {
                          return Container(
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: const Text(
                                    "Denied Leave",
                                    style: TextStyle(
                                        fontSize: 19,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ListView.separated(
                                  shrinkWrap: true,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.black,
                                    height: 50.0,
                                  ),
                                  itemCount: snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                        child: Column(
                                      children: [
                                        Text(
                                            "Date : " +
                                                snapshot.data[index].date,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text(
                                            "Reason : " +
                                                snapshot.data[index].reason,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ));
                                  },
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key, ListView? child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const SizedBox(
            height: 80,
            child: DrawerHeader(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: Colors.black, width: 3.0))),
                child: Text("Attendance Management System (AMS)",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17.0))),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
              leading: const Icon(
                FontAwesomeIcons.home,
                size: 20,
              ),
              title: const Text(
                'Home',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }),
          ListTile(
              leading: const Icon(
                FontAwesomeIcons.clipboard,
                size: 20,
              ),
              title: const Text(
                'Take Leave',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TakeLeave()),
                );
              }),
          ListTile(
              leading: const Icon(
                FontAwesomeIcons.bullhorn,
                size: 20,
              ),
              title: const Text(
                'Announcement',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Announcement()),
                );
              }),
          ListTile(
              leading: const Icon(
                FontAwesomeIcons.infoCircle,
                size: 20,
              ),
              title: const Text(
                'About',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              }),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.signOutAlt,
              size: 20,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              var currentUser = FirebaseAuth.instance.currentUser;
              if (currentUser == null) {
                Navigator.of(context).pushReplacementNamed('/login');
              }
            },
          ),
        ],
      ),
    );
  }
}

class User {
  final String email, name, roll, division, degree, mobile;
  User(this.email, this.name, this.roll, this.division, this.degree,
      this.mobile);
}

class Leave {
  final String date, reason;
  Leave(this.date, this.reason);
}
