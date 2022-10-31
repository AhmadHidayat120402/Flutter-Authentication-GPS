// import 'package:google_auth_/services/firebase_auth_services.dart';
import 'login_screen.dart';
import 'package:minggu_11_auth/services/firebase_auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseAuthServices fbServices = FirebaseAuthServices();
  final fireAuth = FirebaseAuth.instance;

  register() async {
    try {
      await fireAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('akun berhasil terdaftar, silahkan login !')));
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginScreen()));
    } catch (e) {
      print(e);
    }
  }

  // register() async {
  //   fbServices
  //       .registerAkun(
  //           email: emailController.text, password: passwordController.text)
  //       .then((value) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('${value?.user?.email} Berhasil'),
  //       ),
  //     );
  //   });
  //   Navigator.push(context, MaterialPageRoute(builder: (context) {
  //     return LoginScreen();
  //   }));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Halaman Register')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 5, 20,5),
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
                register();
              },
              child: Text("Register"),
            ),
            // SizedBox(
            //   height: 10,
            // ),
            /*ElevatedButton(
                onPressed: (){
                  register();
                }, 
                child: Text("Register"),
              ),*/
            // SizedBox(
            //   height: 10,
            // ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Text("Login Disini"))
          ],
        ),
      ),
    );
  }
}
