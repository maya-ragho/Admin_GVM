//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class ForgotScreen extends StatefulWidget {
//   const ForgotScreen({required Key key}) : super(key: key);
//
//   static const String id = 'forgot_password_screen';
//
//   @override
//   State<ForgotScreen> createState() => _ForgotScreenState();
// }
//
// class _ForgotScreenState extends State<ForgotScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   bool _isSending = false;
//
//   void _resetPassword() async {
//     setState(() {
//       _isSending = true;
//     });
//
//     try {
//       await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
//       _showResetDialog('Password Reset', 'Password reset email has been sent.');
//     } catch (error) {
//       print('Error: $error');
//       _showResetDialog('Error', 'Password reset email has failed: $error');
//     } finally {
//       setState(() {
//         _isSending = false;
//       });
//     }
//   }
//
//   void _showResetDialog(String title, String content) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Forgot Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//               ),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _isSending ? null : _resetPassword,
//               child: _isSending
//                   ? const CircularProgressIndicator()
//                   : const Text('Reset Password'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }











// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class ForgotPasswordPage extends StatelessWidget {
//   static const String id = 'forgot_password';
//    ForgotPasswordPage({super.key});
//
//   final TextEditingController emailController = TextEditingController();
//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: Text('Forgot Password'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: emailController,
//               decoration: InputDecoration(
//                 hintText: 'abc@gmail.com'
//               ),
//             ),
//             SizedBox(height: 10,),
//             TextButton(
//                 onPressed: (){
//                   auth.sendPasswordResetEmail(email: emailController.text.toString()).then((value){
//                     Utils.toastMessage("We have send you email to recover password, please check email");
//                   }).onError((error, stackTrace){
//                     Utils.toastMessage(error.toString());
//                   });
//                   print('success');
//                 },
//                 child: Text('Forgot'),)
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class Utils {
//   static void toastMessage(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.black45,
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }
//
//
