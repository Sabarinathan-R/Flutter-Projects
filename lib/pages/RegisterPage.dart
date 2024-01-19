//ignore_for_file: prefer_const_constructors,
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:user_login/pages/BackgroundVideoWidget.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({super.key, required this.showLoginPage});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future signUp() async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      if (passwordConfirmed() == false) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  shadowColor: Colors.white,
                  content: Text("Error: Password Not Match"));
            });
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          if (e.code == 'channel-error') {
            return AlertDialog(
              content: Text(
                'Please Enter valid Email & Password',
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

  bool passwordConfirmed() {
    if (_confirmPasswordController.text.trim() ==
        _passwordController.text.trim()) {
      return true;
    } else {
      return false;
    }
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
                      Icons.rocket_launch_sharp,
                      size: 150,
                      color: Colors.white70,
                    ),

                    //Hello There ! message
                    Text('Hey Hello!',
                        style: GoogleFonts.bebasNeue(
                            textStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 50,
                        ))),

                    //welcome again Paragraph 2

                    Text('Give Your Details Below!',
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
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          cursorColor: Colors.grey,
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
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
                    SizedBox(height: 15),
                    //passwordBox
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            cursorColor: Colors.grey,
                            controller: _confirmPasswordController,
                            obscureText: !_isPasswordVisible,
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
                                hintText: 'Confirm Your Password'),
                          )),
                    ),
                    SizedBox(height: 25),
                    //signin Button
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: GestureDetector(
                            onTap: signUp,
                            child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Colors.white60,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                  child: Text(
                                    'SignUp',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )))),

                    SizedBox(height: 15),

                    //forgot password

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already an User?  ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        GestureDetector(
                          onTap: widget.showLoginPage,
                          child: Text('Login Now',
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
