import 'package:flutter/material.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complemtnts */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';

/**User Interface */
import 'package:carousel_slider/carousel_slider.dart';


class ClassroomsPage extends StatefulWidget {

  late var value = [];

  ClassroomsPage({ Key? key, @required value }) : super(key: key);

  @override
  _ClassroomsPageState createState() => _ClassroomsPageState();
}

class _ClassroomsPageState extends State<ClassroomsPage> {

  var areas = [];
  var courses = [];
  var grades = [];
  var _value = [];
  var _stringValue;

  @override
  void initState(){
    super.initState();

    getAreas().then((List<dynamic> value) =>
      setState((){
        areas = value;
      })
    );

    setState(() {
      _value = widget.value;
      _stringValue = _value[0];
    });

    getCourses(widget.value[0]).then((List<dynamic> value) => 
      setState((){
        courses = value;
      })
    );
  }

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
                  padding: EdgeInsets.fromLTRB(8.0, 50.0, 8.0, 50.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildHeaderPartTwo("Turmas"),
                      DropdownButtonFormField<String>(
                        hint: _value[1],
                        style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Color(0xFF202733),
                          ),
                        dropdownColor: Colors.black,
                        items: areas.map((e) => 
                          DropdownMenuItem<String>(
                            value: e["id"],
                            child: Text(e["name"].toString())
                          )
                        ).toList(),
                        value: _stringValue,
                        onChanged: (newValue){
                          getCourses(newValue).then((List<dynamic> value) => 
                            setState((){
                              courses = value;
                            })
                          );
                          _stringValue = newValue.toString();
                        }
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                        ],
                      )
                    ]  
                  )
                ),
              ),
            );
          },
        );
      },
    );
  }
}