import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/variables.dart';
import 'package:notaipilmobile/register/model/areaModel.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';

/**User Interface */
import 'package:expansion_tile_card/expansion_tile_card.dart';

class MainPage extends StatefulWidget {

  late var principal = [];
  MainPage(this.principal);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;
  int? informationLength;

  var token;
  var students = [];
  var teachers = [];
  var courses = [];
  var classrooms = [];
  var coordinators = [];
  
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  ApiService helper = ApiService();  

  final GlobalKey<ExpansionTileCardState> card = new GlobalKey();

  Future verifyUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      token = preferences.getString('token');
    });
    token == null ? Navigator.pushNamed(context, '/') : Navigator.pushNamed(context, '/dashboard');
  }

  Future _logOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    Navigator.pushNamed(context, '/');
  }

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
              key: _key,
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: appBarColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: iconColor),
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: drawerColor,
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
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
                          leading: Icon(Icons.notifications, color: iconColor,),
                          title: Text('Informações', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: iconColor,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: iconColor,),
                          title: Text('Perfil', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: iconColor,),
                          title: Text('Definições', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.power_settings_new_sharp, color: iconColor,),
                          title: Text('Sair', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.help_outline, color: iconColor,),
                          title: Text('Ajuda', style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => null,
                        )
                      ]
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: Future.wait([getAllCourses(), getAllClassrooms(), getAllTeachers(), getAllStudents(), getAllCoordinations()]),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                        case ConnectionState.none:
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
                            courses = (snapshot.data! as List)[0];
                            classrooms = (snapshot.data! as List)[1];
                            teachers = (snapshot.data! as List)[2];
                            students = (snapshot.data! as List)[3];
                            coordinators = (snapshot.data! as List)[4];

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GridView.count(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 7.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 6,
                                  children: [
                                    _buildCard("Cursos", courses.length.toString(), Color.fromARGB(255, 0, 191, 252)),
                                    _buildCard("Turmas", classrooms.length.toString(), Color.fromARGB(255, 241, 188, 109)),
                                    _buildCard("Professores", teachers.length.toString(), Color.fromARGB(255, 13, 137, 164)),
                                    _buildCard("Estudantes", students.length.toString(), Color.fromARGB(255, 225, 106, 128)),
                                  ],
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Expanded(
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: coordinators.length,
                                    itemBuilder: (context, index){
                                      return Column(
                                        children: [
                                          _buildCoordinatorCard(coordinators[index]),
                                          SizedBox(height: SizeConfig.heightMultiplier !* 2,)
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }
                      }
                    },
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

  Widget _buildCard(String s, String t, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.4 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
            ),
            SizedBox(width: 7.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(t, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text(s, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCoordinatorCard(index){
    return ExpansionTileCard(
      baseColor: Colors.white,//Color(0xFF1F2734),
      expandedColor: Colors.white,//Color(0xFF1F2734),
      leading: ClipOval(
        child: index["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 15) : Image.network(baseImageUrl + index["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 14, height: SizeConfig.imageSizeMultiplier !* 14),
      ),
      title: Text(index["coordinator"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
      subtitle: Text("Área de Formação de " + index["areaName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
      children: [
        Divider(
          thickness: 1.0,
          height: 2.0,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cursos: " + index["courses"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
                Text("Turmas: " + index["classrooms"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
                Text("Alunos: " + index["students"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),),
              ],
            ),
          ),
        ),
        ButtonBar(
          alignment: MainAxisAlignment.spaceAround,
          buttonHeight: SizeConfig.heightMultiplier !* .5,
          buttonMinWidth: SizeConfig.widthMultiplier !* .5,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0)
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ShowCoordination(index["areaId"], widget.principal)));
              },
              child: Column(
                children: <Widget>[
                  Icon(Icons.swap_vert),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text('Ver coordenação'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}