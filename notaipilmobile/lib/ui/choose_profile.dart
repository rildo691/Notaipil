import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Variables */
import 'package:notaipilmobile/parts/variables.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Dashboards */
import 'package:notaipilmobile/dashboards/principal/main_page.dart';
import 'package:notaipilmobile/dashboards/coordinator/main_page.dart' as coordinator;
import 'package:notaipilmobile/dashboards/teacher/main_page.dart' as teacher;

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
                      padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 35.0),
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight,
                      color: backgroundColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          buildHeaderPartOne(),
                          buildHeaderPartTwo("Escolha o seu perfil"),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: widget.response["user"]["avatar"] == null ? Icon(Icons.account_circle, color: Colors.grey, size: SizeConfig.imageSizeMultiplier !* 25) : Image.network(baseImageUrl + widget.response["user"]["avatar"], fit: BoxFit.cover, width: SizeConfig.imageSizeMultiplier !* 15, height: SizeConfig.imageSizeMultiplier !* 23),
                              ),
                              SizedBox(height: SizeConfig.heightMultiplier !* 2,),
                              Text(widget.response["user"]["userName"], style: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                            ],
                          ),
                          GridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 7,
                            children: widget._typeAccounts.map<Widget>((data){
                              return GestureDetector(
                                child: Card(
                                  color: borderAndButtonColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(data["name"], style: TextStyle(color: backgroundColor, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
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
                                    var userEmail = widget.response["user"]["email"];

                                    getSingleTeacher(userEmail).then((value) {
                                      Map<String, dynamic> map = {
                                        'token': widget.response['token']
                                      };
                                      value.add(map);
                                      Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(builder: (context) => teacher.MainPage(value)), (route) => false);
                                    });

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
                                    
                                  }
                                },
                              );
                            }).toList(),
                          ),
                          SizedBox(height: SizeConfig.heightMultiplier !* 1.7,),
                          Container(
                            child: Icon(Icons.power_settings_new_sharp, color: iconColor, size: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1)
                          ),
                        ],  
                      ),
                    )
                  ]
                )
              ),
            );
          }
        );
      },
    );
  }
}