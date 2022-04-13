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

/**Complements */
import 'package:notaipilmobile/dashboards/student/edit_profile.dart';

class Profile extends StatefulWidget {

<<<<<<< HEAD
  late var student = [];

  Profile(this.student);
=======
  const Profile({ Key? key }) : super(key: key);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  int _selectedIndex = 0;
<<<<<<< HEAD
  int informationLength = 0;
  String name = "";

  @override
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    String oldName = widget.student[0]["student"]["personalData"]["fullName"].toString();
    var firstIndex = widget.student[0]["student"]["personalData"]["fullName"].toString().indexOf(" ");
    var lastIndex = widget.student[0]["student"]["personalData"]["fullName"].toString().lastIndexOf(" ");
    setState((){
      name = oldName.substring(0, firstIndex).toUpperCase() + oldName.substring(lastIndex, oldName.length).toUpperCase();
    });
  }
=======
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
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.student)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
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
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
                        },
                      ),
                      ListTile(
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
                  padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
<<<<<<< HEAD
                  color:  backgroundColor,
=======
                  color: Color.fromARGB(255, 34, 42, 55),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
<<<<<<< HEAD
                      SizedBox(height: SizeConfig.heightMultiplier !* 4,),
=======
                       SizedBox(height: SizeConfig.heightMultiplier !* 4,),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
<<<<<<< HEAD
                          Text("Perfil", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
=======
                          Text("Perfil", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              width: SizeConfig.widthMultiplier !* 10,
                              height: SizeConfig.heightMultiplier !* 4,
<<<<<<< HEAD
                              child: Icon(Icons.brush_outlined, color: iconColor)
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(widget.student)));
=======
                              child: Icon(Icons.brush_outlined, color: Colors.white)
                            ),
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                            },
                          )
                        ],
                      ),
<<<<<<< HEAD
                      SizedBox(height: SizeConfig.heightMultiplier !* 5,),
=======
                      SizedBox(height: SizeConfig.heightMultiplier !* 6,),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
<<<<<<< HEAD
                          Center(
                            child: ClipOval(
                              child: widget.student[0]["student"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 20) : Image.network(baseImageUrl + widget.student[0]["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 20, height: SizeConfig.imageSizeMultiplier !* 20),
                            ),
=======
                          Container(
                            width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                            height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 2.3 * double.parse(SizeConfig.textMultiplier.toString()) * 1,),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                          ),
                          SizedBox(width: SizeConfig.widthMultiplier !* 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
<<<<<<< HEAD
                              Text(name.toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7, fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                              Text("ESTUDANTE", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7))
=======
                              Text("Rildo William de Melo Franco", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                              SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                              Text("Director", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),)
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                            ],
                          ),
                        ],
                      ),
<<<<<<< HEAD
                      SizedBox(height: SizeConfig.heightMultiplier !* 13,),
                      Container(
                        width: SizeConfig.screenWidth,
                        decoration: BoxDecoration(
                          boxShadow: [
                            new BoxShadow(
                              color: Colors.black,
                              blurRadius: 4.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Dados pessoais", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.cake_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("Nascido aos " + widget.student[0]["student"]["personalData"]["birthdate"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                ]
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.perm_contact_cal_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("B.I. nº: " + widget.student[0]["student"]["personalData"]["bi"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
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
                              blurRadius: 4.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Dados académicos", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.cast_for_education, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("N' de Processo: " + widget.student[0]["student"]["process"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                ]
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.co_present_rounded, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text("Turma: " + widget.student[0]["classroom"]["name"].toString() + " / " + "Nº: " + widget.student[0]["number"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
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
                              blurRadius: 4.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(7.0),
                          color: backgroundColor,
                        ),
                        child: Card(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Contactos", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.4, fontWeight: FontWeight.bold)),
                              SizedBox(height: SizeConfig.heightMultiplier !* 3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.contact_phone, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text(widget.student[0]["student"]["email"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                ]  
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 1.3),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: SizeConfig.widthMultiplier !* 3),
                                  Icon(Icons.contact_mail, color: iconColor),
                                  SizedBox(width: SizeConfig.widthMultiplier !* 5),
                                  Text(widget.student[0]["student"]["telephone"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.2)),
                                ]
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),      
=======
                      SizedBox(height: SizeConfig.heightMultiplier !* 8,),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.phone, color: Colors.white,),
                              Text("996889295")
                            ],
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier !* 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.mail_outline_rounded, color: Colors.white,),
                              Text("rildowilliam2017@gmail.com")
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nome Completo:"),
                          Text("Sexo:"),
                          Text("Data de nascimento:"),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 10,),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("N.º de Processo:"),
                          Text("N.º:"),
                          Text("Turma:"),
                          Text("Sala:"),
                          Text("Período:"),
                        ],
                      ),
                    ]  
                  )
                ),
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
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