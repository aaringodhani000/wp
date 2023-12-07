import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wp/second_page.dart';
import 'package:path/path.dart';
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  static Database ?database;

  @override
  State<FirstPage> createState() => _FirstPageState();
}
class _FirstPageState extends State<FirstPage> {
TextEditingController t1=TextEditingController();
TextEditingController t2=TextEditingController();
  get()
  async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'aarin.db');

// Delete the database
//     await deleteDatabase(path);

// open the database
    FirstPage.database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE mangukiya (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT,contact TEXT)');
        });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Shared Prefrence")),backgroundColor: Colors.blueAccent),
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.blueGrey.shade300,
        child: Column(
          children: [
            SizedBox(height: 30,),
            SizedBox(
              height: 50,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(controller: t1,
                   textAlignVertical: TextAlignVertical.center,
                   textAlign: TextAlign.start,
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    hintStyle: TextStyle(
                      color: Colors.white,
                       fontSize: 22
                    ),
                    isDense: true,
                    prefixIcon: Icon(Icons.person,size: 30),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.yellow,width:2,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black,width: 2),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20,),

            SizedBox(
              height: 50,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(controller: t2,
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: "Mobile Number",
                    hintStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 22
                    ),
                    isDense: true,
                    prefixIcon: Icon(Icons.phone,size: 30),
                    border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.yellow,width:2,),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.black,width: 2),
                    ),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30,),

            ElevatedButton(onPressed: (){
                String name=t1.text;
                String contact=t2.text;
                String sql="insert into mangukiya(id,name,contact) values(NULL,'$name','$contact')";
                FirstPage.database!.rawInsert(sql).then((value) {
                  print(value);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SecondPage();
                  },));
                });
              // Navigator.push(context, CupertinoPageRoute(builder: (context) => SecondPage(),));
            }, child: Text("Submit"),),
          ],
        ),
      ),
    );
  }
}
