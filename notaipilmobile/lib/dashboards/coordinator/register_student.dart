import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:intl/intl.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/widget_builder.dart';
import 'package:notaipilmobile/register/model/areaModel.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class RegisterStudent extends StatefulWidget {

  const RegisterStudent({ Key? key }) : super(key: key);

  @override
  _RegisterStudentState createState() => _RegisterStudentState();
}

class _RegisterStudentState extends State<RegisterStudent> {

  var _courseValue;
  var _gradeValue;
  var _genderValue;
  var _date;

  int _selectedIndex = 0;

  TextEditingController _processNumberController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _biController = TextEditingController();
  TextEditingController _birthdateController = TextEditingController();
  GlobalKey<FormState> _key = GlobalKey<FormState>();

   @override
   Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              appBar: AppBar(
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
                        accountName: new Text("Rildo Franco", style: TextStyle(color: Colors.white),),
                        accountEmail: new Text("Coordenador", style: TextStyle(color: Colors.white),),
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
                         //Navigator.push(context, MaterialPageRoute(builder: (context) => ))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.group, color: Colors.white,),
                        title: Text('Estudantes', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests()))
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
                        onTap: () => {
                          //Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
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
                child: Stack(
                  children: [
                  Container(
                  padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Lista de Estudantes"),
                                GestureDetector(
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: SizeConfig.widthMultiplier !* 10,
                                    height: SizeConfig.heightMultiplier !* 4,
                                    child: Icon(Icons.person, color: Color(0xFF0D89A4))
                                  ),
                                  onTap: (){
                              
                                  },
                                )
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 5.5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: SizeConfig.widthMultiplier !* 30,
                                  child: SizedBox(
                                    child: DropdownButtonFormField(
                                      hint: Text("Curso"),
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
                                      value: _courseValue,
                                      onChanged: (newValue){
                                        setState((){
                                          _courseValue = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  width: SizeConfig.widthMultiplier !* 30,
                                  child: SizedBox(
                                    child: DropdownButtonFormField(
                                      hint: Text("Classe"),
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
                                      value: _courseValue,
                                      onChanged: (newValue){
                                        setState((){
                                          _courseValue = newValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 8,
                            ),
                            buildTextFieldRegister("N.º de Processo", TextInputType.number, _processNumberController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 2,
                            ),
                            buildTextFieldRegister("Nome Completo", TextInputType.text, _nameController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 2,
                            ),
                            buildTextFieldRegister("N.º do Bilhete", TextInputType.text, _biController),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 2,
                            ),
                            DateTimeField(
                              decoration: InputDecoration(
                                labelText: "Data de Nascimento",
                                suffixIcon: Icon(Icons.event_note, color: Colors.white),
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              controller: _birthdateController,
                              format: DateFormat("yyyy-MM-dd"),
                              style:  TextStyle(color: Colors.white),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                  context: context,
                                  locale: const Locale("pt"),
                                  firstDate: DateTime(1900),
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                ).then((date){
                                  setState((){
                                    _birthdateController.text = date.toString();
                                    _date = date;
                                  });
                                });
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 2,
                            ),
                            DropdownButtonFormField(
                              hint: Text("Sexo"),
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
                                  child: Text("Male"),
                                  value: Text("M"),
                                )
                              ],
                              value: _genderValue,
                              onChanged: (newValue){
                                setState((){
                                  _genderValue = newValue;
                                });
                              },
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier !* 4,
                            ),
                            ElevatedButton(
                              child: Text("Cadastrar"),
                              style: ElevatedButton.styleFrom(
                                primary:  Color(0xFF0D89A4),
                                onPrimary: Colors.white,
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Roboto',
                                  fontSize: 20.0,
                                ),
                              minimumSize: Size(0.0, 50.0),
                              ),
                              onPressed: (){
                                
                              },
                            )
                          ],
                        )
                      )
                    ],
                  ),
                )
                  ],
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