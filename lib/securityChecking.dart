import 'authApp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Security extends StatefulWidget {
  const Security({ Key? key }) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  Future authenticationRun() async{
    final isAuthenticated = await LocalAuthApi.authenticate();
    if(isAuthenticated){
      Navigator.of(this.context).pushReplacementNamed('/home');
    }
  }

  @override
  void initState() {
    authenticationRun();
    super.initState();
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: FlatButton(
              onPressed: () async{
                final isAuthenticated = await LocalAuthApi.authenticate();
                if(isAuthenticated){
                  Navigator.of(context).pushReplacementNamed('/home');
                }
              },
              child: Text("Authenticate")),
        ),
      ),
    );
  }
}