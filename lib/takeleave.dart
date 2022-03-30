import 'package:firebase_auth/firebase_auth.dart';

import 'main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:http/http.dart' as http;


class TakeLeave extends StatefulWidget {
  const TakeLeave({Key? key}) : super(key: key);

  @override
  _TakeLeaveState createState() => _TakeLeaveState();
}

class _TakeLeaveState extends State<TakeLeave> {

  TextEditingController reasonController = TextEditingController();

  final userEmail = FirebaseAuth.instance.currentUser!.email;

  String range = '';

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        // ignore: lines_longer_than_80_chars
            ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      }
    });
  }

  String url = "https://ams123hm.000webhostapp.com/takeLeave.php";

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(url), body: {
      "date": range,
      "reason": reasonController.text,
      "email": userEmail,
    }); //sending post request with header data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Take Leave"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed('/account');
              }, icon: const Icon(FontAwesomeIcons.solidUserCircle)),
            ),
          ]
      ),
      drawer: const AppDrawer(),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  const Text('Selected Range:\n' , style: TextStyle(fontWeight: FontWeight.bold , fontSize: 12),),
                  Text(range , style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.only(top: 20 , left: 10 , right: 10),
                    child: TextFormField(
                      controller: reasonController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      minLines: 1,
                      decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(FontAwesomeIcons.pen , size: 17,),
                          hintText: "Enter Reason",
                          hintStyle: TextStyle(color: Colors.grey[400])
                      ),
                    ),
                  )
              ]),
          ),
          Positioned(
            left: 0,
            top: 200,
            right: 0,
            bottom: 50,
            child: SfDateRangePicker(
              onSelectionChanged: _onSelectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
            ),
          ),
          // Text(userEmail!),
        ],
      ),
    floatingActionButton: FloatingActionButton(
      onPressed: () {
        sendData();
        Navigator.push(
            context, MaterialPageRoute(
            builder: (context) => const TakeLeave(),
        ));
      },
      backgroundColor: Colors.green,
      child: const Icon(FontAwesomeIcons.check),
    ));
  }
}