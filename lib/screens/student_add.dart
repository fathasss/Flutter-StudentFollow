import 'package:fathasss_flutter/models/Student.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class StudentAdd extends StatefulWidget{
  List<Student> students;
/*
* StudentAdd(List<Student> students){
* this.students = students;
* }
* Alttaki fonskiyon bu fonksiyonun kısaltılmış halidir.
*/
  StudentAdd(this.students);

  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();
  }
}

class _StudentAddState extends State<StudentAdd>{
  var globalKey = GlobalKey<FormState>();
  Student student = Student("","",0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yeni Öğrenci Ekle")
        ),
      body: Container(
        margin: EdgeInsets.all(20.0), //Tüm köşelerden 20 br boşluk bırakır.
        child: Form(
          key: globalKey,
          child: Column(
            children: [
              buildFirstNameField(),
              buildLastNameField(),
              buildGradeField(),
              buildSubmitButton()
            ],
          )
        ),
      ),
    );
  }

  Widget buildFirstNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Adı",hintText: "Fatih"),
      onSaved: (String value){
        student.firstName = value;
      },
    );
  }
  Widget buildLastNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Soyadı",hintText: "HAS"),
      onSaved: (String value){
        student.lastName = value;
      },
    );
  }
  Widget buildGradeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: "Öğrenci Notu",hintText: "65"),
      onSaved: (String value){
        student.grade = int.parse(value);
      },
    );
  }
  Widget buildSubmitButton(){
    // ignore: deprecated_member_use
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: (){
        globalKey.currentState.save();
        widget.students.add(student);
        Navigator.pop(context);
      },
    );
  }
}
/*
* students listesinden veri çekildiği için geri butonu otomatik tanımlandı.
*
*
* */