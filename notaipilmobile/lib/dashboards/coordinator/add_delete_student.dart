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
import 'package:notaipilmobile/dashboards/coordinator/students_list.dart';

class AddDeleteStudent extends StatefulWidget {

  const AddDeleteStudent({ Key? key }) : super(key: key);

  @override
  _AddDeleteStudentState createState() => _AddDeleteStudentState();
}

class _AddDeleteStudentState extends State<AddDeleteStudent> {

  int _selectedIndex = 0;
  bool _value = false;

  List<bool> selected = List<bool>.generate(2, (index) => false);

  TextEditingController _processController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  

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
                        accountName: new Text("Rildo Franco", style: TextStyle(color: Colors.white),),
                        accountEmail: new Text("Director", style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text("R"),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Estudantes', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsList()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
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
                          Text("Estudante"),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier !* 10,
                              height: SizeConfig.heightMultiplier !* 4,
                              child: Icon(Icons.person, color:  Color(0xFF0D89A4))
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeleteStudent()));
                            },
                          )
                        ],
                      ),
                      Column(
                        children: [
                          DataTable(
                            showBottomBorder: true,
                            dividerThickness: 5,
                            showCheckboxColumn: true,
                            columnSpacing: SizeConfig.widthMultiplier !* 4,
                            onSelectAll: (newValue){
                              setState(() {
                            
                              });
                            },
                            columns: [
                              DataColumn(
                                label: Text(""),
                                numeric: false
                              ),
                              DataColumn(
                                label: Text(""),
                                numeric: false
                              ),
                              DataColumn(
                                label: Text("N.º"),
                                numeric: false
                              ),
                              DataColumn(
                                label: Text("Nome Completo"),
                                numeric: false
                              ),
                              DataColumn(
                                label: Text(""),
                                numeric: false
                              ),
                            ],
                            rows: [
                              DataRow(
                                cells: [
                                  DataCell(
                                    Text("")
                                  ),
                                  DataCell(
                                    Center(
                                      child: Icon(Icons.account_circle_outlined, color: Colors.white,),
                                    )
                              ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("1")
                                    )
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Rildo William de Melo Franco")
                                    )
                                  ),
                                  DataCell(
                                    Center(
                                      child: Icon(Icons.delete_forever_outlined, color: Colors.white,),
                                    )
                                  ),
                                ],
                                onSelectChanged: (value){
                                  setState(() {
                                    selected[0] = value!;
                                  });
                                },
                                selected: selected[0],
                              ),
                              DataRow(
                                cells: [
                              DataCell(
                                    Text("")
                                  ),
                                  DataCell(
                                    Center(
                                      child: Icon(Icons.account_circle_outlined, color: Colors.white,),
                                    )
                                  ),
                              DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("1")
                                    )
                                  ),
                                  DataCell(
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text("Rildo William de Melo Franco")
                                    )
                                  ),
                                  DataCell(
                                    GestureDetector(
                                      child: Center(
                                       child: Icon(Icons.delete_forever_outlined, color: Colors.white,),
                                      ),
                                      onTap: (){
                                        buildDeleteModal(context, "Tem certeza que pretende eliminar esse estudante dessa turma?");
                                      },
                                    )
                                  ),
                                ],
                                onSelectChanged: (value){
                                  setState(() {
                                    _value = value!;
                                  });
                                },
                                selected: true,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.heightMultiplier !* 4,
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
                          )
                        ],
                      )
                    ]  
                  )
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

  Future<Widget>? buildDeleteModal(context, message){
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
                          child: Text("Nao"),
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