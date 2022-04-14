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

class Entities extends StatefulWidget {

<<<<<<< HEAD
  late var student = [];

  Entities(this.student);
=======
  const Entities({ Key? key }) : super(key: key);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
  _EntitiesState createState() => _EntitiesState();
}

class _EntitiesState extends State<Entities> {

  int _selectedIndex = 0;
<<<<<<< HEAD
  int informationLength = 0;
=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
  int _count1 = 0;
  int _count2 = 0;
  int? _quantity;

<<<<<<< HEAD
  var principals = [];
  var coordinators = [];

  @override
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }
=======
  var _fakeEntities = [
    {
      'job': 'Directora Geral',
      'name': 'Philomene José Carlos',
      'subject': 'Director',
    },
    {
      'job': 'Subdirector Pedagógico',
      'name': 'Milton da Silva',
      'subject': 'Director',
    },
    {
      'job': 'Subdirector Administrativo',
      'name': 'Manuel Tomás',
      'subject': 'Director',
    },/*
    {
      'job': 'Coordenador de Área',
      'name': 'Edson Viegas',
      'subject': 'Coordenador',
    },
    {
      'job': 'Coordenador de Curso',
      'name': 'Olívia de Matos',
      'subject': 'Coordenador',
    },*/
  ];

  var _fakeClassrooms = [
    {
      'course': 'Técnico Desenhador Projectista',
      'name': 'Informática',
      'subject': 'TCC',
    },
    {
      'course': 'Técnico Desenhador Projectista',
      'name': 'Informática',
      'subject': 'TCC',
    },
  ];
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
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
<<<<<<< HEAD
                child: FutureBuilder(
                    future: Future.wait([getAllPrincipals()]),
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

                            principals = (snapshot.data! as List)[0];

                            return 
                            Container(
                              padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
                              width: SizeConfig.screenWidth,
                              height: SizeConfig.screenHeight !* 1.2,
                              color: backgroundColor,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  buildHeaderPartTwo("Entidades"),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                  Text("Directores", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                  SizedBox(height: SizeConfig.heightMultiplier !* 4,),
                                  GridView.count(
                                    shrinkWrap: true,
                                    crossAxisCount: 1,
                                    crossAxisSpacing: 10.0,
                                    mainAxisSpacing: 10.0,
                                    childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 4.5,
                                    children: principals.map<Widget>((data){
                                      return GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth,
                                          height: SizeConfig.heightMultiplier !* 2,
                                          child: Card(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Center(
                                                      child: ClipOval(
                                                        child: data["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 45) : Image.network(baseImageUrl + data["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 45, height: SizeConfig.imageSizeMultiplier !* 45),
                                                      ),
                                                    ),
                                                    SizedBox(height: SizeConfig.heightMultiplier !* 2.3),
                                                    Text(data["teacherAccount"]["personalData"]["fullName"].toString(), textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF00D1FF), fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                                    SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                                    Text(data["title"] == "Geral" ? data["teacherAccount"]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : data["teacherAccount"]["personalData"]["gender"] == "M" ? "Sub-Director " + data["title"] : "Sub-Directora " + data["title"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                                  ],
                                              ),
                                            )
                                          ),
                                        ),
                                        onTap: (){
                                              
                                        },
                                      );
                                    }).toList()
                                  )  
                                ]  
                              ),
                            );
                          }
                      }
                    },
=======
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartTwo("Entidades"),
                      GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                        children: _fakeEntities.map<Widget>((data){
                          return GestureDetector(
                                child: Card(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Container(
                                      width: SizeConfig.widthMultiplier !* 10 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                      height: SizeConfig.heightMultiplier !* 4 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                            height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.account_circle, color: Colors.black, size: SizeConfig.imageSizeMultiplier !* 2 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          ),
                                          SizedBox(height: SizeConfig.heightMultiplier !* 2.3),
                                          Text(data["job"].toString(), textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                          Text(data["name"].toString(), textAlign: TextAlign.center, style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                        ],
                                      ),
                                    )
                                  )
                                ),
                                onTap: (){
                                  
                                },
                              );
                        }).toList()
                      )  
                    ]  
                  )
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
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