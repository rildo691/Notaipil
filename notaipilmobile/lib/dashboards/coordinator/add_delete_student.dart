import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

class AddDeleteStudent extends StatefulWidget {

  late String classroomId;
  late var coordinator = [];

  AddDeleteStudent(this.classroomId, this.coordinator);

  @override
  _AddDeleteStudentState createState() => _AddDeleteStudentState();
}

class _AddDeleteStudentState extends State<AddDeleteStudent> {

  int _selectedIndex = 0;
  bool _value = false;

  List<bool>? _selected;

  TextEditingController _processController = TextEditingController();
  TextEditingController _numberController = TextEditingController();

  String? _areaId;

  var coursesLength;
  var area = [];
  var students = [];
  var gender = [];

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

  Future<void> start() async{
    await Future.delayed(Duration(seconds: 3));
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            var index;
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
                        accountEmail: new Text(widget.coordinator[0]["personalData"]["gender"] == "M" ? widget.coordinator[0]["courses"].length == coursesLength ? "Coordenador da Área de ${widget.coordinator[1]["name"]}" : "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : widget.coordinator[0]["courses"].length == coursesLength ? "Coordenadora da Área de ${widget.coordinator[1]["name"]}" : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: Colors.white),),
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
                child: FutureBuilder(
                  future: Future.wait([getAllClassroomStudents(widget.classroomId), getClassroomGender(widget.classroomId)]),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: Color.fromARGB(255, 34, 42, 55),
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D89A4)),
                            strokeWidth: 5.0
                          )
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {

                          students = (snapshot.data! as List)[0];
                          gender = (snapshot.data! as List)[1];

                          return 
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
                            width: SizeConfig.screenWidth,
                            height: students.length < 7 ? students.length < 5 ? SizeConfig.screenHeight !- students.length * 50 : SizeConfig.screenHeight !* students.length / 6 : SizeConfig.screenHeight !* students.length / 25,
                            color: Color.fromARGB(255, 34, 42, 55),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Estudante"),
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: SizeConfig.widthMultiplier !* 10,
                                        height: SizeConfig.heightMultiplier !* 4,
                                        child: Icon(Icons.person, color:  Color(0xFF0D89A4))
                                      ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeleteStudent(widget.classroomId, widget.coordinator)));
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 12),
                                Column(
                                  children: [
                                    DataTable(
                                      showBottomBorder: true,
                                      dividerThickness: 5,
                                      showCheckboxColumn: true,
                                      columnSpacing: SizeConfig.widthMultiplier !* 2,
                                      onSelectAll: (newValue){
                                        setState(() {
                                      
                                        });
                                      },
                                      columns: [
                                        DataColumn(
                                          label: Text(""),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("N.º"),
                                          numeric: true
                                        ),
                                        DataColumn(
                                          label: Text("Proc."),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("Nome Completo"),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text("Sexo"),
                                          numeric: false,
                                        ),
                                        DataColumn(
                                          label: Text(""),
                                          numeric: false,
                                        ),
                                      ],
                                      rows: students.map((e) => 
                                        DataRow(
                                          cells: [
                                            DataCell(
                                              Center(child: Icon(Icons.account_circle, color: Colors.white,),)
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["number"].toString(), textAlign: TextAlign.center)
                                              ),
                                              showEditIcon: false,
                                              placeholder: true,
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["student"]['process'].toString(), textAlign: TextAlign.center)
                                              ),
                                              showEditIcon: false,
                                              placeholder: true,
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(e["student"]["personalData"]['fullName'].toString(), textAlign: TextAlign.left)
                                              ),
                                              showEditIcon: false,
                                              placeholder: false,
                                              onTap: (){
                                                //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e)));
                                              }
                                            ),
                                            DataCell(
                                              Align(
                                                alignment: Alignment.center,
                                                child: Text(e["student"]["personalData"]['gender'].toString(), textAlign: TextAlign.center)
                                              ),
                                              showEditIcon: false,
                                              placeholder: false,
                                            ),
                                            DataCell(
                                              GestureDetector(
                                                child: Center(
                                                child: Icon(Icons.delete_forever_outlined, color: Colors.white,),
                                                ),
                                                onTap: (){
                                                  buildDeleteModal(context, "Tem certeza que pretende eliminar esse estudante dessa turma?", e);
                                                },
                                              )
                                            )
                                          ]
                                        )
                                      ).toList(),
                                    ),
                                    SizedBox(
                                      height: SizeConfig.heightMultiplier !* 3,
                                    ),
                                    GestureDetector(
                                      child: Container(
                                        width: SizeConfig.screenWidth !- 30,
                                        height: SizeConfig.heightMultiplier !* 8,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Adicionar estudante"),
                                            Icon(Icons.add_circle_outline_outlined, color: Colors.white)
                                          ],
                                        )
                                      ),  
                                      onTap: (){
                                        buildAddModal(context, "Inserir aluno");
                                      },
                                    ),
                                    SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("MASCULINOS: _${gender[0]["m"]}_ FEMENINOS: _${gender[0]["f"]}_", style: TextStyle(color: Colors.white)),
                                    )
                                  ],
                                )
                              ]  
                            )
                          );
                        }
                    }
                  }
                )
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
                  switch(index){
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.coordinator)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(widget.coordinator)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordination(widget.coordinator)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(widget.coordinator)));
                      break;
                    default:
                  }
                },
              ),
            );
          },
        );
      },
    );    
  }

  Future<Widget>? buildDeleteModal(context, message, student){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text(message, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 209, 255, 0.49),
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){

                          },
                        ),
                        ElevatedButton(
                          child: Text("Não"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ]
            ),
          )
        );
      }
    );
  }   

  Future<Widget>? buildAddModal(context, message){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.white),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ]
                ),
                buildTextFieldRegister("Processo", TextInputType.number, _processController),
                buildTextFieldRegister("N.º", TextInputType.number, _numberController),
                ElevatedButton(
                  child: Text("Concluir"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 209, 255, 0.49),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    
                  },
                ),
              ]
            ),
          )
        );
      }
    );
  }
}