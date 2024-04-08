//
//
// import 'dart:convert';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'notification_services.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//
//   NotificationServices notificationServices = NotificationServices();
//
//
//   @override
//   void initState() {
//     super.initState();
//     notificationServices.requestNotificationPermission();
//     notificationServices.forgroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     notificationServices.isTokenRefresh();
//
//     notificationServices.getDeviceToken().then((value){
//       if (kDebugMode) {
//         print('device token');
//         print(value);
//       }
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Notifications'),
//       ),
//       body: Center(
//         child: TextButton(onPressed: (){
//
//           // send notification from one device to another
//           notificationServices.getDeviceToken().then((value)async{
//
//             var data = {
//               'to' : value.toString(),
//               'priority' : 'high',
//               'notification' : {
//                 'title' : 'Maya' ,
//                 'body' : 'You have recived notification' ,
//                 "sound": "jetsons_doorbell.mp3"
//             },
//               // 'android': {
//               //   'notification': {
//               //     'notification_count': 23,
//               //   },
//               // },
//               // 'data' : {
//               //   'type' : 'msj' ,
//               //   'id' : 'Asif Taj'
//               // }
//             };
//
//             await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//             body: jsonEncode(data) ,
//               headers: {
//                 'Content-Type': 'application/json; charset=UTF-8',
//                 'Authorization':'AAAAsPdec3A:APA91bGI9qpi6v1EUZAuP6QE4wLRobKpUqPH-2j5GfUddVvuaGU2GW7VWQ77oEeKETXdb0yOibSXU-s3FhZeCrMKaAqZywnYl6yWL3DQdFon4ZFMjgUzTREYHscPVgqhihI_nTcbfmMW'
//             }
//             ).then((value){
//               if (kDebugMode) {
//                 print(value.body.toString());
//               }
//             }).onError((error, stackTrace){
//               if (kDebugMode) {
//                 print(error);
//               }
//             });
//           });
//         },
//             child: Text('Send Notifications')),
//       ),
//     );
//   }
// }
