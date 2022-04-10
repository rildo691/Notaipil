/*import 'package:flutter/material.dart';

/**Configurations */
import 'package:notaipilmobile/configs/size_config.dart';

/**Complements */
import 'package:notaipilmobile/dashboards/principal/principalInformations.dart';
import 'package:notaipilmobile/dashboards/principal/admission_requests.dart';
import 'package:notaipilmobile/dashboards/principal/settings.dart';
import 'package:notaipilmobile/dashboards/principal/profile.dart';


class Navbar extends StatelessWidget {

  const Navbar({ Key? key }) : super(key: key);

   @override
   Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 42, 55),
        ),
        child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Teste', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            accountEmail: Text('Teste', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            currentAccountPicture: CircleAvatar(              
              child: ClipOval(
                child: Icon(Icons.account_circle, color: Colors.white, size: SizeConfig.imageSizeMultiplier !* 2.3 * double.parse(SizeConfig.textMultiplier.toString()) * 1,),
              ),
            ),
            decoration: BoxDecoration(
              
            )
          ),
          
          ListTile(
            leading: Icon(Icons.notifications, color: Colors.white,),
            title: Text('Informações', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Principalinformations()))
            },
          ),
          ListTile(
            leading: Icon(Icons.group, color: Colors.white,),
            title: Text('Pedidos de adesão', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AdmissionRequests()))
            },
          ),
          ListTile(
            leading: Icon(Icons.account_circle, color: Colors.white,),
            title: Text('Perfil', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()))
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.white,),
            title: Text('Definições', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()))
            },
          ),
          ListTile(
            leading: Icon(Icons.power_settings_new_sharp, color: Colors.white,),
            title: Text('Sair', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.help_outline, color: Colors.white,),
            title: Text('Ajuda', style: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontSize: SizeConfig.isPortrait ? SizeConfig.textMultiplier !* 2.3 : SizeConfig.textMultiplier !* double.parse(SizeConfig.widthMultiplier.toString()) - 4)),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          )

          
              ],
            ),
          ),
      );
  }
}*/