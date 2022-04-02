import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

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
  TextEditingController _photo = TextEditingController();

  File? image;

  Future registerTeacher(body) async{
    /*var teacherResponse = await helper.postWithoutToken("teacher_accounts", body);
    buildModal(context, teacherResponse["error"], teacherResponse["message"], route: !teacherResponse["error"] ? '/' : null);*/
    var request = await helper.postMultipart("teacher_accounts", body);
    buildModal(context, request["error"], request["message"], route: !request["error"] ? '/' : null);
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
                                    suffixIcon: Icon(Icons.event_note, color: iconColor),
                                    labelStyle: TextStyle(color: letterColor),
                                  ),
                                  controller: _tempoIpil,
                                  format: DateFormat("yyyy-MM-dd"),
                                  style:  TextStyle(color: letterColor),
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
                                    suffixIcon: Icon(Icons.event_note, color: iconColor),
                                    labelStyle: TextStyle(color: letterColor),
                                  ),
                                  controller: _tempoEd,
                                  format: DateFormat("yyyy-MM-dd"),
                                  style:  TextStyle(color: letterColor),
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
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  readOnly: true,
                                  style: TextStyle(color: letterColor),
                                  decoration: InputDecoration(
                                    labelText: "Carregar fotografia",
                                    labelStyle: TextStyle(color: letterColor),
                                    filled: true,
                                    fillColor: fillColor,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller:  _photo,
                                  validator: (String? value){
                                    if (value!.isEmpty){
                                      return "Carregue uma fotografia";
                                    }
                                  },
                                  onTap: (){
                                    _showOptions(context);
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
                                          color: borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: arrowIconSize,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: normalTextStyleWhiteSmall),
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
                                          color: borderAndButtonColor,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Finalizar", style: normalTextStyleWhiteSmall),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: arrowIconSize,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          setState((){
                                            model = newTeacher?.copyWith(tempoServicoIpil: _tempoServicoIpil, tempoServicoEducacao: _tempoServicoEducacao, avatar: _photo.text);
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
                                            category: model?.categoria,
                                            avatar: model?.avatar,
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

  Future<Widget>? _buildErrorModal(model){
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
/*}*/