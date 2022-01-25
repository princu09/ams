import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  User? user = FirebaseAuth.instance.currentUser;

  Future checkLogin() async {
    
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('email', emailController.text);

    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    setState(() {});
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  // String msg = '';
  //
  // Future<List> _handleLogin() async {
  //   var url = Uri.parse("https://northfoxgroup123.000webhostapp.com/login.php");
  //
  //   final response =  await http.post(url , body: {
  //     "email": emailController.text.trim(),
  //     "password": passwordController.text.trim(),
  //   });
  //
  //   // print(response.body);
  //
  //   var datauser = json.decode(response.body);
  //
  //   if(datauser.length==0){
  //     setState(() {
  //       msg="Login Fail";
  //     });
  //   }else{
  //     Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => MyHomePage()),);
  //     setState(() {
  //       var username = datauser[0]['username'];
  //     });
  //   }
  //
  //   return datauser;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/bg.jpg'), fit: BoxFit.cover),
                ),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 40,
                      width: 80,
                      height: 200,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/light-1.png'))),
                      ),
                    ),
                    Positioned(
                      left: 140,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/light-2.png'))),
                      ),
                    ),
                    Positioned(
                      right: 40,
                      top: 40,
                      width: 80,
                      height: 150,
                      child: Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/clock.png'))),
                      ),
                    ),
                    Positioned(
                        bottom: 180,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            children: <Widget>[
                              const Center(
                                child: Text(
                                  "AMS Login ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          color:
                                              Color.fromRGBO(143, 148, 251, .2),
                                          blurRadius: 20.0,
                                          offset: Offset(0, 10)),
                                    ]),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey))),
                                      child: TextFormField(
                                        controller: emailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.envelope,
                                              size: 17,
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Email Address",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: passwordController,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.lock,
                                              size: 17,
                                            ),
                                            border: InputBorder.none,
                                            hintText: "Password",
                                            hintStyle: TextStyle(
                                                color: Colors.grey[400])),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(colors: [
                                      Color.fromRGBO(143, 148, 251, 1),
                                      Color.fromRGBO(143, 148, 251, .6),
                                    ])),
                                child: Center(
                                  child: SizedBox(
                                    height: 50.0,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      child: const Text("Login",
                                          style: TextStyle(fontSize: 20)),
                                      style: ButtonStyle(
                                        shadowColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent),
                                      ),
                                      onPressed: () {
                                        checkLogin();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 70,
                              ),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
