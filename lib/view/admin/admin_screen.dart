import 'package:flutter/material.dart';
import 'package:labbridge/view/admin/widgets/above_section.dart';
import 'drawer/drawer.dart';


class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AdminDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AboveSection(),
                const Text('الحالات :', style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}