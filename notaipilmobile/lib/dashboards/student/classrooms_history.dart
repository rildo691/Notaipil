import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/areaModel.dart';
<<<<<<< HEAD
import 'package:notaipilmobile/functions/functions.dart';
import 'package:badges/badges.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';
=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**User Interface */
import 'package:expansion_tile_card/expansion_tile_card.dart';

class ClassroomsHistory extends StatefulWidget {

<<<<<<< HEAD
  late var student = [];

  ClassroomsHistory(this.student);
=======
  const ClassroomsHistory({ Key? key }) : super(key: key);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
  _ClassroomsHistoryState createState() => _ClassroomsHistoryState();
}

class _ClassroomsHistoryState extends State<ClassroomsHistory> {

  int _selectedIndex = 0;
<<<<<<< HEAD
  int informationLength = 0;
=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  var _selected1 = true;
  var _selected2 = false;
  var _selected3 = false;
  var _selected4 = false;

  var _fakeClassrooms = [
    {
      'course': 'Técnico Desenhador Projectista',
      'name': 'CP10A',
      'subject': 'TCC',
    },
    {
      'course': 'Técnico Desenhador Projectista',
      'name': 'CP10B',
      'subject': 'TCC',
    },
    {
      'course': 'Técnico Desenhador Projectista',
      'name': 'CP10C',
      'subject': 'TCC',
    },
  ];

  @override
<<<<<<< HEAD
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  @override
=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              appBar: AppBar(
<<<<<<< HEAD
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
=======
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
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
              ),
              drawer: new Drawer(
                child: Container(
                  decoration: BoxDecoration(
<<<<<<< HEAD
                    color: borderAndButtonColor,
=======
                    color: Color.fromARGB(255, 34, 42, 55),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
<<<<<<< HEAD
                        accountName: new Text(widget.student[0]["student"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.student[0]["student"]["personalData"]["gender"] == "M" ? "Aluno" : "Aluna", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.student[0]["student"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.student[0]["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.student[0]["student"]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: borderAndButtonColor,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                        trailing: informationLength > 0 ?
                          Badge(
                            toAnimate: false,
                            shape: BadgeShape.circle,
                            badgeColor: Colors.red,
                            badgeContent: Text(informationLength.toString(), style: TextStyle(color: Colors.white),),
                          ) :
                          Container(
                            width: 20,
                            height: 20,
                          ),
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
=======
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
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: Colors.white,),
                        title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
<<<<<<< HEAD
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
=======
                        leading: Icon(Icons.settings, color: Colors.white,),
                        title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
                        },
                      ),
                      ListTile(
<<<<<<< HEAD
                        leading: Icon(Icons.power_settings_new_sharp, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Sair', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => null,
                      ),
                      ListTile(
                        leading: Icon(Icons.help_outline, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Ajuda', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => null,
=======
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
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                      )
                    ]
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartTwo("Turmas"),
                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("CLASSES: ", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                          SizedBox(height: SizeConfig.heightMultiplier !* 3),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                child: Text("10ª"),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                  primary: _selected1 ? Colors.white : Colors.black,
                                  backgroundColor: _selected1 ? Color(0xFF0D89A4) : Colors.white,
                                  textStyle: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selected1 = true;
                                    _selected2 = false;
                                    _selected3 = false;
                                    _selected4 = false;
                                  });
                                }
                              ),
                              TextButton(
                                child: Text("11ª"),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                  primary: _selected2 ? Colors.white : Colors.black,
                                  backgroundColor: _selected2 ? Color(0xFF0D89A4) : Colors.white,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selected1 = false;
                                    _selected2 = true;
                                    _selected3 = false;
                                    _selected4 = false;
                                  });
                                },
                              ),
                              TextButton(
                                child: Text("12.ª"),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                  primary: _selected3 ? Colors.white : Colors.black,
                                  backgroundColor: _selected3 ? Color(0xFF0D89A4) : Colors.white,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selected1 = false;
                                    _selected2 = false;
                                    _selected3 = true;
                                    _selected4 = false;
                                  });
                                },
                              ),
                              TextButton(
                                child: Text("13.ª"),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
                                  primary: _selected4 ? Colors.white : Colors.black,
                                  backgroundColor: _selected4 ? Color(0xFF0D89A4) : Colors.white,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.bold
                                  )
                                ),
                                onPressed: (){
                                  setState(() {
                                    _selected1 = false;
                                    _selected2 = false;
                                    _selected3 = false;
                                    _selected4 = true;
                                  });
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        children: _fakeClassrooms.map((data){
                          return Column(
                            children: [
                              GestureDetector(
                                child: Card(
                                  color: Color(0xFF222A37),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Container(
                                      width: SizeConfig.widthMultiplier !* 10 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                      height: SizeConfig.heightMultiplier !* 2.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(data["name"].toString(), style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                          Text("2020/21", style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                        ],
                                      ),
                                    )
                                  ),
                                ),
                                onTap: (){
                                  
                                },
                              )
                            ],
                          );
                        }).toList()
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
}