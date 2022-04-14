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

<<<<<<< HEAD
/**Complements */
import 'package:notaipilmobile/dashboards/student/show_single_information_page.dart';
import 'package:notaipilmobile/dashboards/student/classroom_student.dart';
import 'package:notaipilmobile/dashboards/student/entities.dart';
import 'package:notaipilmobile/dashboards/student/grades_history.dart';
import 'package:notaipilmobile/dashboards/student/main_page.dart';

=======
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class Studetinformations extends StatefulWidget {

<<<<<<< HEAD
  late var student = [];

  Studetinformations(this.student);
=======
  const Studetinformations({ Key? key }) : super(key: key);
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae

  @override
  _StudetinformationsState createState() => _StudetinformationsState();
}

class _StudetinformationsState extends State<Studetinformations> {

  int _selectedIndex = 0;
<<<<<<< HEAD
  int informationLength = 0;

  var informations = [];

  @override
  void initState() {
    
    super.initState();

    getUnreadInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  Future _refresh() async{
    getInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]).then((value) => setState((){informations = value;}));
  }
=======

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
                child: Container(
<<<<<<< HEAD
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 70,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: getInformations(widget.student[1]["userId"], widget.student[1]["typeAccount"]["id"]),
                    builder: (context, snapshot){
                      switch (snapshot.connectionState){
                        case ConnectionState.none:
                        case ConnectionState.waiting:
                          return Container();
                        default:
                          if (snapshot.hasError){
                            return Container();
                          } else {

                            informations = (snapshot.data! as List);

                            return 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Informação", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
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
                                      RefreshIndicator(
                                        onRefresh: _refresh,
                                        child: SizedBox(
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
                                                    color: informations[index]["isSeen"] ? informationSeen : informationNotSeen,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 2),
                                                        ClipOval(
                                                          child: informations[index]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor,size: SizeConfig.imageSizeMultiplier !* 15) : Image.network(baseImageUrl + informations[index]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 14, height: SizeConfig.imageSizeMultiplier !* 14),
                                                        ),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                        Text(informations[index]["fullName"].toString(), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                        Text(informations[index]["title"].toString().substring(0, whiteSpace - 1) + (whiteSpace == informations[index]["title"].toString().length ? "" : "..."), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                        Text(informations[index]["createdAt"].toString().substring(0, 10), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 1.5),
                                                        informations[index]["sent"] ? Icon(Icons.arrow_forward, color: informationSentIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,) : Icon(Icons.arrow_back, color: informationReceivedIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,),
                                                      ]
                                                    )
                                                  ),
                                                ),
                                                onTap: (){
                                                  setReadInformation(widget.student[1]["userId"], informations[index]["id"]);
                                                  setState(() {
                                                    
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSingleInformationPage(widget.student, informations[index]["id"], informations[index]["sent"])));
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          }
                      }
                    }
=======
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 30.0),
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
                          Text("Informação", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                          
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Recebidas", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4))
                              ]
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 50,
                              child: ListView.builder(
                              itemCount: _fakeInformations.length,
                              itemBuilder: (context, index){
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color.fromARGB(255, 34, 42, 55),
                                  child: ListTile(
                                    title: Text(_fakeInformations[index]["mensagem"].toString(), style: TextStyle(color: Colors.white),),
                                    leading: Icon(Icons.info_outline, color: Colors.yellow,),
                                    trailing: Text(_fakeInformations[index]["prazo"].toString(), style: TextStyle(color: Colors.white),),
                                    onTap: (){
                                      buildModal(context, _fakeInformations[index]["prazo"], _fakeInformations[index]["mensagem"]);
                                    },
                                  ),
                                );
                              },
                            ),
                            )
                          ],
                        ),
                      )
                    ]  
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
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
<<<<<<< HEAD
                  switch(index){
                    case 0:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.student)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ClassroomStudent(widget.student)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GradesHistory(widget.student)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Entities(widget.student)));
                      break;
                    default:
                  }
=======
                  
>>>>>>> 4f1a03fcc0ff3075ae9d1fc608492b95e52c41ae
                },
              ),
            );
          },
        );
      },
    );
  }

  Future<Widget>? buildModal(context, date, title){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(15.0),
            width: SizeConfig.widthMultiplier !* 100,
            height: SizeConfig.heightMultiplier !* 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date.toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text(title.toString(), style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Ullamco aute adipisicing nisi Lorem adipisicing. Consequat deserunt ut consectetur in cupidatat eu consequat est veniam dolor magna occaecat dolor. Ad officia eu adipisicing cupidatat et consequat aute excepteur ullamco. Amet enim irure nulla laboris laborum laboris exercitation exercitation veniam. Non sunt pariatur eu elit veniam ex ea velit id qui.",
                  style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                ),
                Text("Ullamco aute adipisicing nisi Lorem adipisicing. Consequat deserunt ut consectetur in cupidatat eu consequat est veniam dolor magna occaecat dolor. Ad officia eu adipisicing cupidatat et consequat aute excepteur ullamco. Amet enim irure nulla laboris laborum laboris exercitation exercitation veniam. Non sunt pariatur eu elit veniam ex ea velit id qui.",
                  style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                ),
                Text("Ficheiros", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text("Para", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
              ],
            ),
          )
        );
      }
    );
  }
}