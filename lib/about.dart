import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  _makingPhoneCall() async {
    const url = 'tel:9033717372';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _openSite() async {
    const url = 'https://www.cushahbca.ac.in';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(onPressed: (){
                Navigator.of(context).pushReplacementNamed('/account');
              }, icon: Icon(FontAwesomeIcons.solidUserCircle)),
            ),
          ]
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'images/logo.png',
              width: 200.0,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            const Text("C.U.Shah BCA" , style: TextStyle(fontSize: 24 , fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,) ,
            const Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optioamet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optioamet, consectetur adipisicing elit. Eligendi non quis exercitationem culpa nesciunt nihil aut nostrum explicabo reprehenderit optio amet ab temporibus asperiores quasi cupiditate. Voluptatum ducimus voluptates voluptas?" , style: TextStyle(fontSize: 16),),
            const SizedBox(height: 30,) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: _makingPhoneCall,
                  child: const Text("Contact" , style: TextStyle(color: Colors.white),) , color: Colors.black,),
                const SizedBox(width: 30,),
                RaisedButton(onPressed: _openSite, child: const Text("Website" , style:  TextStyle(color: Colors.white),) , color: Colors.black,)
              ],
            )
          ],
        ),
      ),
      drawer: const AppDrawer(),
    );
  }
}
