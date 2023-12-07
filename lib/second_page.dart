import 'package:flutter/material.dart';
import 'package:wp/first_page.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List l=[];
  view_data()
  async {
    String sql="select * from mangukiya";
   l=await FirstPage.database!.rawQuery(sql);
    setState(() {
      
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    view_data();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView.builder(itemCount: l.length,itemBuilder: (context, index) {
        return ListTile(title: Text("${l[index]['id']}||${l[index]['name']}||${l[index]['contact']}"),);
      },)
    );
  }
}
