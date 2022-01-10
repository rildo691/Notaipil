import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentModel.dart';
import 'package:notaipilmobile/register/model/studentAccountModel.dart';
import 'package:notaipilmobile/register/model/classroomStudentModel.dart';
import 'package:notaipilmobile/register/model/student.dart';
import 'package:notaipilmobile/register/model/typeAccountModel.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class FourthPage extends StatefulWidget {

  StudentModel? student;

  FourthPage({this.student});

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailAluno = TextEditingController();
  TextEditingController _emailEncarregado = TextEditingController();
  TextEditingController _telefoneEncarregado = TextEditingController();

  late StudentModel? newStudent;
  late Student student;
  late StudentAccountModel studentAccount;  
  late ClassroomStudentModel classroomStudent;

  ApiService helper = ApiService();

  String? id;

  bool _isValid = false;

  var model;

  Future registerUser(classroomBody, studentAccountBody) async{
    var classroomStudentResponse = await helper.postWithoutToken("classroom_students", classroomBody);
    var studentAccountResponse = await helper.postWithoutToken("student_accounts", studentAccountBody);
    buildModal(context, studentAccountResponse["error"], studentAccountResponse["message"], route: !studentAccountResponse["error"] ? '/' : null);
  }

  Future getTypeAccounts() async{
    var response = await helper.get("type_accounts");
    for(var r in response){
      if (TypeAccountModel.fromJson(r).name == "Aluno"){
        setState(() {
          id = TypeAccountModel.fromJson(r).id.toString();
        });
      }
    }
  }

  @override
  void initState(){
    super.initState();

    getTypeAccounts();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;

      if (newStudent?.emailAluno != null && newStudent?.emailEncarregado!= null && newStudent?.telefoneEncarregado != null){
        setState((){
          _emailAluno.text = newStudent!.emailAluno.toString();
          _emailEncarregado.text = newStudent!.emailEncarregado.toString();
          _telefoneEncarregado.text = newStudent!.telefoneEncarregado.toString();
        });
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
              body: SingleChildScrollView(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(30.0, 35.0, 30.0, 25.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: Color.fromARGB(255, 34, 42, 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHeaderPartOne(),
                          buildHeaderPartTwo("Cadastrar Aluno"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildMiddleNavigator(context, false, '/first', false),
                              buildMiddleNavigator(context, false, '/second', false),
                              buildMiddleNavigator(context, false, '/third', false),
                              buildMiddleNavigator(context, true, '/fourth', false),
                            ]
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTextFieldRegister("E-mail", TextInputType.emailAddress, _emailAluno),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                buildTextFieldRegister("E-mail do Encarregado", TextInputType.emailAddress, _emailEncarregado),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                buildTextFieldRegister("Telefone do Encarregado", TextInputType.number, _telefoneEncarregado),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                Container(
                                  padding: EdgeInsets.only(top: SizeConfig.heightMultiplier !* 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: Color.fromRGBO(0, 209, 255, 0.49),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newStudent?.copyWith(emailAluno: _emailAluno.text, emailEncarregado: _emailEncarregado.text, telefoneEncarregado: _telefoneEncarregado.text);
                                          Navigator.pushNamed(context, '/third', arguments: model);
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: Color.fromRGBO(0, 209, 255, 0.49),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Finalizar", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            model = newStudent?.copyWith(emailAluno: _emailAluno.text, emailEncarregado: _emailEncarregado.text, telefoneEncarregado: _telefoneEncarregado.text);
                                          });
                                          
                                          classroomStudent = ClassroomStudentModel(
                                            studentId: model!.numeroProcesso,
                                            classroomId: model.turma
                                          );
                                            studentAccount = StudentAccountModel(
                                            bilhete: model.numeroBI, 
                                            email: model.emailAluno, 
                                            emailEducator: model.emailEncarregado,
                                            telephoneEducator: model.telefoneEncarregado,
                                            process: model.numeroProcesso,
                                            classroomId: model.turma,
                                          );       
                                            if (_telefoneEncarregado.text.length > 9 || _telefoneEncarregado.text.length < 9){
                                            Fluttertoast.showToast(
                                              msg: "Número de telefone deve possuir 9 dígitos.",
                                              toastLength: Toast.LENGTH_LONG,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              gravity: ToastGravity.BOTTOM,
                                            ).toString();
                                          } else {
                                            _isValid = true;
                                          }
                                            if (_formKey.currentState!.validate() && _isValid){
                                            registerUser(classroomStudent.toJson(), studentAccount.toJson()); 
                                          }
                                        },
                                      )
                                    ],  
                                  ),
                                )
                              ]
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: Text("Já possui uma conta?", style: TextStyle(color: Color(0xFF00D1FF), fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).pushNamed('/');
                              }
                            )
                          )
                        ],
                      ),
                    )
                  ]
                )
              )
            );
          }
        );
      },
    );
  }
}