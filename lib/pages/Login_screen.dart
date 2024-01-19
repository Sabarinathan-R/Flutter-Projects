import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_login/pages/BackgroundVideoWidget.dart';
import 'package:user_login/pages/Forgot_Password_page.dart';

class LoginPage extends StatefulWidget{
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          if (e.code == 'invalid-credential') {
            return AlertDialog(
              content: Text(
                'Invalid Email or Password !',
                textAlign: TextAlign.justify,
              ),
            );
          } else
            return AlertDialog(
              content: Text(e.message.toString()),
            );
        },
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const BackgroundVideoWidget(),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
d                      color: Colors.white70,
                      Icons.waving_hand_rounded,
                      size: 120,
                    ),
                    SizedBox(
                      height: 15,
                    ),

                    //Hello There ! message
                    Text('Hello Buddy!',
                        style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 50,
                        ))),

                    //welcome again Paragraph 2

                    Text('Welcome you, once Again!',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                fontSize: 18, color: Colors.white54))),
                    //mailBox
                    SizedBox(height: 30),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: _emailController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: Colors.black,
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter the Email',
                            ),
                          )),
                    ),
                    SizedBox(height: 15),
                    //passwordBox
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Ceolors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          cursorColor: Colors.grey,
                          obscureText: !_isPasswordVisible,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock_outline_rounded,
                                color: Colors.black,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(_isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible = !_isPasswordVisible;
                                  });
                                },
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter the Password'),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ForgotPasswordPage();
                                }));
                              },
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                      color: Colors.cyan,
                                      fontWeight: FontWeight.bold))),
                        ],
                      ),
                    ),

                    SizedBox(height: 15),

                    //signin Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: GestureDetector(
                        onTap: signIn,
                        child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white70,
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                                child: Text('Login',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)))),
                      ),
                    ),
                    SizedBox(height: 15),

                    //forgot password

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an Account?  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        GestureDetector(
                          onTap: widget.showRegisterPage,
                          child: Text('Register Now ',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.cyan,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
