import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/select_teachers_page.dart';
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

class SendInformationTeachers extends StatefulWidget {
  late var principal = [];

  SendInformationTeachers(this.principal);

  @override
  _SendInformationTeachersState createState() => _SendInformationTeachersState();
}

class _SendInformationTeachersState extends State<SendInformationTeachers> {

  TextEditingController _subjectController = TextEditingController();
  TextEditingController _messageController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int? informationLength;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informationLength = value;}));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 9) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9, height: SizeConfig.imageSizeMultiplier !* 9),
                    onPressed: (){
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  )
                ],
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 42, 55),
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
                            ),
                          ],
                          decoration: BoxDecoration(
                            color: drawerColor,
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
                        )
                      ]
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 60,
                  color: backgroundColor,
                  child: Form(
                    key: _key,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Enviar uma determinada informação", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Assunto:", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                            SizedBox(height: SizeConfig.heightMultiplier !* 3),
                            buildTextFormField("Escreva um assunto", TextInputType.text, _subjectController, false),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mensagem:", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                            SizedBox(height: SizeConfig.heightMultiplier !* 3),
                            buildTextFormField("Escreva uma mensagem", TextInputType.multiline, _messageController, true),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: SizeConfig.widthMultiplier !* 27,
                              height: SizeConfig.heightMultiplier !* 6.5,
                              child: ElevatedButton(
                                child: Text("Anexar"),
                                style: ElevatedButton.styleFrom(
                                  primary: borderAndButtonColor,
                                  onPrimary: Colors.white,
                                  textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)
                                ),
                                onPressed: (){
                                  if (_key.currentState!.validate()){

                                  }
                                },
                              )
                            ),
                            Container(
                              width: SizeConfig.widthMultiplier !* 27,
                              height: SizeConfig.heightMultiplier !* 6.5,
                              child: ElevatedButton(
                                child: Text("Enviar"),
                                style: ElevatedButton.styleFrom(
                                  primary: borderAndButtonColor,
                                  onPrimary: Colors.white,
                                  textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)
                                ),
                                onPressed: (){
                                  if (_key.currentState!.validate()){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SelectTeachersPage(widget.principal, [{'subject': _subjectController.text, 'message': _messageController.text}])));
                                  }
                                },
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
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
}
