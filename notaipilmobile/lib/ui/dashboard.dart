import 'package:flutter/material.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {

  const Dashboard({ Key? key }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {

  var token;

  Future verifyUser() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState((){
      token = preferences.getString('token');
    });
    token == null ? Navigator.pushNamed(context, '/') : Navigator.pushNamed(context, '/dashboard');
  }

  Future _logOut() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    Navigator.pushNamed(context, '/');
  }

  @override
  void initState(){
    super.initState();
    //verifyUser();
  }

   @override
   Widget build(BuildContext context) {
    return Container(child: Center(child: TextButton(child: Text("Remove credentials"), onPressed: _logOut,)),);
  }
}