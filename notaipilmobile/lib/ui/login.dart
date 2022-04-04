import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';
import 'package:notaipilmobile/parts/register.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**User Interface */
import 'choose_profile.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart' as coordinator;
import 'package:notaipilmobile/dashboards/teacher/main_page.dart' as teacher;



class Login extends StatefulWidget {

  const Login({ Key? key }) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  ApiService helper = ApiService();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  var token;
  var user;

  Future signIn(String email, String pass) async{
    //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      'email': email.toString().trim(),
      'password': pass.toString().trim(),
    };
    String userEmail;

    var response = await helper.post("users/authenticate", body);
    
    if (!response["error"] && response["user"]["typesAccounts"].length < 2){
      //sharedPreferences.setString("$email", response['token']);
      if (response["user"]["typesAccounts"][0]["name"] == "Director"){
        userEmail = response["user"]["email"];

        getPrincipal(userEmail).then((value) {
          Map<String, dynamic> map = {
            'userId': response["user"]["id"],
            'typeAccount': response["user"]["typesAccounts"][0],
            'token': response["token"]
          };
          value.add(map);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MainPage(value)),
            (Route<dynamic> route) => false);
        });
      } else if (response["user"]["typesAccounts"][0]["name"] == "Coordenador"){
        userEmail = response["user"]["email"];

        getCoordinator(userEmail).then((value) {
          Map<String, dynamic> map = {
            'userId': response["user"]["id"],
            'typeAccount': response["user"]["typesAccounts"][0],
            'token': response["token"]
          };
          value.add(map); 
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => coordinator.MainPage(value)), (route) => false);
        });

      }else if (response["user"]["typesAccounts"][0]["name"] == "Aluno"){

      } else if (response["user"]["typesAccounts"][0]["name"] == "Professor"){
        userEmail = response["user"]["email"];

        getSingleTeacher(userEmail).then((value) {
          Map<String, dynamic> map = {
            'userId': response["user"]["id"],
            'typeAccount': response["user"]["typesAccounts"][0],
            'token': response['token']
          };
          value.add(map);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => teacher.MainPage(value)), (route) => false);
        });

      } else if (response["user"]["typesAccounts"][0]["name"] == "Educador"){

      }
    } else if (!response["error"] && response["user"]["typesAccounts"].length >= 2) {
      //sharedPreferences.setString("$email", response['token']);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Chooseprofile(response["user"]["typesAccounts"], response)),
        (Route<dynamic> route) => false);
    } else {
      buildModal(context, response["error"], "Credenciais inválidas, por favor tente novamente.");
    }
  }

  Future verifyUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      token = preferences.getString('token');
    });
    //token == null ? Navigator.pushNamed(context, '/') : Navigator.pushNamed(context, '/dashboard');
  }

  @override
  void initState(){
    super.initState();
    //verifyUser();
  }

  Future _start() async{
    await Future.delayed(Duration(seconds: 5));
  }

  @override
  Widget build(BuildContext context) {

    

    final _formKey = GlobalKey<FormState>();

    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              body: SingleChildScrollView(
                child: FutureBuilder(
                  future: _start(),
                  builder: (context, snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Container(
                          alignment: Alignment.center,
                          width: SizeConfig.screenWidth,
                          height: SizeConfig.screenHeight,
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
                          return Stack(
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
                                buildHeaderPartTwo("Login"),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      buildTextFieldRegister("E-mail", TextInputType.emailAddress, _emailController),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                      _buildPassFormField("Palavra-passe", _passwordController),
                                      SizedBox(height: SizeConfig.heightMultiplier !* 5),
                                      ElevatedButton(
                                        child: Text("Entrar"),
                                        style: ElevatedButton.styleFrom(
                                          primary:  borderAndButtonColor,
                                          onPrimary: Colors.white,
                                          textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 20.0,
                                          ),
                                          minimumSize: Size(0.0, 50.0),
                                        ),
                                        onPressed: (){
                                          if (_formKey.currentState!.validate()){
                                            signIn(_emailController.text.toString(), _passwordController.text.toString());
                                          }
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Não possui uma conta?", style: TextStyle(color: letterColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: SizeConfig.textMultiplier !* 2.7 - 2)),
                                      SizedBox(width: 10.0,),
                                      GestureDetector(
                                        child: Text("Cadastre-se", style: TextStyle(color: linKColor, fontWeight: FontWeight.w400, fontFamily: 'Roboto', fontSize: SizeConfig.textMultiplier !* 2.7 - 2)),
                                        onTap:(){
                                          Navigator.pushNamed(context, '/type');
                                        }
                                      )
                                    ],
                                  )
                                ),
                              ],
                            ),
                          )
                            ],
                          );
                        }
                    }
                  }
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPassFormField(String hint, TextEditingController controller){
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: letterColor, fontFamily: 'Roboto'),
        filled: true,
        fillColor: fillColor,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0D89B0)),
          borderRadius: BorderRadius.circular(5.0)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0D89B0))
        ),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      style: TextStyle(color: letterColor, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
      validator: (String? value){
        if (value!.isEmpty){
          return "Preecnha o campo $hint";
        }
      }
    );
  }
}