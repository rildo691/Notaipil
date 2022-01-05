import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Model */
import 'package:notaipilmobile/register/model/teacherModel.dart';

/**User Interface */
import 'package:fluttertoast/fluttertoast.dart';

class FirstPage extends StatefulWidget {

  const FirstPage({ Key? key }) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  TeacherModel? newTeacher;
  
  final _formKey = GlobalKey<FormState>();
  bool _isValid = false;
  bool _isBi = false;

  TextEditingController _numeroBilhete = TextEditingController();
  TextEditingController _telefone = TextEditingController();

  @override
  void initState(){
    super.initState();

    setState((){
      
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        newTeacher = ModalRoute.of(context)?.settings.arguments as TeacherModel;

          if (newTeacher?.numeroBI != null && newTeacher?.telefone != null){
            _numeroBilhete.text = newTeacher!.numeroBI.toString();
            _telefone.text = newTeacher!.telefone.toString();
            
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
                              buildMiddleNavigator(context, true, '/two', true),
                              buildMiddleNavigator(context, false, '/three', true),
                              buildMiddleNavigator(context, false, '/four', true),
                              buildMiddleNavigator(context, false, '/fifth', true),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                buildTextFieldRegister("Nº do Bilhete de Identidade", TextInputType.text, _numeroBilhete),
                                SizedBox(height: SizeConfig.heightMultiplier !* 5,),
                                buildTextFieldRegister("Telefone", TextInputType.number, _telefone),
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
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Icon(Icons.arrow_back_ios, color: Colors.white, size: 18.0,),
                                              SizedBox(width: 8.0),
                                              Text("Anterior", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          var model = newTeacher?.copyWith(numeroBI: _numeroBilhete.text, telefone: _telefone.text);
                                          Navigator.pushNamed(context, '/one', arguments: model);
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
                                              Text("Próximo", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4,)),
                                              SizedBox(width: 8.0),
                                              Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18.0,),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                            if (_telefone.text.length > 9 || _telefone.text.length < 9){
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
                                            var model = newTeacher?.copyWith(numeroBI: _numeroBilhete.text, telefone: _telefone.text);
                                            Navigator.pushNamed(context, '/three', arguments: model);
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
                ),
              )
            );
          }
        );
      },
    );
  }

  void onPhoneNumberChange(String phoneNumber, String internationalizedPhoneNumber, String isoCode) {
    setState((){
      _telefone.text = internationalizedPhoneNumber;
    });
  }
}