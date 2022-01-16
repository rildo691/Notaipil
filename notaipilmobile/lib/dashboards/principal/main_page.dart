import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'package:notaipilmobile/register/model/areaModel.dart';

/**Sessions */
import 'package:shared_preferences/shared_preferences.dart';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

/**Complemtnts */
import 'package:notaipilmobile/dashboards/principal/classrooms_page.dart';

class MainPage extends StatefulWidget {

  const MainPage({ Key? key }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int _selectedIndex = 0;

  var token;
  var areaCoordinator = [
    {
      'id': '00a39c42-a2ac-40e0-bd8c-27d9df132e84',
      'area': 'Construção Civil',
      'coordinator': 'Carlos Capapelo',
    },
    {
      'id': 'afc005b4-1e94-4c4d-8483-d5544543a2f0',
      'area': 'Electricidade, Electronica e Telecomunicações',
      'coordinator': 'Telma Monteiro'
    },
    {
      'id': 'a939b90d-7f77-448d-9809-262517c1858b',
      'area': 'Informática',
      'coordinator': 'Edson Viegas',
    },
    {
      'id': '3ca61a85-87c9-43f1-8894-a0bb5d90cfd7',
      'area': 'Mecânica',
      'coordinator': 'Desconhecido'
    },
    {
      'id': '38441be4-cc36-45c5-b6ab-a4d8e74b125d',
      'area': 'Química',
      'coordinator': 'Álvaro Delly'
    }
  ];
  ApiService helper = ApiService();

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

  /*Future _getAreas() async{
    var response = await helper.get("areas");

    for (var r in response){
      areas.add(AreaModel.fromJson(r).name);
    }
  }*/

  @override
  void initState(){
    super.initState();
    //verifyUser();
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
                      GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        crossAxisSpacing: 7.0,
                        mainAxisSpacing: 10.0,
                        childAspectRatio: SizeConfig.widthMultiplier !* .5 / SizeConfig.heightMultiplier !* 6,
                        children: [
                          _buildCard("Cursos", "5", Color.fromARGB(255, 0, 191, 252)),
                          _buildCard("Turmas", "5", Color.fromARGB(255, 241, 188, 109)),
                          _buildCard("Professores", "5", Color.fromARGB(255, 13, 137, 164)),
                          _buildCard("Estudantes", "5", Color.fromARGB(255, 225, 106, 128)),
                        ],
                      ),
                      DataTable(
                        dataRowColor: MaterialStateColor.resolveWith((states) => states.contains(MaterialState.selected) ? 
                          Color.fromARGB(255, 34, 42, 55) : Color.fromARGB(255, 34, 42, 55)),
                        dataTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.2 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                        showBottomBorder: true,
                        dividerThickness: 5,
                        headingTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.5 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),
                        dataRowHeight: SizeConfig.heightMultiplier !* 7.7,
                        columns: [
                          DataColumn(
                            label: Expanded(child: Text("Área de Formação", textAlign: TextAlign.center,),),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Expanded(child: Text("Responsável", textAlign: TextAlign.center,),),
                            numeric: false,
                          ),
                        ],
                        rows: areaCoordinator.map((e) =>
                          DataRow(
                            cells: [
                              DataCell(
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(e['area'].toString(), textAlign: TextAlign.left,),
                                  ),
                                showEditIcon: false,
                                placeholder: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ClassroomsPage({"id": e['id'], "area": e['area']})));
                                }
                              ),
                              DataCell(
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(e['coordinator'].toString(), textAlign: TextAlign.right,),
                                  ),
                                showEditIcon: false,
                                placeholder: false,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ClassroomsPage({"id": e['id'], "area": e['area']})));
                                }
                              )
                            ]
                          )
                        ).toList(),
                      )   
                    ]  
                  )
                ),
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
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCard(String s, String t, Color color) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: color,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              height: SizeConfig.imageSizeMultiplier !* 1.7 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 1.4 * double.parse(SizeConfig.heightMultiplier.toString()) * 1,),
            ),
            SizedBox(width: 7.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(t, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
                Text(s, style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4))
              ],
            )
          ],
        ),
      ),
    );
  }
}