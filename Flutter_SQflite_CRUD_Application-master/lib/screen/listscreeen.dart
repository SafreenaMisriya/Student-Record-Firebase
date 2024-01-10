
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite_10/screen/editstudent.dart';
import 'package:sqflite_10/screen/studentdetails.dart';

class StudentList extends StatefulWidget {
  const StudentList({Key? key}) : super(key: key);

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final CollectionReference student = FirebaseFirestore.instance.collection('Student Record');
   void deletedata(id){
    student.doc(id).delete();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: student.orderBy('Name').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            final DocumentSnapshot studentdetails = snapshot.data!.docs[index];
            return Card(
              color: Colors.lightBlue[50],
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: Image.network(studentdetails['image url'],fit: BoxFit.cover),
                
                title: Text(studentdetails['Name']),
                subtitle: Text(
                  studentdetails['Age'],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit,color: Colors.green,),
                      onPressed: () {
                        Navigator.push(context, 
                        MaterialPageRoute(builder:(context)=>EditStudent(
                          name:studentdetails['Name'], 
                          age: studentdetails['Age'],
                          fatherName: studentdetails['Father Name'],
                          number:studentdetails['Phone No'].toString(),
                          id:studentdetails.id.toString(),
                          url: studentdetails['image url'],
                          )));
                        
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete,color: Colors.red,),
                      onPressed: () {
                      deletedata(studentdetails.id);
                       ScaffoldMessenger.of(context).showSnackBar(
                         const SnackBar(
                         backgroundColor: Colors.red,
                           content: Text(" Deleted Successfully"),
                       ));
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctr) => StudentDetails(
                      name: studentdetails['Name'], 
                      age:studentdetails['Age'],
                      fatherName:studentdetails['Father Name'],
                      number:studentdetails['Phone No'].toString(),
                      url: studentdetails['image url'],

                    ),
                  ));
                },
              ),
            );
          },
        );
        }
        return Container();
      }
    );
  }
}
