import 'package:fathasss_flutter/models/Student.dart';
import 'package:fathasss_flutter/screens/student_add.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

/*
    runApp - Flutter uygulamasını çalıştırır.
    Flutter' da olay widget mantığı üzerinden çalışır.
    Widget: Küçük ekran parçaları.
    Flutter' da bütün mimari bir ağaç yapısı şeklinde widgetlerda gerçekleşir.
    Bir sınıfın widget olabilmesi için StatelessWidget sınıfından extends edilmesi gereklidir.
    class PersonelManager extends StatelessWidget{ }
*/
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner:
            false, //Yukarıdaki debug simgesini kaldırır.
        home: HomeScreen());
  }
/*
* MaterialApp Widget'i material.dart paketinden gelir.
* Tasarımsal fonksiyondur.MaterialApp sınıfının yapıcı methodları içindekileridr.
* Widget' i çağırmak için build fonksiyonu gereklidir.
* Parametrelerin başına ve sonuna süslü parantez konulursa
*
*  class Customer extends Person{
*     Customer(); //Yapıcı method.
*     Customer.withInfo({String firstName, String lastName}){ }
*   }
*
* Kullanımında parametreler çağırılırken aşağıdaki gibi çağırılır.
*
* Person customer1 = new Customer.withInfo(firstName:"Fatih",lastName:"HAS");
*
* Gibi çağırılır.
*/
}
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

// ignore: must_be_immutable
class _HomeScreenState extends State {
  List<Student> students = [
    Student.withId(1, "Fatih", "HAS", 90),
    Student.withId(2, "Mert", "TEZ", 45),
    Student.withId(3, "Mert", "DEMİRAY", 40),
    Student.withId(4, "Buse", "KOCA", 95),
  ];

  Student selectedStudent = Student.withId(0, "Hiç kimse", " ", 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(), //Scaffold widget gövdesi
      appBar: AppBar(title: Text("Takip Sistemi")),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: students.length, //student listesinin eleman sayısı kadar çalışacak.
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index){
                return ListTile(
                  title: Text(students[index].firstName +"  "+ students[index].lastName),
                  subtitle: Text("Sınav Notu: "+" "+students[index].grade.toString()+" "+"["+students[index].getStatus+"]"),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage("https://pbs.twimg.com/profile_images/1069333123442319360/X3bSC-gF_400x400.jpg"),
                  ),
                  trailing: buildStatusIcon(students[index].grade),
                  onTap: (){
                    setState(() {
                      this.selectedStudent = students[index];
                    });
                  },
                  onLongPress: (){
                    print("Uzun basıldı.");
                  },
                );
              }
          ),
        ),
        Text("Seçili Öğrenci " + selectedStudent.firstName +" "+ selectedStudent.lastName),
        Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: RaisedButton(
                color: Colors.greenAccent,
                child:Row(
                  children: [
                    Icon(Icons.add),
                    SizedBox(width:5.0),
                    Text("Yeni Öğrenci")
                  ],
                ),
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentAdd(students)));//onPressed buton Click olayıdır.
                  },
              )
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.grey,
                  child:Row(
                    children: [
                      Icon(Icons.update),
                      SizedBox(width:5.0),
                      Text("Güncelle")
                    ],
                  ),
                  onPressed: (){
                    print("Güncelle");
                  },
                )
            ),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.redAccent,
                  child:Row(
                    children: [
                      Icon(Icons.delete),
                      SizedBox(width:5.0),
                      Text("Sil")
                    ],
                  ),
                  onPressed: (){
                    print("Sil");
                  },
                )
            )
          ],
        )
      ],
    );
    /*1. alan ListView Öğeleri listelemek
      2. alan Text
      3. alan satır (row)
      ListView builder extend edildi Expanded ile boyut hatası kaldırıldı.
      Expanded listeye güvenli bir alan tahsisi yaptı.
      Row yanyayana ekleme yapmamızı sağlar.
    */
  }
  Widget buildStatusIcon(int grade) {
    if(grade>=50){
      return Icon(Icons.done); //Okey iconu
    }
    else if(grade>40){
      return Icon(Icons.album); //Yuvarlak iconu
    }
    else{
      return Icon(Icons.clear); //delete iconu
    }
  }
}

