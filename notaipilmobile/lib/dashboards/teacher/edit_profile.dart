import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:badges/badges.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/agendas.dart';
import 'package:notaipilmobile/dashboards/teacher/classrooms.dart';
import 'package:notaipilmobile/dashboards/teacher/main_page.dart';
import 'package:notaipilmobile/dashboards/teacher/schedule.dart';
import 'package:notaipilmobile/dashboards/teacher/entities.dart';
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

class EditProfile extends StatefulWidget {

  late var teacher = [];

  EditProfile(this.teacher);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  int _selectedIndex = 0;
  int informationLength = 0;

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _currentPwdController = TextEditingController();
  TextEditingController _newPwdController = TextEditingController();
  TextEditingController _confirmateNewPwdController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _photo = TextEditingController();

  File? image;

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
    });

    setState((){
      _phoneController.text = widget.teacher[0]["teacherAccount"]["telephone"];
      _emailController.text = widget.teacher[0]["teacherAccount"]["email"];

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
                  child: SizedBox(
                    height: SizeConfig.screenHeight,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"], style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                          accountEmail: new Text(widget.teacher[0]["teacherAccount"]["personalData"]["gender"] == "M" ? "Professor" : "Professora", style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          currentAccountPicture: new ClipOval(
                            child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 18) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 23, height: SizeConfig.imageSizeMultiplier !* 23),
                          ),
                          otherAccountsPictures: [
                            new CircleAvatar(
                              child: Text(widget.teacher[0]["teacherAccount"]["personalData"]["fullName"].toString().substring(0, 1)),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)))
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(widget.teacher)))
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.settings, color: appBarLetterColorAndDrawerColor,),
                          title: Text('Definições', style: TextStyle(color: appBarLetterColorAndDrawerColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                          onTap: () => {
                            //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                              child: widget.teacher[0]["teacherAccount"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 30) : Image.network(baseImageUrl + widget.teacher[0]["teacherAccount"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 45, height: SizeConfig.imageSizeMultiplier !* 45),
                            ),
                          ),
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier !* 5),
                        buildTextFormFieldWithIcon("", TextInputType.number, _phoneController, false, icon: Icon(Icons.phone, color: iconColor,)),
                        SizedBox(height: SizeConfig.heightMultiplier !* 3),
                        buildTextFieldRegister("", TextInputType.emailAddress, _emailController, icon: Icon(Icons.mail_outlined, color: iconColor,)),
                        SizedBox(height: SizeConfig.heightMultiplier !* 3),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          readOnly: true,
                          style: TextStyle(color: letterColor),
                          decoration: InputDecoration(
                            labelText: "Fotografia",
                            labelStyle: TextStyle(color: letterColor),
                            filled: true,
                            fillColor: fillColor,
                            border: OutlineInputBorder(),
                          ),
                          controller:  _photo,
                          validator: (String? value){
                            
                          },
                          onTap: (){
                            
                          },
                        ),
                        SizedBox(height: SizeConfig.heightMultiplier !* 8),
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
                                  textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7),
                                  minimumSize: Size(0.0, 50.0),
                                ),
                                onPressed: (){
                                  //buildModal(context, "Foi enviado um código de confirmação para o seu e-mail. Coloque-o abaixo para guardar as alterações.", _codeController);
                                  if (_phoneController.text != widget.teacher[0]["teacherAccount"]["telephone"] && _emailController.text != widget.teacher[0]["teacherAccount"]["email"].toString()){
                                    Map<String, dynamic> body = {
                                      "email": _emailController.text,
                                      "telephone": _phoneController.text,
                                    };
                                  } else if (_phoneController.text != widget.teacher[0]["teacherAccount"]["telephone"].toString()){
                                    Map<String, dynamic> body = {
                                      "telephone": _phoneController.text,
                                    };
                                  } else if (_emailController.text != widget.teacher[0]["teacherAccount"]["telephone"].toString()){
                                    Map<String, dynamic> body = {
                                      "email": _emailController.text,
                                    };
                                  }
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                selectedItemColor: linKColor,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(widget.teacher)));
                      break;
                    case 1:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Classrooms(widget.teacher)));
                      break;
                    case 2:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Schedule(widget.teacher)));
                      break;
                    case 3:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Agendas(widget.teacher)));
                      break;
                    case 4:
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Entities(widget.teacher)));
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

  Future _pickImage(source) async{
    try{
      final image = await ImagePicker().pickImage(source: source);

      if (image == null) return;

      var imageTemporary = File(image.path);
      
      setState((){
        this.image = imageTemporary;
        _photo.text = this.image!.path;
      });

    } on PlatformException catch (e){
      print('Falha ao carregar a imagem: $e');
    }
  }

  _showOptions(contex){
    /*if (Platform.isIOS){
      return showCupertinoModalPopup(
        context: context, 
        builder: (context) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                child: Text("Abrir câmera"),
                onPressed: (){}
              ),
              CupertinoActionSheetAction(
                child: Text("Escolher da galeria"),
                onPressed: (){}
              ),
            ],
          );
        }
      );
    } else {*/
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return BottomSheet(
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Icon(Icons.camera_alt_outlined, color: Colors.black),
                        ),
                        TextButton(
                          child: Text("Abrir câmera"),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0
                            ),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                            _pickImage(ImageSource.camera);
                          }
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      children: [
                        Container(
                          child: Icon(Icons.photo_library_outlined, color: Colors.black),
                        ),
                        TextButton(
                          child: Text("Escolher da galeria"),
                          style: TextButton.styleFrom(
                            primary: Colors.black,
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0
                            ),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                            _pickImage(ImageSource.gallery);
                          }
                        ),
                      ]
                    )
                  ]
                )
              );
            },
            onClosing: (){},
          );
        }
      );
  }
}