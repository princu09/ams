import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final userEmail = FirebaseAuth.instance.currentUser!.email.toString();
  // ignore: prefer_typing_uninitialized_variables
  var userName;
  var msg = '';

  @override
  void initState() {
    userNameGet();
    getCurrentDate();
    super.initState();
  }

  String finalDate = '';

  getCurrentDate() {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    String createDate = formatter.format(DateTime.now());

    setState(() {
      finalDate = createDate;
    });
  }

  Future userNameGet() async {
    var url = Uri.parse("https://northfoxgroup123.000webhostapp.com/login.php");

    final response = await http.post(url, body: {
      "email": userEmail,
    });

    var jsonData = jsonDecode(response.body);
    userName = jsonData[0]['name'];

    return userName;
  }

  Future<void> sendAttendance() async {
    var url =
        Uri.parse("https://northfoxgroup123.000webhostapp.com/attendance.php");

    final response = await http.post(url, body: {
      "date": finalDate,
      "name": userName.toString(),
      "email": userEmail.toString(),
    });
    Navigator.of(context).pushReplacementNamed('/home');

    setState(() {
      msg = response.body;
    });
  }

  String barcode = "";

  Future scanBarcode() async {
    // String barcodeScanRes;

    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", false, ScanMode.DEFAULT)
        ?.listen((barcode) {
      setState(() {
        barcode = barcode;
      });

      /// barcode to be used
    });
    // barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
    //     "#ff6666", "Cancel", true, ScanMode.QR);

    // setState(() {
    //   barcode = barcodeScanRes;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fill Attandance"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Confirm Your Details :",
              style: TextStyle(fontSize: 18, color: Colors.teal),
            ),
            const SizedBox(
              height: 30,
            ),
            if (barcode != "")
              Column(
                children: [
                  Text("Name : " + userName),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Date : " + barcode),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Email : " + userEmail),
                ],
              ),
            const SizedBox(
              height: 30,
            ),
            if (barcode != "")
              Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50)),
                  // ignore: deprecated_member_use
                  child: FlatButton.icon(
                    icon: const Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.white,
                      size: 17,
                    ),
                    onPressed: () {
                      sendAttendance();
                    },
                    label: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w100),
                    ),
                  )),
            const SizedBox(
              height: 40,
            ),
            if (msg != "")
              Text(
                "Warning : " + msg,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanBarcode,
        child: const Icon(FontAwesomeIcons.qrcode),
      ),
    );
  }
}
