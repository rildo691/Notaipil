import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/studentModel.dart';
import 'package:notaipilmobile/register/model/studentAccountModel.dart';
import 'package:notaipilmobile/register/model/classroomStudentModel.dart';
import 'package:notaipilmobile/register/model/student.dart';
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
  TextEditingController _telefone = TextEditingController();

  late StudentModel? newStudent;
  late Student student;
  late StudentAccountModel studentAccount;  
  late ClassroomStudentModel classroomStudent;

  ApiService helper = ApiService();

  bool _isValid = false;

  var model;

  Future registerUser(studentAccountBody) async{
    var studentAccountResponse = await helper.post("student_accounts", studentAccountBody);
    buildModal(context, studentAccountResponse["error"], studentAccountResponse["message"], route: !studentAccountResponse["error"] ? '/' : null);
  }

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      newStudent = ModalRoute.of(context)?.settings.arguments as StudentModel;

      if (newStudent?.emailAluno != null && newStudent?.emailEncarregado!= null && newStudent?.telefone != null){
        setState((){
          _emailAluno.text = newStudent!.emailAluno.toString();
          _emailEncarregado.text = newStudent!.emailEncarregado.toString();
          _telefone.text = newStudent!.telefone.toString();
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
                      color: backgroundColor,
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
                                TextFormField(
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    labelText: "Telefone",
                                    labelStyle: TextStyle(color: letterColor),
                                    filled: true,
                                    fillColor: fillColor,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: _telefone,
                                  validator: (String? value){
                                    if (value!.isEmpty){
                                      return "Preencha o campo Telefone";
                                    } 
                                    if (value.toString().length > 9 || value.toString().length < 9){
                                      return "Número de telefone deve possuir 9 dígitos";
                                    }
                                  }
                                ),
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
                                          color: borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: normalTextStyleWhiteSmall),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newStudent?.copyWith(emailAluno: _emailAluno.text, emailEncarregado: _emailEncarregado.text, telefone: _telefone.text);
                                          Navigator.pushNamed(context, '/third', arguments: model);
                                        },
                                      ),
                                      GestureDetector(
                                        child: Container(
                                          width: SizeConfig.screenWidth !* .32,
                                          height: SizeConfig.heightMultiplier !* 6,
                                          color: borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Finalizar", style: normalTextStyleWhiteSmall),
                                              SizedBox(width: 8.0),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            model = newStudent?.copyWith(emailAluno: _emailAluno.text, emailEncarregado: _emailEncarregado.text, telefone: _telefone.text);
                                          });

                                          studentAccount = StudentAccountModel(
                                            bilhete: model.numeroBI, 
                                            email: model.emailAluno, 
                                            telephone: model.telefone,
                                            process: model.numeroProcesso,
                                            classroomId: model.turma,
                                          );       
                                          if (_formKey.currentState!.validate()){
                                            registerUser(studentAccount.toJson()); 
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
                              child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: normalTextSizeForSmallText)),
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