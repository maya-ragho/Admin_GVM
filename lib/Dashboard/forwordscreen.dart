import 'package:admin_gvm/Form/listpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../components/components.dart';

class ForwordScreen extends StatefulWidget {
  static const String id = 'forwordscreen';
  final String documentId;

  const ForwordScreen(this.documentId, {super.key});
  @override
  State<ForwordScreen> createState() => _ForwordScreenState();
}

class _ForwordScreenState extends State<ForwordScreen> {
  void initState() {
    super.initState();
    fetchNamesFromFirebase().then((List<Visitor> fetchedVisitors) {
      setState(() {
        visitors =
            fetchedVisitors; // Update the visitors list with the fetched data
        names = fetchedVisitors.map((visitor) => visitor.name).toList();
      });
    }).catchError((error) {
      print("Error fetching names: $error");
    });
  }

  String? selectedAdmin;
  String? selectedAdminEmail;
  List<String> names = [];
  List<Visitor> visitors = [];
  Future<List<Visitor>> fetchNamesFromFirebase() async {
    List<Visitor> visitors = [];
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('admin').get();

      // Extract names and emails from documents
      querySnapshot.docs.forEach((doc) {
        String name = doc.data()['name'];
        String email = doc.data()['email'];
        visitors.add(Visitor(name: name, email: email));
      });

      return visitors;
    } catch (error) {
      // Handle error
      print("Error fetching names: $error");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: custombar(context),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField<String>(
              value: selectedAdmin,
              onChanged: (selectedVisitorName) {
                setState(() {
                  selectedAdmin = selectedVisitorName;
                  // Find the visitor with the selected name
                  Visitor selectedVisitor = visitors.firstWhere(
                      (visitor) => visitor.name == selectedVisitorName);
                  // Store the email of the selected visitor
                  selectedAdminEmail = selectedVisitor.email;
                });
              },
              items: visitors.map((visitor) {
                return DropdownMenuItem<String>(
                  value: visitor.name,
                  child: Center(
                    // Align the text to the center
                    child: Padding(
                      // Add padding to the text
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0,
                          horizontal: 20.0), // Adjust padding as needed
                      child: Text(visitor.name),
                    ),
                  ),
                );
              }).toList(),
              decoration: customElevate('Select Admin', Icons.person),
              validator: (value) {
                // Add validation for required field
                if (value == null || value.isEmpty) {
                  return 'Select the Admin';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Forword Visitor'),
                    content: Text('Your Visitor will be forworded.'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          DocumentReference docRef = FirebaseFirestore.instance
                              .collection('visitor')
                              .doc(widget.documentId);

                          await docRef.update({
                            'selectedAdmin': selectedAdminEmail,
                          });
                          Navigator.pushNamed(context, ListPages.id);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Forword"),
            ),
          ],
        ),
      ),
    );
  }
}

class Visitor {
  final String name;
  final String email;

  Visitor({required this.name, required this.email});
}
