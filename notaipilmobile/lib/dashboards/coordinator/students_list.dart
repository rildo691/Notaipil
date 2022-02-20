import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/register_student.dart';
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/students_list.dart';

class StudentsList extends StatefulWidget {
  late var coordinator = [];

  StudentsList(this.coordinator);

  @override
  _StudentsListState createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {

  var _courseValue;
  var _gradeValue;
  var coursesLength;
  var area = [];

  int _selectedIndex = 0;

  TextEditingController _nameController = TextEditingController();

  DataTableSource _data = MyData();

  String? _areaId;

  @override
  void initState(){
    super.initState();

    setState(() {
      _areaId = widget.coordinator[0]["courses"][0]["areaId"];
    });

    getAreaById(widget.coordinator[0]["courses"][0]["areaId"]).then((value) =>
      setState((){
        area = value;
      })
    );

    getCoursesByArea(widget.coordinator[0]["courses"][0]["areaId"]).then((value) => 
      setState((){
        coursesLength = value.length;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: new Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 42, 55),
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.coordinator[0]["personalData"]["gender"] == "M" ? widget.coordinator[0]["courses"].length == coursesLength ? "Coordenador da Área de ${area[0]["name"]}" : "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : widget.coordinator[0]["courses"].length == coursesLength ? "Coordenadora da Área de ${area[0]["name"]}" : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 34, 42, 55),
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: Colors.white,),
                        title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Estudantes', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsList(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.power_settings_new_sharp, color: Colors.white,),
                        title: Text('Sair', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => null,
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline, color: Colors.white,),
                        title: Text('Ajuda', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => null,
                        trailing: ClipOval(
                          child: Container(
                            color: Colors.red,
                            width: 20,
                            height: 20,
                            child: Center(
                              child: Text(
                                '8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                  Container(
                  padding: EdgeInsets.fromLTRB(8.0, 40.0, 8.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Lista de Estudantes"),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier !* 10,
                              height: SizeConfig.heightMultiplier !* 4,
                              child: Icon(Icons.person, color: Colors.white)
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterStudent(widget.coordinator)));
                            },
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: SizeConfig.widthMultiplier !* 30,
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                hint: Text("Curso"),
                                style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0xFF202733),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.black,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Nothing"),
                                    value: Text("No value either"),
                                  )
                                ],
                                value: _courseValue,
                                onChanged: (newValue){
                                  setState((){
                                    _courseValue = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier !* 30,
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                hint: Text("Classe"),
                                style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0xFF202733),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.black,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Nothing"),
                                    value: Text("No value either"),
                                  )
                                ],
                                value: _courseValue,
                                onChanged: (newValue){
                                  setState((){
                                    _courseValue = newValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      buildTextFieldRegister("Pesquise por nome", TextInputType.text, _nameController),
                      PaginatedDataTable(
                        source: _data,
                        rowsPerPage: 5,
                        columns: [
                          DataColumn(
                            label: Text("N.º"),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Proc."),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Nome"),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Bilhete"),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Data"),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text(""),
                            numeric: false,
                          ),
                        ],
                      )
                    ],
                  ),
                )
                  ],
                ),
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Color(0xFF151717),
                elevation: 1,
                mouseCursor: SystemMouseCursors.grab,
                selectedFontSize: 15,
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
                selectedIconTheme: IconThemeData(color: Color(0xFF0D89A4), size: 30,),
                selectedItemColor: Color(0xFF0D89A4),
                unselectedItemColor: Colors.grey,
                unselectedLabelStyle: TextStyle(color: Colors.grey),
                items: const <BottomNavigationBarItem> [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',                    
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                ],
                currentIndex: _selectedIndex,
                onTap:(index){
                  setState(() {
                    _selectedIndex = index;
                  });
                  
                },
              ),
            );
          },
        );
      },
    );
  }
}

class MyData extends DataTableSource{
  final _data = List.generate(
    200,
    (index) => {
      "id": index,
      "title": "Item $index",
      "price": "1"
    });   
    var _selected = List<bool?>.generate(200, (index) => false
  );

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
      DataCell(Text(_data[index]["id"].toString(), style: TextStyle(color: Colors.white)),),
      DataCell(Text(_data[index]["title"].toString(), style: TextStyle(color: Colors.white)),),
      DataCell(
        Align(
          alignment: Alignment.centerRight,
          child: Text(_data[index]["price"].toString(), textAlign: TextAlign.right, style: TextStyle(color: Colors.white))
        )
      ),
      DataCell(Text(_data[index]["title"].toString(), style: TextStyle(color: Colors.white)),),
      DataCell(Text(_data[index]["title"].toString(), style: TextStyle(color: Colors.white)),),
      DataCell(Center(child: Icon(Icons.brush_outlined, color: Colors.white,),)),
    ],
  );
  }  
}