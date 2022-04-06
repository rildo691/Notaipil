import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';

/**Varibales */
import 'package:notaipilmobile/parts/variables.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/show_information_entities.dart';
import 'package:notaipilmobile/dashboards/principal/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/principal/show_single_information_page.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/principal/show_coordination_teachers.dart';
import 'package:notaipilmobile/dashboards/principal/main_page.dart';

class Principalinformations extends StatefulWidget {
  late var principal = [];

  Principalinformations(this.principal);

  @override
  _PrincipalinformationsState createState() => _PrincipalinformationsState();
}

class _PrincipalinformationsState extends State<Principalinformations> {

  var informations = [];
  var informationOne = [];

  final  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  int? informationLength;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });
  }

  Future _refresh() async{
    getInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]).then((value) => setState((){informations = value;}));
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
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: appBarLetterColorAndDrawerColor),
              ),
              drawer: Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: borderAndButtonColor,
                  ),
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.principal[1]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.principal[0]["title"] == "Geral" ? widget.principal[1]["personalData"]["gender"] == "M" ? "Director Geral" : "Directora Geral" : widget.principal[1]["personalData"]["gender"] == "M" ? "Sub-Director " + widget.principal[0]["title"] : "Sub-Directora " + widget.principal[0]["title"],style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: Center(child: widget.principal[1]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.principal[1]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),)
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.principal[1]["personalData"]["fullName"].toString().substring(0, 1)),
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
                           Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations(widget.principal)))
                          },
                          
                        ),
                        ListTile(
                          leading: Icon(Icons.group, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Pedidos de adesão', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.principal)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.power_settings_new_sharp, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Sair', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => null,
                        ),
                        ListTile(
                          leading: Icon(Icons.help_outline, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Ajuda', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => null,
                        )
                      ]
                    ),
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 30.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !- 70,
                  color: backgroundColor,
                  child: FutureBuilder(
                    future: getInformations(widget.principal[2]["userId"], widget.principal[2]["typeAccount"]["id"]),
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
                                    Text("Informação", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                    GestureDetector(
                                      child: Container(
                                        width: SizeConfig.widthMultiplier !* 35,
                                        height: SizeConfig.heightMultiplier !* 6.3,
                                        child: ElevatedButton(
                                          child: Text("Enviar"),
                                          style: ElevatedButton.styleFrom(
                                            primary: borderAndButtonColor,
                                            onPrimary: Colors.white,
                                            textStyle: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)
                                          ),
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ShowInformationEntities(widget.principal)));
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
                                                        Text(informations[index]["title"].toString().substring(0, whiteSpace) + (whiteSpace == informations[index]["title"].toString().length ? "" : "..."), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 4),
                                                        Text(informations[index]["createdAt"].toString().substring(0, 10), style: TextStyle(color: letterColor, fontFamily: fontFamily)),
                                                        SizedBox(width: SizeConfig.widthMultiplier !* 1.5),
                                                        informations[index]["sent"] ? Icon(Icons.arrow_forward, color: informationSentIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,) : Icon(Icons.arrow_back, color: informationReceivedIconColor, size: SizeConfig.imageSizeMultiplier !* 6.5,),
                                                      ]
                                                    )
                                                  ),
                                                ),
                                                onTap: (){
                                                  setReadInformation(widget.principal[2]["userId"], informations[index]["id"]);
                                                  setState(() {
                                                    
                                                  });
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowSingleInformationPage(widget.principal, informations[index]["id"], informations[index]["sent"])));
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

  Future<Widget>? buildModal(context, information, sent){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(15.0),
            width: SizeConfig.widthMultiplier !* 100,
            height: SizeConfig.heightMultiplier !* 100,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                          ClipOval(
                            child: information[0]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 25) : Image.network(baseImageUrl + information[0]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 25, height: SizeConfig.imageSizeMultiplier !* 25),
                          ),
                          Text(information[0]["fullName"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold),)
                        ]
                      ),
                      sent ? Text("Enviada: " + information[0]["createdAt"].toString().substring(0, 10), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold))
                      : Text("Recebida: " + information[0]["createdAt"].toString().substring(0, 10), style: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold))
                    ]
                  ),
                  SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                  Text(information[0]["title"], style: TextStyle(color: letterColor, fontFamily: fontFamily, fontWeight: FontWeight.bold),),
                  SizedBox(height: SizeConfig.heightMultiplier !* 3,),
                  Text("Descrição: ", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),),
                  SizedBox(height: SizeConfig.heightMultiplier !* 1.5,),
                  //buildTextFormField("", TextInputType.multiline, description, true, isReadOnly: true),
                ],
              ),
            ),
          )
        );
      }
    );
  }
}