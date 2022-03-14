import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/educatorModel.dart';
import 'package:notaipilmobile/register/model/educator.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class FourthPage extends StatefulWidget {

  const FourthPage({ Key? key }) : super(key: key);

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {

  final _formKey = GlobalKey<FormState>();

  var model;

  EducatorModel? newEducator;
  late Educator educator;

  TextEditingController _processo = TextEditingController();
  TextEditingController _numeroBiAluno = TextEditingController();

  ApiService helper = ApiService();

  @override
  void initState(){
    super.initState();
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newEducator = ModalRoute.of(context)?.settings.arguments as EducatorModel;

          if (newEducator?.numeroProcessoAluno != null && newEducator?.numeroBiAluno != null){
            setState(() {
              _numeroBiAluno.text = newEducator!.numeroBiAluno.toString();
              _processo.text = newEducator!.numeroProcessoAluno.toString();
            });
            
          }
        });
  }

  Future registerUser(educatorBody) async{
    var educatorResponse = await helper.postWithoutToken("educators", educatorBody);
    buildModal(context, educatorResponse["error"], educatorResponse["message"], route: !educatorResponse["error"] ? '/' : null);
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
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHeaderPartOne(),
                          buildHeaderPartTwo("Cadastrar Professor"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              buildMiddleNavigator(context, false, '/one', false),
                              buildMiddleNavigator(context, false, '/two', false),
                              buildMiddleNavigator(context, false, '/three', false),
                              buildMiddleNavigator(context, true, '/four', false),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTextFieldRegister("N.º de Processo do Aluno", TextInputType.number, _processo),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                buildTextFieldRegister("N.º do Bilhete de Identidade do Aluno", TextInputType.text, _numeroBiAluno),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
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
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newEducator?.copyWith(numeroBiAluno: _numeroBiAluno.text, numeroProcessoAluno: _processo.text);
                                          Navigator.pushNamed(context, '/three', arguments: model);
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
                                              Text("Finalizar", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            model = newEducator?.copyWith(numeroProcessoAluno: _processo.text, numeroBiAluno: _numeroBiAluno.text);
                                          });
                                          
                                          educator = Educator(
                                            bi: model.numeroBI,
                                            fullName: model.nome,
                                            gender: model.sexo,
                                            birthdate: model.dataNascimento,
                                            email: model.email,
                                            telephone: model.telefone,
                                            studentId: int.parse(model!.numeroProcessoAluno.toString()),
                                            studentBi: model.numeroBiAluno
                                          );

                                          if (_formKey.currentState!.validate()){
                                            registerUser(educator.toJson());
                                          }
                                        }
                                      )
                                    ],  
                                  ),
                                )
                              ]
                            ),
                          ),
                          Container(
                            child: GestureDetector(
                              child: Text("Já possui uma conta?", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                              onTap: (){
                                Navigator.of(context, rootNavigator: true).pushNamed('/');
                              }
                            )
                          )
                        ],
                      ),
                    )
                  ]
                ),
              )
            );
          }
        );
      },
    );
  }
}