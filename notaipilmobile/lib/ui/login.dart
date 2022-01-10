import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**User Interface */

import 'choose_profile.dart';

/**Model */
import 'package:notaipilmobile/register/model/responseModel.dart';



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

  Future signIn(String email, String pass) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      'email': email,
      'password': pass
    };
    var response = await helper.postWithoutToken("users/login", body);
    
    if (!response["error"] && response["user"]["typesAccounts"].length < 2){
      sharedPreferences.setString("token", response['token']);
      /*Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Dashboard()),
        (Route<dynamic> route) => false);*/
    } else if (!response["error"] && response["user"]["typesAccounts"].length>= 2) {
      sharedPreferences.setString("token", response['token']);
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Chooseprofile(response["user"]["typesAccounts"])),
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
    token == null ? Navigator.pushNamed(context, '/') : Navigator.pushNamed(context, '/dashboard');
  }

  @override
  void initState(){
    super.initState();
    //verifyUser();
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
                child: Stack(
                  children: [
                  Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
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
                            _buildTextFormField("E-mail", TextInputType.emailAddress, _emailController),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            _buildPassFormField("Palavra-passe", _passwordController),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            ElevatedButton(
                              child: Text("Entrar"),
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
                            Text("Não possui uma conta?", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                            SizedBox(width: 10.0,),
                            GestureDetector(
                              child: Text("Cadastre-se", style: TextStyle(color: Color(0xFF00D1FF), fontWeight: FontWeight.w200, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
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
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTextFormField(String hint, TextInputType type, TextEditingController controller){
    return TextFormField(
      keyboardType: type,
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
        filled: true,
        fillColor: Color(0xFF202733),
        border: OutlineInputBorder(),
      ),
      style: TextStyle(color: Colors.white, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
    );
  }

  Widget _buildPassFormField(String hint, TextEditingController controller){
    return TextFormField(
      decoration: InputDecoration(
        labelText: hint,
        labelStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto'),
        filled: true,
        fillColor: Color(0xFF202733),
        border: OutlineInputBorder(),
      ),
      obscureText: true,
      enableSuggestions: false,
      autocorrect: false,
      style: TextStyle(color: Colors.white, fontFamily: 'Roboto'), textAlign: TextAlign.start,
      controller: controller,
    );
  }
}