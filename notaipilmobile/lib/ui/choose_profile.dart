import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Dashboards */
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart' as coordinator;

class Chooseprofile extends StatefulWidget {

  late var _typeAccounts = [];
  late var response;

  Chooseprofile(this._typeAccounts, this.response);

  @override
  _ChooseprofileState createState() => _ChooseprofileState();
}

class _ChooseprofileState extends State<Chooseprofile> {

  var accountTypes = [];
  int _selectedIndex = 0;

  @override 
  void initState(){
    super.initState();

    for (int i = 0; i < widget._typeAccounts.length; i++){
      setState((){
        accountTypes.add(widget._typeAccounts[i]["name"]);
      });
    }
  }

  int _getQuantity(){
    return widget._typeAccounts.length;
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
                      padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 35.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: Color.fromARGB(255, 34, 42, 55),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHeaderPartOne(),
                          buildHeaderPartTwo("Escolha o seu perfil"),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            children: widget._typeAccounts.map<Widget>((data){
                              return GestureDetector(
                                child: Card(
                                  color: Color(0xFF222A37),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                            height: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                                          ),
                                          SizedBox(height: SizeConfig.heightMultiplier !* 2.3),
                                          Text(data["name"], style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                                        ],
                                      ),
                                    )
                                  )
                                ),
                                onTap: (){
                                  if (data["name"] == "Aluno"){
                                    //Navigator.pushNamed(context, '/studentDashboard');
                                  } 
                                  else if (data["name"] == "Professor"){

                                  } else if (data["name"] == "Encarregado") {

                                  } else if (data["name"] == "Director"){
                                    var userEmail = widget.response["user"]["email"];

                                    getPrincipal(userEmail).then((value) {
                                      Map<String, dynamic> map = {
                                        'token': widget.response["token"]
                                      };
                                      value.add(map);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => MainPage(value)),
                                        (Route<dynamic> route) => false);
                                    });
                                  } else if (data["name"] == "Coordenador"){
                                    var userEmail = widget.response["user"]["email"];
                                    var area;

                                    getCoordinatorAndArea(userEmail).then((value) {
                                      Map<String, dynamic> map = {
                                        'token': widget.response["token"]
                                      };
                                      value.add(map); 
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => coordinator.MainPage(value)), (route) => false);
                                    });
                                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage(principal)));
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier !* 1.7,),
                          Container(
                            child: Icon(Icons.power_settings_new_sharp, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1)
                          ),
                        ],  
                      ),
                    )
                  ]
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
                },
              )
            );
          }
        );
      },
    );
  }

  Widget _buildCard(String text){
    return GestureDetector(
      child: Card(
        color: Color(0xFF222A37),
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                  height: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 3 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                ),
                SizedBox(height: SizeConfig.heightMultiplier !* 2.3),
                Text(text, style: TextStyle(color: Color(0xFF00D1FF), fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
              ],
            ),
          )
        )
      ),
    );
  }
}