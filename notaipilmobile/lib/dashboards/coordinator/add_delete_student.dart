import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_classroom_page.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:intl/intl.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:badges/badges.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Model */
import 'package:notaipilmobile/register/model/classroomStudentModel.dart';
import 'package:notaipilmobile/register/model/student.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/coordinator/coordinatorInformations.dart';
import 'package:notaipilmobile/dashboards/coordinator/profile.dart';
import 'package:notaipilmobile/dashboards/coordinator/settings.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_coordination.dart';
import 'package:notaipilmobile/dashboards/coordinator/show_agenda_state.dart';
import 'package:notaipilmobile/dashboards/coordinator/classrooms_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class AddDeleteStudent extends StatefulWidget {

  late String classroomId;
  late var coordinator = [];

  AddDeleteStudent(this.classroomId, this.coordinator);

  @override
  _AddDeleteStudentState createState() => _AddDeleteStudentState();
}

class _AddDeleteStudentState extends State<AddDeleteStudent> {

  int _selectedIndex = 0;
  int? informationLength;

  bool _value = false;
  List<bool>? _selected;

  TextEditingController _processController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _numeroBIController = TextEditingController();
  TextEditingController _birthdate = TextEditingController();

  
  ClassroomStudentModel classroomStudent = ClassroomStudentModel();
  Student studentAccount = Student();

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _areaId;

  var coursesLength;
  var area = [];
  var students = [];
  var gender = [];
  var student;
  var _genderValue;

  @override
  void initState(){
    super.initState();

    setState(() {
      _areaId = widget.coordinator[0]["courses"][0]["areaId"];
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
  }

  Future<void> start() async{
    await Future.delayed(Duration(seconds: 3));
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            var index;
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
                child: FutureBuilder(
                  future: Future.wait([getAllClassroomStudents(widget.classroomId), getClassroomGender(widget.classroomId)]),
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
                            strokeWidth: 5.0
                          )
                        );
                      default:
                        if (snapshot.hasError){
                          return Container();
                        } else {

                          students = (snapshot.data! as List)[0];
                          gender = (snapshot.data! as List)[1];

                          return 
                          Container(
                            padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 30.0),
                            width: SizeConfig.screenWidth,
                            /*height: students.length < 7 ? students.length < 5 ? SizeConfig.screenHeight !- students.length * 50 : SizeConfig.screenHeight !* students.length / 6 : SizeConfig.screenHeight !* ((students.length * 10)/60),*/
                            height: SizeConfig.screenHeight,
                            color: backgroundColor,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("Estudante"),
                                    GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: SizeConfig.widthMultiplier !* 10,
                                        height: SizeConfig.heightMultiplier !* 4,
                                        child: Icon(Icons.person, color:  Color(0xFF0D89A4))
                                      ),
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddDeleteStudent(widget.classroomId, widget.coordinator)));
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 12),
                                Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    children: [
                                      DataTable(
                                        showBottomBorder: true,
                                        dividerThickness: 5,
                                        showCheckboxColumn: true,
                                        columnSpacing: SizeConfig.widthMultiplier !* 2,
                                        onSelectAll: (newValue){
                                          setState(() {
                                            
                                          });
                                        },
                                        columns: [
                                          DataColumn(
                                            label: Text(""),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("N.º"),
                                            numeric: true
                                          ),
                                          DataColumn(
                                            label: Text("Proc."),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Nome Completo"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text("Sexo"),
                                            numeric: false,
                                          ),
                                          DataColumn(
                                            label: Text(""),
                                            numeric: false,
                                          ),
                                        ],
                                        rows: students.map((e) => 
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Center(
                                                  child: ClipOval(
                                                    child: e["student"]["avatar"] == null ? Icon(Icons.account_circle, color: profileIconColor, size: SizeConfig.imageSizeMultiplier !* 10) : Image.network(baseImageUrl + e["student"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 9.5, height: SizeConfig.imageSizeMultiplier !* 9),
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(e["number"].toString(), textAlign: TextAlign.center)
                                                ),
                                                showEditIcon: false,
                                                placeholder: true,
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(e["student"]['process'].toString(), textAlign: TextAlign.center)
                                                ),
                                                showEditIcon: false,
                                                placeholder: true,
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(e["student"]["personalData"]['fullName'].toString(), textAlign: TextAlign.left)
                                                ),
                                                showEditIcon: false,
                                                placeholder: false,
                                                onTap: (){
                                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => StudentStats(widget.coordinator, e)));
                                                }
                                              ),
                                              DataCell(
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Text(e["student"]["personalData"]['gender'].toString(), textAlign: TextAlign.center)
                                                ),
                                                showEditIcon: false,
                                                placeholder: false,
                                              ),
                                              DataCell(
                                                GestureDetector(
                                                  child: Center(
                                                  child: Icon(Icons.delete_forever_outlined, color: iconColor,),
                                                      ),
                                                  onTap: (){
                                                    buildDeleteModal(context, "Tem certeza que pretende eliminar esse estudante dessa turma?", e);
                                                  },
                                                )
                                              )
                                            ]
                                          )
                                        ).toList(),
                                      ),
                                    ]
                                  ),
                                ),
                                SizedBox(
                                  height: SizeConfig.heightMultiplier !* 3,
                                ),
                                GestureDetector(
                                  child: Container(
                                    width: SizeConfig.screenWidth,
                                    height: SizeConfig.heightMultiplier !* 8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("Adicionar estudante"),
                                        Icon(Icons.add_circle_outline_outlined, color: iconColor)
                                      ],
                                    )
                                  ),  
                                  onTap: (){
                                    buildAddModal(context, "Inserir aluno");
                                  },
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 7,),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("MASCULINOS: _${gender[0]["m"]}_ FEMENINOS: _${gender[0]["f"]}_", style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3)),
                                )                                   
                              ]  
                            )
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

  Future<Widget>? buildDeleteModal(context, message, student){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text(message, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3), textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            primary: borderAndButtonColor,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){
                            
                          },
                        ),
                        ElevatedButton(
                          child: Text("Não"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ]
            ),
          )
        );
      }
    );
  }   

  Future<Widget>? buildAddModal(context, message){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .5,
            child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(message, style: TextStyle(color: letterColor, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.7), textAlign: TextAlign.center,),
                      IconButton(
                        icon: Icon(Icons.close, color: iconColor),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                    ]
                  ),
                  buildTextFieldRegister("Processo", TextInputType.number, _processController),
                  buildTextFieldRegister("N.º", TextInputType.number, _numberController),
                  ElevatedButton(
                    child: Text("Concluir"),
                    style: ElevatedButton.styleFrom(
                      primary: borderAndButtonColor,
                      onPrimary: Colors.white,
                      textStyle: TextStyle(color: Colors.white, fontFamily: fontFamily, fontSize: SizeConfig.textMultiplier !* 2.3),
                      minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                    ),
                    onPressed: () async{
                      if (_key.currentState!.validate()){
                        var response = await helper.get("students/${_processController.text}");
            
                        Map<String, dynamic> map = {
                          'data': response["data"],
                          'error': response["error"],
                          'status': response["status"]
                        };
                        
                      setState((){
                          student = map;
                        });
              
                        if (student["error"] == false){
                          classroomStudent = ClassroomStudentModel(
                            number: int.parse(_numberController.text),
                            studentId: int.parse(_processController.text),
                            classroomId: widget.classroomId
                          );
                          
                          var response = await helper.post("classroom_students", classroomStudent.toJson());
                          Navigator.pop(context);
                          buildModalMaterialPage(context, response["error"], message, MaterialPageRoute(builder: (context) => ShowClassroomPage(widget.classroomId, widget.coordinator)));
                        } else {
                          Navigator.pop(context);
                          buildQuestionModal(context, student["error"], "Esse estudante não existe. Deseja cadastrá-lo?");
                        }
                      }
                    },
                  ),
                ]
              ),
            ),
          )
        );
      }
    );
  }

  Future<Widget>? buildRegisterModal(BuildContext context, message){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* 3,
            height: SizeConfig.screenHeight !* 3,
            child: Form(
              key: _key2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ]
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 5,
                    ),
                    buildTextFieldRegister("Processo", TextInputType.number, _processController),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 4,
                    ),
                    buildTextFieldRegister("Nome completo", TextInputType.text, _fullNameController),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 4,
                    ),
                    buildTextFieldRegister("Bilhete de identidade", TextInputType.text, _numeroBIController),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 4,
                    ),
                    DateTimeField(
                      decoration: InputDecoration(
                        labelText: "Data de Nascimento",
                        suffixIcon: Icon(Icons.event_note, color: Colors.white),
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                      controller: _birthdate,
                      format: DateFormat("yyyy-MM-dd"),
                      style:  TextStyle(color: Colors.white),
                      onShowPicker: (BuildContext context, currentValue) {
                        return showDatePicker(
                          context: context,
                          locale: const Locale("pt"),
                          firstDate: DateTime(1900),
                          initialDate: DateTime.now(),
                          lastDate: DateTime.now(),
                        ).then((date){
                          setState((){
                            _birthdate.text = date.toString();
                          });
                        });
                      },
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 4,
                    ),
                    DropdownButtonFormField(
                      hint: Text("Sexo"),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Color(0xFF202733),
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                      dropdownColor: Colors.black,
                      items: [
                        DropdownMenuItem(child: Text("Masculino"), value: "M",),
                        DropdownMenuItem(child: Text("Feminino"), value: "F",),
                      ],
                      value: _genderValue,
                      onChanged: (newValue){
                        _genderValue= newValue.toString();
                      },
                      validator: (value) => value == null ? 'Preencha o campo Sexo' : null,
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier !* 5,
                    ),
                    ElevatedButton(
                      child: Text("Concluir"),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(0, 209, 255, 0.49),
                        onPrimary: Colors.white,
                        textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                        minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                      ),
                      onPressed: () async{
                        
                        studentAccount = Student(
                          bi: _numeroBIController.text,
                          birthdate: _birthdate.text,
                          fullName: _fullNameController.text,
                          gender: _genderValue.toString(),
                          process: int.parse(_processController.text),
                        );
                          
                        var response = await helper.post("students", studentAccount.toJson());
                        Navigator.pop(context);
                        buildModalMaterialPage(context, response["error"], response["message"], MaterialPageRoute(builder: (context) => AddDeleteStudent(widget.classroomId, widget.coordinator)));
                      },
                    ),
                  ]
                ),
              ),
            ),
          )
        );
      }
    );
  }

  Future<Widget>? buildQuestionModal(context, error, message){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            padding: EdgeInsets.all(20.0),
            width: SizeConfig.screenWidth !* .8,
            height: SizeConfig.screenHeight !* .4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                error ? Icon(Icons.error_outline, size: 70.0, color: Colors.red) : Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text(message, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ButtonBar(
                      children: [
                        ElevatedButton(
                          child: Text("Sim"),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromRGBO(0, 209, 255, 0.49),
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                            buildRegisterModal(context, "Cadastrar Aluno");
                          },
                        ),
                        ElevatedButton(
                          child: Text("Não"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                            minimumSize: Size(SizeConfig.widthMultiplier !* 32, SizeConfig.heightMultiplier !* 6.5)
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ]
            ),
          )
        );
      }
    );
  } 
}
