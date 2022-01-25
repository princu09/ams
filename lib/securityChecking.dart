import 'package:ams/attedance.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'main.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  String _message = "Not Authorized";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
        child: ElevatedButton(
        onPressed: () async {
          bool isAuthenticated =
              await Authentication.authenticateWithBiometrics();
          if (isAuthenticated != null) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          }
        },
        child: Text("Authenticate"),
        // ...
      ),
    ));
  }
}

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
      );
    }

    return isAuthenticated;
  }
}
