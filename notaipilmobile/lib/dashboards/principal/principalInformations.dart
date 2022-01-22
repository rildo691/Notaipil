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
import 'package:notaipilmobile/dashboards/principal/show_information_entities.dart';

class Principalinformations extends StatefulWidget {

  const Principalinformations({ Key? key }) : super(key: key);

  @override
  _PrincipalinformationsState createState() => _PrincipalinformationsState();
}

class _PrincipalinformationsState extends State<Principalinformations> {

  var _fakeInformations = [
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
    {
      'mensagem': 'Data de término da minipauta',
      'prazo': '12/09/2021'
    },
  ];

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
                    padding: EdgeInsets.only(right: 20.0),
                    icon: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.5 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
                    onPressed: (){},
                  )
                ],
              ),
              drawer: Navbar(),
              body: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.fromLTRB(15.0, 50.0, 15.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Informação", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                          GestureDetector(
                            child: Container(
                              width: SizeConfig.widthMultiplier !* 35,
                              height: SizeConfig.heightMultiplier !* 6.3,
                              child: ElevatedButton(
                                child: Text("Enviar"),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF0D89A4),
                                  onPrimary: Colors.white,
                                  textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                                ),
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowInformationEntities()));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Enviadas", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4))
                              ]
                            ),
                            SizedBox(height: SizeConfig.heightMultiplier !* 5),
                            
                            SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                              itemCount: _fakeInformations.length,
                              itemBuilder: (context, index){
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  color: Color.fromARGB(255, 34, 42, 55),
                                  child: ListTile(
                                    title: Text(_fakeInformations[index]["mensagem"].toString(), style: TextStyle(color: Colors.white),),
                                    leading: Icon(Icons.info_outline, color: Colors.yellow,),
                                    trailing: Text(_fakeInformations[index]["prazo"].toString(), style: TextStyle(color: Colors.white),),
                                    onTap: (){

                                    },
                                  ),
                                );
                              },
                            ),
                            )
                          ],
                        ),
                      )
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

  Future<Widget> buildModal(context, date, title){
    showDialog(
      context: context,
      builder: (context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          backgroundColor: Color(0xFF202733),
          child: Container(
            width: SizeConfig.widthMultiplier !* .8,
            height: SizeConfig.heightMultiplier !* 5,
            child: Column(
              
            ),
          )
        );
      }
    );
    throw new Exception();
  }
}