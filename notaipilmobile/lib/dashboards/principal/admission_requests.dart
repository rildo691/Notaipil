import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';
import 'dart:math';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';

class AdmissionRequests extends StatefulWidget {
  late var principal = [];
  AdmissionRequests(this.principal);

  @override
  _AdmissionRequestsState createState() => _AdmissionRequestsState();
}

class _AdmissionRequestsState extends State<AdmissionRequests> {

  TextEditingController _nameController = TextEditingController();
  DataTableSource _data = MyData();

  bool? value = false;
  int _selectedIndex = 0;

  var requests = [];

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
                        accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new CircleAvatar(
                          child: Icon(Icons.account_circle_outlined),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
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
                         Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Pedidos de adesão', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
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
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: getAdmissionRequests(),
                    builder: (context, snapshot){
                      switch(snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0D89A4)),
                              strokeWidth: 5.0,
                            ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {
                            requests = (snapshot.data! as List);

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildHeaderPartTwo("Pedidos de adesão"),
                                SizedBox(height: SizeConfig.heightMultiplier !* 10),
                                _buildTextFormField("Pesquise o n.º do bilhete", TextInputType.text, _nameController),
                                SizedBox(height: SizeConfig.heightMultiplier !* 12),
                                DataTable(
                                  columnSpacing: SizeConfig.widthMultiplier !* 7,
                                  columns: [
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
                                      numeric: false
                                    )
                                  ],
                                  rows: requests.map((e) => 
                                    DataRow(
                                      cells: [
                                        DataCell(
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(e["personalData"]["fullName"].toString()),
                                          ),
                                          onTap: (){
                                            _buildSingleAdmissionRequestModal(e);
                                          }
                                        ),
                                        DataCell(
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(e["personalData"]["bi"].toString()),
                                          ),
                                          onTap: (){
                                            _buildSingleAdmissionRequestModal(e);
                                          }
                                        ),
                                        DataCell(
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(e["createdAt"].toString().substring(0, 10)),
                                          ),
                                          onTap: (){
                                            _buildSingleAdmissionRequestModal(e);
                                          }
                                        ),
                                      ],
                                    )
                                  ).toList()
                                ),
                              ],
                            );
                          }
                      }
                    },
                  )
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.principal)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomsPage(index, widget.principal)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordinationTeachers(index, widget.principal)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ShowAgendaState(index, widget.principal)));
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

  Widget _buildTextFormField(String hint, TextInputType type, TextEditingController controller){
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
        filled: true,
        fillColor: Color(0xFF202733),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
    );
  }

  Future<Widget>?  _buildSingleAdmissionRequestModal(index){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.widthMultiplier !* 100,
            height: SizeConfig.heightMultiplier !* 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(index["createdAt"].toString().substring(0, 10), textAlign: TextAlign.end, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Bilhete: " + index["personalData"]["bi"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Nome: " + index["personalData"]["fullName"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Sexo: " + index["personalData"]["gender"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Data de nascimento: " + index["personalData"]["birthdate"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                SizedBox(height: SizeConfig.heightMultiplier !* 2),
                Text("Categoria: " + index["category"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Habilitações Literárias: " + index["qualification"]["name"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Tempo de serviço no IPIL: " + index["ipilDate"].toString().substring(0, 10), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Tempo de serviço na Educação: " + index["educationDate"].toString().substring(0, 10), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Regime Laboral: " + index["regime"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                SizedBox(height: SizeConfig.heightMultiplier !* 2),
                Text("E-mail: " + index["email"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Contacto: " + index["telephone"].toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                SizedBox(height: SizeConfig.heightMultiplier !* 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: Text("Aceitar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade400,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                      ),
                      onPressed: (){
                                  
                      },
                    ),
                    ElevatedButton(
                      child: Text("Recusar"),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                      ),
                      onPressed: (){
                        
                      },
                    ),
                  ],
                )
              ]
            ),
          ),
        );
      }
    );
  }
}

class Admission{
  String? name;
  String? title;
  String? date;
  bool selected = false;

  Admission(this.name, this.title, this.date);
}

class MyData extends DataTableSource{
  bool? _value = false;
  final _data = List.generate(
    200,
    (index) => {
      Admission(index.toString(), "Name $index", "Item $index")
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
  DataRow? getRow(int index) {
    Admission ad = _data.elementAt(index) as Admission;
    
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(""),
          onTap: (){
          
        }),
        DataCell(Text(ad.name.toString(), style: TextStyle(color: Colors.white)),
          onTap: (){
          
        }),
        DataCell(Text(ad.title.toString(), style: TextStyle(color: Colors.white)),
          onTap: (){
          
        }),
        DataCell(
          Align(
            alignment: Alignment.centerRight,
            child: Text(ad.date.toString(), textAlign: TextAlign.right, style: TextStyle(color: Colors.white))
          ),
          onTap: (){

          }
        ),
      ],
      onSelectChanged: (value){
        _value = value;
        notifyListeners();
      }
    );
  }  
}