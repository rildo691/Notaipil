import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:jiffy/jiffy.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/edit_profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

class Profile extends StatefulWidget {
  late var coordinator = [];

  Profile(this.coordinator);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _selectedIndex = 0;

  String? _areaId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var coursesLength;
  var area = [];
  late var ipilTimeYear = Jiffy(now).diff(widget.coordinator[0]["teacherAccount"]["ipilDate"], Units.YEAR);
  late var educationTimeYear = Jiffy(now).diff(widget.coordinator[0]["teacherAccount"]["educationDate"], Units.YEAR);

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
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){
                      _scaffoldKey.currentState!.openDrawer();
                    },
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
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 100,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeConfig.heightMultiplier !* 4,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Perfil", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier !* 10,
                              height: SizeConfig.heightMultiplier !* 4,
                              child: Icon(Icons.brush_outlined, color: Colors.white)
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(widget.coordinator)));
                            },
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipOval(
                              child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 20) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 20, height: SizeConfig.imageSizeMultiplier !* 20),
                            ),
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier !* 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                              SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                              Text(widget.coordinator[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "PROFESSOR DO " + widget.coordinator[0]["teacherAccount"]["category"].toString().toUpperCase() : "PROFESSORA DO " + widget.coordinator[0]["teacherAccount"]["category"].toString().toUpperCase(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                              SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                              Text(widget.coordinator[0]["personalData"]["gender"] == "M" ? widget.coordinator[0]["courses"].length == coursesLength ? "COORDENADOR DA ÁREA DE ${area[0]["name"]}" : "COORDENADOR DO CURSO DE " + widget.coordinator[0]["courses"][0]["code"] : widget.coordinator[0]["courses"].length == coursesLength ? "COORDENADORA DA ÁREA DE ${area[0]["name"]}" : "COORDENADORA DO CURSO " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: Colors.white),)
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 13,),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Dados pessoais", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.cake_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("Nascido aos " + widget.coordinator[0]["teacherAccount"]["personalData"]["birthdate"]),
                                ]
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.perm_contact_cal_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("B.I. nº: " + widget.coordinator[0]["teacherAccount"]["personalData"]["bi"]),
                                ]
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Tempo de serviço", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.cast_for_education, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("No IPIL há " + ipilTimeYear.toString() + " " + "anos"),
                                ]
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.co_present_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("No MED há " + educationTimeYear.toString() + " " + "anos" ),
                                ]
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Contactos", style: TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.contact_phone, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text(widget.coordinator[0]["teacherAccount"]["telephone"].toString()),
                                ]
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.contact_mail, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text(widget.coordinator[0]["teacherAccount"]["email"]),
                                ]
                              )
                            ],
                          ),
                        ),
                      ),
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
}