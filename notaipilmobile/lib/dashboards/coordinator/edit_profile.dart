import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';
import 'dart:math';
import 'package:badges/badges.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

class EditProfile extends StatefulWidget {
  late var coordinator = [];

  EditProfile(this.coordinator);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _currentPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _confirmateNewPwdController = TextEditingController();

  int _selectedIndex = 0;
  int? informationLength;

  String? _areaId;

  var coursesLength;
  var area = [];

  @override
  void initState(){
    super.initState();

    setState(() {
      _areaId = widget.coordinator[0]["courses"][0]["areaId"];
      _phoneController.text = widget.coordinator[0]["teacherAccount"]["telephone"];
      _emailController.text = widget.coordinator[0]["teacherAccount"]["email"];
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

    getUnreadInformations(widget.coordinator[2]["userId"], widget.coordinator[2]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    setState((){
      _phoneController.text = widget.coordinator[0]["teacherAccount"]["telephone"];
      _emailController.text = widget.coordinator[0]["teacherAccount"]["email"];

    });
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
                title: Text("NotaIPIL", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontSize: SizeConfig.textMultiplier !* 3.4, fontFamily: fontFamily, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: borderAndButtonColor,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(color: appBarLetterColorAndDrawerColor),
              ),
              drawer: new Drawer(
                child: Container(
                  decoration: BoxDecoration(
                    color: borderAndButtonColor,
                  ),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      UserAccountsDrawerHeader(
                        accountName: new Text(widget.coordinator[0]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        accountEmail: new Text(widget.coordinator[0]["courses"].length == coursesLength ? widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador da Área de " + widget.coordinator[1]["name"] : "Coordenadora da Área de " + widget.coordinator[1]["name"] : widget.coordinator[0]["personalData"]["gender"] == "M" ? "Coordenador do curso de " + widget.coordinator[0]["courses"][0]["code"] : "Coordenadora do curso de " + widget.coordinator[0]["courses"][0]["code"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        currentAccountPicture: new ClipOval(
                          child: widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                        ),
                        otherAccountsPictures: [
                          new CircleAvatar(
                            child: Text(widget.coordinator[0]["personalData"]["fullName"].toString().substring(0, 1)),
                          ),
                        ],
                        decoration: BoxDecoration(
                          color: borderAndButtonColor,
                        ),
                      ),
                      ListTile(
                        leading: Icon(Icons.notifications, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Informações', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        trailing: informationLength !> 0 ?
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
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Coordinatorinformations(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.account_circle, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Perfil', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.coordinator)))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                        title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                        onTap: () => {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(widget.coordinator)))
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
                  )
                )
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight !* 1.12,
                  color: backgroundColor,
                  child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Perfil", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                        SizedBox(height: SizeConfig.heightMultiplier !* 2),
                        Center(
                          child: GestureDetector(
                            child: ClipOval(
                              child:widget.coordinator[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 30) : Image.network(baseImageUrl + widget.coordinator[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 45, height: SizeConfig.imageSizeMultiplier !* 45),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier !* 5),
                        buildTextFormFieldWithIcon("", TextInputType.number, _phoneController, false, icon: Icon(Icons.phone, color: iconColor,)),
                        SizedBox(height: SizeConfig.heightMultiplier !* 1.7),
                        buildTextFieldRegister("", TextInputType.emailAddress, _emailController, icon: Icon(Icons.mail_outlined, color: iconColor,)),
                        SizedBox(height: SizeConfig.heightMultiplier !* 8),
                        buildPasswordFormFieldWithIcon("Palavra-passe actual", _currentPwdController),
                        SizedBox(height: SizeConfig.heightMultiplier !* 1.7),
                        buildPasswordFormFieldWithIcon("Palavra-passe nova", _newPwdController),
                        SizedBox(height: SizeConfig.heightMultiplier !* 1.7),
                        buildPasswordFormFieldWithIcon("Confirmar nova palavra-passe", _confirmateNewPwdController),
                        SizedBox(height: SizeConfig.heightMultiplier !* 5),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                child: Text("Guardar alterações"),
                                style: ElevatedButton.styleFrom(
                                  primary:  borderAndButtonColor,
                                  onPrimary: Colors.white,
                                  textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                                  minimumSize: Size(0.0, 50.0),
                                ),
                                onPressed: (){
                                  if (_phoneController.text != widget.coordinator[0]["teacherAccount"]["telephone"] && _emailController.text != widget.coordinator[0]["teacherAccount"]["email"]){
                                    Map<String, dynamic> body = {
                                      "email": _emailController.text,
                                      "telephone": _phoneController.text,
                                    };
                                  } else if (_phoneController.text != widget.coordinator[0]["teacherAccount"]["telephone"]){
                                    Map<String, dynamic> body = {
                                      "telephone": _phoneController.text,
                                    };
                                  } else if (_emailController.text != widget.coordinator[0]["teacherAccount"]["email"]){
                                    Map<String, dynamic> body = {
                                      "email": _emailController.text,
                                    };
                                  }
                                  if (_currentPwdController.text.isNotEmpty){
                                    if (_newPwdController.text.isNotEmpty){
                                      if (_confirmateNewPwdController.text != _newPwdController.text){
                                        Fluttertoast.showToast(
                                          msg: "Confirmação da palavra-passe não coincide com a nova palavra-passe.",
                                          toastLength: Toast.LENGTH_LONG,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          gravity: ToastGravity.BOTTOM,
                                        ).toString();
                                      } else {

                                      }
                                    }
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
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