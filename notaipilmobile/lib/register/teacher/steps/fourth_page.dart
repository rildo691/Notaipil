import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:intl/intl.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';
import 'package:notaipilmobile/register/model/teacherAccountModel.dart';
import 'package:notaipilmobile/register/model/responseModel.dart';

/**User Interface */
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class FourthPage extends StatefulWidget {

  const FourthPage({ Key? key }) : super(key: key);

  @override
  _FourthPageState createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {

  TeacherModel? newTeacher;
  ApiService helper = ApiService();
  TeacherAccountModel _teacherAccount = TeacherAccountModel();

  
  final _formKey = GlobalKey<FormState>();
  var model;

  DateTime? _tempoServicoIpil;
  DateTime? _tempoServicoEducacao;

  TextEditingController _tempoIpil = TextEditingController();
  TextEditingController _tempoEd = TextEditingController();

  Future registerTeacher(body) async{
    var teacherResponse = await helper.postWithoutToken("teacher_accounts", body);
    buildModal(context, teacherResponse["error"], teacherResponse["message"], route: !teacherResponse["error"] ? '/' : null);
  }

  @override
  void initState(){
    super.initState();

    setState((){
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;

          if (newTeacher?.tempoServicoIpil != null && newTeacher?.tempoServicoEducacao != null){
            _tempoIpil.text = newTeacher!.tempoServicoIpil.toString();
            _tempoEd.text = newTeacher!.tempoServicoEducacao.toString();
          } else {
            _tempoIpil.text = "";
            _tempoEd.text = "";
          }
        });
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
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(34, 42, 55, 1.0),
                            Color.fromRGBO(21, 23, 23, 1.0),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        )
                      ),
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
                              buildMiddleNavigator(context, false, '/one', true),
                              buildMiddleNavigator(context, false, '/two', true),
                              buildMiddleNavigator(context, false, '/three', true),
                              buildMiddleNavigator(context, false, '/four', true),
                              buildMiddleNavigator(context, true, '/fifth', true),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DateTimeField(
                                  decoration: InputDecoration(
                                    labelText: "Tempo de Serviço no IPIL",
                                    suffixIcon: Icon(Icons.event_note, color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  controller: _tempoIpil,
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
                                        _tempoIpil.text = date.toString();
                                        _tempoServicoIpil = date;
                                      });
                                    });
                                  },
                                ),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                DateTimeField(
                                  decoration: InputDecoration(
                                    labelText: "Tempo de Serviço na Educação",
                                    suffixIcon: Icon(Icons.event_note, color: Colors.white),
                                    labelStyle: TextStyle(color: Colors.white),
                                  ),
                                  controller: _tempoEd,
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
                                        _tempoEd.text = date.toString();
                                        _tempoServicoEducacao = date;
                                      });
                                    });
                                  },
                                ),
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
                                          color: Color.fromRGBO(0, 209, 255, 0.49),
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
                                          var model = newTeacher?.copyWith(tempoServicoIpil: _tempoServicoIpil, tempoServicoEducacao: _tempoServicoEducacao);
                                          Navigator.pushNamed(context, '/four', arguments: model);
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
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            model = newTeacher?.copyWith(tempoServicoIpil: _tempoServicoIpil, tempoServicoEducacao: _tempoServicoEducacao);
                                          });
                                            _teacherAccount = TeacherAccountModel(
                                            bi: model?.numeroBI,
                                            fullName: model?.nome,
                                            birthdate: model?.dataNascimento,
                                            gender: model?.sexo,
                                            email: model?.email,
                                            telephone: model?.telefone,
                                            qualificationId: model?.habilitacoes,
                                            regime: model?.regimeLaboral,
                                            ipilDate: model?.tempoServicoIpil,
                                            educationDate: model?.tempoServicoEducacao,
                                            category: model?.categoria
                                          );
                                            if (_formKey.currentState!.validate()){
                                            registerTeacher(_teacherAccount.toJson());
                                          } else {
                                            
                                            _buildErrorModal(model);
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
                ),
              )
            );
          }
        );
      },
    );
  }

  Future<Widget>? _buildModal(){
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
                Icon(Icons.info_outline, size: 70.0, color: Colors.amber),
                Text("Obrigado por cadastrar-se, por favor aguarde uma resposta no seu e-mail.", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 209, 255, 0.49),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    Navigator.pushNamed(context, '/');
                  },
                )
              ]
            ),
          )
        );
      }
    );
  }

  Future<Widget>? _buildErrorModal(model){
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
                Icon(Icons.error_outline, size: 70.0, color: Colors.red),
                Text("Ocorreu um erro na validação do formulário. Certifique-se que tem tudo conforme o pedido.", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4), textAlign: TextAlign.center,),
                ElevatedButton(
                  child: Text("OK"),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(0, 209, 255, 0.49),
                    onPrimary: Colors.white,
                    textStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,),
                    minimumSize: Size(SizeConfig.widthMultiplier !* 40, SizeConfig.heightMultiplier !* 6.5)
                  ),
                  onPressed: (){
                    Navigator.pop(context, model);
                  },
                )
              ]
            ),
          )
        );
      }
    );
  }
}