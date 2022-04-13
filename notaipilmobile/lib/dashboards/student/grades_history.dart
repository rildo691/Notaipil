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

class GradesHistory extends StatefulWidget {

<<<<<<< HEAD
  late var student = [];

  GradesHistory(this.student);
=======
  const GradesHistory({ Key? key }) : super(key: key);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
  _GradesHistoryState createState() => _GradesHistoryState();
}

class _GradesHistoryState extends State<GradesHistory> {

  int _selectedIndex = 0;
<<<<<<< HEAD
  int informationLength = 0;
=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  var _termValue;
  var _classroomvalue;

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
                  padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartTwo("Histórico de notas"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: SizeConfig.widthMultiplier !* 30,
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                hint: Text("Turma"),
                                style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0xFF202733),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.black,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Nothing"),
                                    value: Text("No value either"),
                                  )
                                ],
                                value: _classroomvalue,
                                onChanged: (newValue){
                                  setState((){
                                    _classroomvalue = newValue;
                                  });
                                },
                                validator: (value) => value == null ? 'Preencha o campo Turma' : null,
                              ),
                            ),
                          ),
                          Container(
                            width: SizeConfig.widthMultiplier !* 30,
                            child: SizedBox(
                              child: DropdownButtonFormField(
                                hint: Text("Trimestre"),
                                style: TextStyle(color: Colors.white, fontSize:SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Color(0xFF202733),
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                                dropdownColor: Colors.black,
                                items: [
                                  DropdownMenuItem(
                                    child: Text("Nothing"),
                                    value: Text("No value either"),
                                  )
                                ],
                                value: _termValue,
                                onChanged: (newValue){
                                  setState((){
                                    _termValue = newValue;
                                  });
                                },
                                validator: (value) => value == null ? 'Preencha o campo Trimestre' : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text("ESTATÌSTICAS DO I TRIMESTRE"),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Estado:"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier !* 2.5,
                          ),
                          OutlinedButton(
                            child: Text("Em progresso", style: TextStyle(color: Colors.white)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 3.0, color: Color(0xFFF1BC6D),),
                              primary: Color.fromARGB(255, 34, 42, 55),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: Size(SizeConfig.widthMultiplier !* 45, SizeConfig.heightMultiplier !* 7)
                            ),

                            onPressed: (){}, 
                          ),
                        ]
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Média:"),
                          SizedBox(
                            height: SizeConfig.heightMultiplier !* 2.5,
                          ),
                          OutlinedButton(
                            child: Text("17.05 valores", style: TextStyle(color: Colors.white)),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(width: 3.0, color: Color(0xFF00AD96),),
                              primary: Color.fromARGB(255, 34, 42, 55),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              minimumSize: Size(SizeConfig.widthMultiplier !* 45, SizeConfig.heightMultiplier !* 7)
                            ),

                            onPressed: (){}, 
                          ),
                        ]
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