import 'package:admin_gvm/Dashboard/profilepage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class ListPages extends StatelessWidget {
  static String id = 'listpage';

  const ListPages({super.key, required id});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: custombar(context),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('visitor')
            .where('selectedAdmin',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var document = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(document['image']),
                        ),
                        title: Text(document['name']),
                        subtitle: Row(
                          children: [
                            Text(document['phone'].toString()),
                          ],
                        ),
                        trailing: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profilepage(document.id),
                              ),
                            );
                          },
                          child: Text('Check Status'),
                        ),
                      ),
                    );
                  });
            } else {
              return Center(child: Text('No data found'));
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
