import 'package:admin_gvm/Dashboard/forwordscreen.dart';
import 'package:admin_gvm/Form/listpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class Profilepage extends StatefulWidget {
  static String id = 'Profilepage';
  final String documentId;

  const Profilepage(this.documentId, {super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  String? stats;
  List<String> stat = [
    'Approved',
    'Denied',
    'Wait 10 min',
    'Wait 15 min',
    'Wait 20 min',
  ];

  Future<DocumentSnapshot> fetchUserData(String documentId) async {
    try {
      return await FirebaseFirestore.instance
          .collection('visitor')
          .doc(documentId)
          .get();
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custombar(context),
      body: FutureBuilder<DocumentSnapshot>(
        future: fetchUserData(widget.documentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          } else {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            String imageUrl = userData[
                'image']; // Assuming 'image' is the field storing the image URL

            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                            radius: 40,
                          ), // Use placeholder image if URL is null

                          const SizedBox(width: 10),
                          Text(
                            userData['name'] ?? 'No Name',
                            style: const TextStyle(fontSize: 24),
                          ),
                          const SizedBox(width: 10),
                          const SizedBox(width: 10),
                          IconButton(
                            icon: const Icon(
                              Icons.share,
                              size: 40.0,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ForwordScreen(widget.documentId),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20.0,
                            left: 20.0,
                            right: 20.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.email),
                                  title: Text('Email : ${userData['email']}'),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.phone),
                                  title: Text(
                                      'Visitor Phone : ${userData['phone']}'),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.book_outlined),
                                  title: Text('Reason : ${userData['reason']}'),
                                ),
                                const Divider(),
                                DropdownButtonFormField<String>(
                                  value: stats,
                                  onChanged: (newValue) {
                                    setState(() {
                                      stats = newValue;
                                    });
                                  },
                                  items: stat.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: Text(gender),
                                    );
                                  }).toList(),
                                  decoration: customElevate(
                                      'Select Status', Icons.person),
                                  validator: (value) {
                                    // Add validation for required field
                                    if (value == null || value.isEmpty) {
                                      return 'Select Status';
                                    }
                                    return null;
                                  },
                                ),
                                const Divider(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }
        },
      ),
      backgroundColor: const Color(0xFFCFF3F8),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Update Status'),
                content: Text('Check The Approval Once'),
                actions: [
                  TextButton(
                    onPressed: () async {
                      DocumentReference docRef = FirebaseFirestore.instance
                          .collection('visitor')
                          .doc(widget.documentId);

                      await docRef.update({
                        'status': stats,
                      });
                      Navigator.pushNamed(context, ListPages.id);
                    },
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(Icons.update),
          label: const Text('Update'),
        ),
      ),
    );
  }
}
