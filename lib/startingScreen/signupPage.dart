import 'package:admin_gvm/Dashboard/Dashboard_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'loginScreen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static String id = 'signupscreen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;
  final _auth = FirebaseAuth.instance;

  Future<void> _signUp() async {
  }
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: PreferredSize(
        child: ClipPath(
          clipper: CurveAppBar(),
          child: AppBar(
            backgroundColor: Color(0xFF7BE3FA),
          ),
        ),
        preferredSize: Size.fromHeight(150),
      ),      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(children: [
            Container(
              padding: EdgeInsets.only(
                  left: w * 0.04, right: w * 0.04, top: h * 0.15),
              child: Center(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Signup Screen',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30)),
                      SizedBox(height: h * 0.03),

                      TextFormField(
                        controller: nameController,
                        style: const TextStyle(color: Colors.black),
                        // Set text color
                        maxLines: 3, // Maximum lines allowed
                        minLines: 1, // Minimum lines allowed

                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Enter your name',
                          prefixIcon: Icon(Icons.person),
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                        validator: (value) {
                          List<String Function(String?)> validators = [
                                (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return '';
                            },
                                (value) {
                              if (value != null && value.length < 3) {
                                return 'Name must be at least 3 characters';
                              }
                              return '';
                            },
                                (value) {
                              if (value != null && value.length > 30) {
                                return 'Name must be less than 30 characters';
                              }
                              return '';
                            },
                            // Add additional validators as needed
                          ];

                          for (var validator in validators) {
                            final error = validator(value);
                            if (error.isNotEmpty) {
                              return error;
                            }
                          }
                          return ''; // Return empty string if all validators pass
                        },
                      ),



                      const SizedBox(height: 20),
                      TextFormField(
                        controller: emailController,
                        style: const TextStyle(color: Colors.black),
                        // Set text color
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),

                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          // Email format validation
                          final emailRegExp = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                          if (!emailRegExp.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          // Add additional email validation here if needed
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: contactController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.black),
                        // Set text color
                        decoration: InputDecoration(
                          labelText: 'Contact Number',
                          hintText: 'Enter your contact number',
                          prefixIcon: Icon(Icons.call),
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your contact number';
                          }
                          // Check if entered value contains only digits and has a length of 10
                          final isValidNumber = RegExp(r'^\d{10}$').hasMatch(value);
                          if (!isValidNumber) {
                            return 'Please enter a valid 10-digit number';
                          }
                          return null;
                        },
                      ),


                      const SizedBox(height: 20),

                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        style: const TextStyle(color: Colors.black),
                        // Set text color
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          prefixIcon: Icon(Icons.password),
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blueGrey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 7) {
                            return 'Password must be at least 7 characters long';
                          }
                          // Add additional password validation here if needed
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: _isObscure,
                        style: const TextStyle(color: Colors.black),
                        // Set text color
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          prefixIcon: Icon(Icons.password),
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please conform your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: h * 0.07,
                        width: w * 0.5,
                        child: ElevatedButton(

                          onPressed: () async {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              final newuser =
                                  await _auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              if (newuser != null) {
                                await FirebaseFirestore.instance
                                    .collection('admin')
                                    .add({
                                  'name': nameController.text,
                                  'email': emailController.text,
                                  'phone': contactController.text,
                                });
                                Navigator.pushNamed(
                                    context, DashboardScreen.id);
                              }
                            }
                          },
                          child:  Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.redAccent),

                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'I have account?',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
    }
  }

class CurveAppBar extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    final Path path = Path();
    path.moveTo(0,0);
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 5, size.height / 2.5, size.width /2, size.height - 50);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper){
    throw UnimplementedError();
  }
}
