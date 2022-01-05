import 'package:flutter/material.dart';

/**Functions */
import 'package:notaipilmobile/parts/register.dart';
import 'package:notaipilmobile/parts/header.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

class Chooseprofile extends StatefulWidget {

  late var _typeAccounts = [];

  Chooseprofile(this._typeAccounts);

  @override
  _ChooseprofileState createState() => _ChooseprofileState();
}

class _ChooseprofileState extends State<Chooseprofile> {

  var accountTypes = [];

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
                                    Navigator.pushNamed(context, '/studentDashboard');
                                  } else if (data["name"] == "Professor"){
                                    } else if (data["name"] == "Encarregado") {
                                    } else if (data["name"] == "Director"){
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