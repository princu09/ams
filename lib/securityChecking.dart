import 'package:ams/attedance.dart';
import 'package:ams/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              child: Image.asset("images/logo.png"),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton.icon(
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Colors.white),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0),
                ),
              ),
              onPressed: () async {
                bool isAuthenticated =
                    await Authentication.authenticateWithBiometrics();
                if (isAuthenticated) {
                  final userEmail =
                      FirebaseAuth.instance.currentUser!.email.toString();

                  if (userEmail != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  }
                }
              },
              icon: Icon(
                Icons.lock,
              ),
              label: Text(
                'Authenticate',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class LocalAuthApi {
//   static final _auth = LocalAuthentication();

//   static Future<bool> hasBiometrics() async {
//     try {
//       return await _auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }

//   static Future<bool> authenticate() async {
//     final isAvailable = await hasBiometrics();
//     if (!isAvailable) return false;

//     try {
//       // ignore: deprecated_member_use
//       return await _auth.authenticateWithBiometrics(
//         localizedReason: 'Scan Fingerprint to Authenticate AMS',
//         useErrorDialogs: true,
//         stickyAuth: true,
//       );
//     } on PlatformException catch (e) {
//       return false;
//     }
//   }
// }

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
