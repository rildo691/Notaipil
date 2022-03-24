import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/show_information_entities.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_single_information_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

class Coordinatorinformations extends StatefulWidget {

  late var coordinator = [];

  Coordinatorinformations(this.coordinator);

  @override
  _CoordinatorinformationsState createState() => _CoordinatorinformationsState();
}

class _CoordinatorinformationsState extends State<Coordinatorinformations> {

  var _fakeInformations = [
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
  ];
  var informations = [];
  var informationOne = [];

  int _selectedIndex = 0;

  String? _areaId;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var coursesLength;
  var area = [];

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
                        accountName: new Text(widget.coordinator[0]["teacherAccount"]["personalData"]["fullName"], style: TextStyle(color: Colors.white),),
                        accountEmail: new Text(widget.coordinator[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "Professor" : "Professora", style: TextStyle(color: Colors.white),),
                        currentAccountPicture: new ClipOval(
                          child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["teacherAccount"]["personalData"]["fullName"].toString().substring(0, 1)),
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
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 40,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: FutureBuilder(
                    future: getInformations(widget.coordinator[1]["userId"], widget.coordinator[1]["typeAccount"]["id"]),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container(
                            width: SizeConfig.screenWidth,
                            height: SizeConfig.screenHeight,
                            alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                                strokeWidth: 5.0,
                              ),
                          );
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            informations = (snapshot.data as List);

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Informação", style: TextStyle(color: letterColor, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                                    GestureDetector(
                                      child: Container(
                                        width: SizeConfig.widthMultiplier !* 35,
                                        height: SizeConfig.heightMultiplier !* 6.3,
                                        child: ElevatedButton(
                                          child: Text("Enviar"),
                                          style: ElevatedButton.styleFrom(
                                            primary: borderAndButtonColor,
                                            onPrimary: Colors.white,
                                            textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowInformationEntities(widget.coordinator)));
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: SizeConfig.screenWidth,
                                        height: SizeConfig.heightMultiplier !* 7,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(7.0),
                                          color: informationNotSeen,
                                        ),
                                        child: Container(
                                          color: Colors.black,
                                          child: Card(
                                            color: Colors.black,
                                            child: Center(
                                              child: Text("Todas", style: TextStyle(color: Colors.white, fontFamily: fontFamily,))
                                            )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                      SizedBox(
                                        height: SizeConfig.heightMultiplier !* 50,
                                        child: ListView.builder(
                                          itemCount: informations.length,
                                          itemBuilder: (context, index){

                                            int whiteSpace = informations[index]["title"].toString().indexOf(" ");

                                            if (whiteSpace == -1){
                                              whiteSpace = informations[index]["title"].toString().length;
                                            } else if (whiteSpace > 8){
                                              whiteSpace = 8;
                                            }

                                            return GestureDetector(
                                              child: Container(
                                                width: SizeConfig.screenWidth,
                                                height: SizeConfig.heightMultiplier !* 12,
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(10.0),
                                                  ),
                                                  color: informationNotSeen,
                                                  child: Row(
                                                    children: [
                                                      SizedBox(width: SizeConfig.widthMultiplier !* 2),
                                                      ClipOval(
                                                        child: informations[index]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor,size: SizeConfig.imageSizeMultiplier !* 15) : Image.network(baseImageUrl + informations[index]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 14, height: SizeConfig.imageSizeMultiplier !* 14),
                                                      ),
                                                      SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                      Text(informations[index]["fullName"].toString(), style: normalTextStyleWithoutTextSize),
                                                      SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                      Text(informations[index]["title"].toString().substring(0, whiteSpace) + (whiteSpace == informations[index]["title"].toString().length ? "" : "..."), style: normalTextStyleWithoutTextSize),
                                                      SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                      Text(informations[index]["createdAt"].toString().substring(0, 10), style: normalTextStyleWithoutTextSize),
                                                      SizedBox(width: SizeConfig.widthMultiplier !* 1.5),
                                                      informations[index]["sent"] ? Icon(Icons.arrow_forward, color: informationSentIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,) : Icon(Icons.arrow_back, color: informationReceivedIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,),
                                                    ]
                                                  )
                                                ),
                                              ),
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSingleInformationPage(widget.coordinator, informations[index]["id"], informations[index]["sent"])));
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                      }
                    },
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