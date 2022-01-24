import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/send_information_page.dart';
import 'package:notaipilmobile/dashboards/principal/send_information_teachers.dart';

class ShowInformationEntities extends StatefulWidget {

  const ShowInformationEntities({ Key? key }) : super(key: key);

  @override
  _ShowInformationEntitiesState createState() => _ShowInformationEntitiesState();
}

class _ShowInformationEntitiesState extends State<ShowInformationEntities> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        return OrientationBuilder(
          builder: (context, orientation){
            SizeConfig().init(constraints, orientation);

            return Scaffold(
              appBar: AppBar(
                title: Text("NotaIPIL", style: TextStyle(color: Colors.white, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 3.4 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4, fontFamily: 'Roboto', fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                backgroundColor: Color.fromARGB(255, 34, 42, 55),
                elevation: 0,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: SizeConfig.imageSizeMultiplier !* 7),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: Navbar(),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /*
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Informação", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                          
                        ],
                      ),*/
                      Text("Escolha a entidade", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                      Container(
                        width: SizeConfig.screenWidth !* .7,
                        height: SizeConfig.heightMultiplier !* 7,
                        child: ElevatedButton(
                          child: Text("Coordenadores"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0D89A4),
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SendInformationPage()));
                          },
                        ),
                      ),
                      Container(
                        width: SizeConfig.screenWidth !* .7,
                        height: SizeConfig.heightMultiplier !* 7,
                        child: ElevatedButton(
                          child: Text("Professores"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0D89A4),
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SendInformationTeachers()));
                          },
                        ),
                      ),
                    ],
                  ),
                      
                )
              ),
            );
          },
        );
      },
    );
  }
}