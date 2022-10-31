// import 'package:minggu_11_new/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minggu_11_auth/services/firebase_auth_services.dart';
import 'home_screen_maps.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthServices fbServices = FirebaseAuthServices();
  final fireAuth = FirebaseAuth.instance;
  // @override
  // void initState() {
  //   super.initState();
  //   cekUser();
  // }

  // cekUser() {
  //   var userData = fireAuth.currentUser;

  //   if (userData != null) {
  //     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
  //       Navigator.of(context)
  //           .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
  //     });
  //   }
  // }

  login() async {
    try {
      await fireAuth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('berhasil login')));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => Mymaps()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("silahkan register terlebih dahulu !")));
    }
  }
  // login() async {
  //   fbServices
  //       .loginAkun(
  //           email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('${value?.user?.email} Berhasil Login')));
  //   });
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return Home();
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Login')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login'),
            SizedBox(
              height: 30,
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Masukan Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Masukan Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text("Login"),
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => RegisterScreen(),
                  ),
                );
              },
              child: Text("Register Disini !"),
            )
          ],
        ),
      ),
    );
  }
}
