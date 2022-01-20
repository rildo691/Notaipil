import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/**Configuration */
import 'package:notaipilmobile/configs/size_config.dart';
import 'package:notaipilmobile/functions/functions.dart';

/**Functions */
import 'package:notaipilmobile/parts/header.dart';
import 'package:notaipilmobile/parts/navbar.dart';
import 'dart:math';

/**API Helper */
import 'package:notaipilmobile/services/apiService.dart';

class SelectCoordinatorPage extends StatefulWidget {

  const SelectCoordinatorPage({ Key? key }) : super(key: key);

  @override
  _SelectCoordinatorPageState createState() => _SelectCoordinatorPageState();
}

class _SelectCoordinatorPageState extends State<SelectCoordinatorPage> {

  TextEditingController _nameController = TextEditingController();
  DataTableSource _data = MyData();

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


  @override
  void initState(){
    super.initState();
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
                  padding: EdgeInsets.fromLTRB(20.0, 35.0, 20.0, 20.0),
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  color: Color.fromARGB(255, 34, 42, 55),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Selecione o destinatário", style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4),),
                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                      _buildTextFormField("Pesquise o Nome", TextInputType.text, _nameController),
                      SizedBox(height: SizeConfig.heightMultiplier !* 3),
                      PaginatedDataTable(
                        source: _data,
                        rowsPerPage: 5,
                        columnSpacing: SizeConfig.widthMultiplier !* 8,
                        showCheckboxColumn: true,
                        columns: [
                          DataColumn(
                            label: Text(""),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Coordenador"),
                            numeric: false,
                          ),
                          DataColumn(
                            label: Text("Área de Formação"),
                            numeric: false,
                          ),
                        ],
                      ),
                      SizedBox(height: SizeConfig.heightMultiplier !* 3.5),
                      Container(
                        width: SizeConfig.widthMultiplier !* 30,
                        height: SizeConfig.heightMultiplier !* 7,
                        child: ElevatedButton(
                          child: Text("Confirmar"),
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFF0D89A4),
                            onPrimary: Colors.white,
                            textStyle: TextStyle(fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.7 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)
                          ),
                          onPressed: (){},
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
}

class MyData extends DataTableSource{
  final _data = List.generate(
    200,
    (index) => {
      "id": index,
      "title": "Item $index",
      "price": Random().nextInt(10000)
    });   
    var _selected = List<bool?>.generate(200, (index) => false
  );

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => _data.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
      DataCell(Center(child: Icon(Icons.account_circle, color: Colors.white,),)),
      DataCell(Text(_data[index]["title"].toString(), style: TextStyle(color: Colors.white)),),
      DataCell(
        Align(
          alignment: Alignment.centerRight,
          child: Text(_data[index]["price"].toString(), textAlign: TextAlign.right, style: TextStyle(color: Colors.white))
        )
      ),
    ],
  );
  }  
}