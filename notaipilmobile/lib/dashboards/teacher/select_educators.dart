import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/parts/register.dart';
import 'dart:math';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/teacher/profile.dart';
import 'package:notaipilmobile/dashboards/teacher/teacherInformations.dart';

class SelectEducators extends StatefulWidget {
  late var teacher = [];
  late var information = [];

  SelectEducators(this.teacher, this.information);

  @override
  _SelectEducatorsState createState() => _SelectEducatorsState();
}

class _SelectEducatorsState extends State<SelectEducators> {

  int _selectedIndex = 0;
  int? informationLength;

  TextEditingController _nameController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<bool>? _selected;
  bool _firstTime = false;
  bool isFull = false;

  var educators = [];
  var recipients = [];

  @override
  void initState(){
    super.initState();

    getUnreadInformations(widget.teacher[1]["userId"], widget.teacher[1]["typeAccount"]["id"]).then((value) {
      if (mounted){
        setState((){informationLength = value;});
      }
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
                          trailing: informationLength != 0 ? ClipOval(
                            child: Container(
                              color: Colors.red,
                              width: 20,
                              height: 20,
                              child: Center(
                                child: Text(
                                  informationLength.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ) : Container(
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
                child: FutureBuilder(
                  future: getEducators(widget.teacher[1]["userId"]),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
                          alignment: Alignment.center,
                          color: backgroundColor,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(borderAndButtonColor),
                            strokeWidth: 5.0,
                          ),
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {

                          var educators = (snapshot.data! as List);

                          if (!_firstTime){
                            _selected = List<bool>.generate(educators.length, (index) => false);
                            _firstTime = true;
                          }

                          return
                          Container(
                            padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 10.0),
                            width: SizeConfig.screenWidth,
                            /*height: classrooms.length > 6 ? SizeConfig.screenHeight !* classrooms.length / 7 : SizeConfig.screenHeight,*/
                            height: SizeConfig.screenHeight,
                            color: backgroundColor,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Selecione o destinatário", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  style: TextStyle(color: letterColor, fontFamily: fontFamily),
                                  decoration: InputDecoration(
                                    labelText: "Pesquise o Nome",
                                    labelStyle: TextStyle(color: letterColor, fontFamily: fontFamily),
                                    filled: true,
                                    fillColor: fillColor,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller:  _nameController,
                                  validator: (String? value){
                                    if (value!.isEmpty){
                                      return "Preencha o campo Pesquise o Nome";
                                    }
                                  },
                                  onFieldSubmitted: (String? value) {
                                    if (value!.isNotEmpty){
                                      _filter(value);
                                    }
                                  },
                                  onChanged: (value){
                                    if (value.isEmpty){
                                      
                                      setState((){
                                        _firstTime = false;
                                        isFull = false;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 3),
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children:[ 
                                      DataTable(
                                        showCheckboxColumn: true,
                                        columnSpacing: SizeConfig.widthMultiplier !* 10,
                                        columns: [
                                          DataColumn(
                                            label: Text(""),
                                            numeric: false
                                          ),
                                          DataColumn(
                                            label: Text("Encarregado"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Estudante"),
                                            numeric: false,
                                          ),
                                        ],
                                        rows: List<DataRow>.generate(educators.length, (index) => 
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: ClipOval(
                                                    child: educators[index]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + educators[index]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(educators[index]["fullName"])
                                                )
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(educators[index]["student"][0].toString())
                                                )
                                              ),
                                            ],
                                            selected: _selected![index],
                                            onSelectChanged: (bool? value){
                                              _selected![index] = value!;
                                              setState((){
                                                
                                              });
                                            }
                                          )
                                        ),
                                      ),
                                    ]  
                                  ),
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 4),
                                Container(
                                  width: SizeConfig.widthMultiplier !* 30,
                                  height: SizeConfig.heightMultiplier !* 7,
                                  child: ElevatedButton(
                                    child: Text("Confirmar"),
                                    style: ElevatedButton.styleFrom(
                                      primary: borderAndButtonColor,
                                      onPrimary: Colors.white,
                                      textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7)
                                    ),
                                    onPressed: () async{
                                      
                                      for (int i = 0; i < _selected!.length; i++){
                                        if (_selected![i] != false){
                                          recipients.add(educators[i]["email"]);
                                        }
                                      }

                                      Map<String, dynamic> body = {
                                        "title": widget.information[0]["subject"].toString(),
                                        "description": widget.information[0]["message"].toString(),
                                        "userId": widget.teacher[1]["userId"],
                                        "typeAccountId":  widget.teacher[1]["typeAccount"]["id"],
                                        "group": "Encarregado",
                                        "usersDestiny": recipients
                                      };

                                      var response = await helper.post("informations", body);
                                      buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => Teacherinformtions(widget.teacher)));
                                    },
                                  ),
                                )
                              ],
                            ),    
                          );
                        } 
                    }
                  }
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

  _filter(value){
    getEducatorsByName(widget.teacher[1]['userId'], value)!.then((valueF) => setState((){educators = valueF;}));
    setState(() {
      isFull = false;
    });
  }
}