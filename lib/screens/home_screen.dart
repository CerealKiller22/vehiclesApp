import 'package:flutter/material.dart';
import 'package:vehicles_app/models/token.dart';
import 'package:vehicles_app/screens/login_screen.dart';
import 'package:vehicles_app/screens/procedures_screen.dart';

class HomeScreen extends StatefulWidget {
final Token token;

HomeScreen({required this.token});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicles"),
      ),
      body: _getBody(),
      drawer: widget.token.user.userType == 0 
      ? _getMechanicMenu() 
      : _getCustomerMenu(),
    );
  }

  Widget _getBody() {
    return Container(      
      margin: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(150),
            child: FadeInImage(
            placeholder: const AssetImage("assets/vehicles_logo.png"), 
            image: NetworkImage(widget.token.user.imageFullPath),
            height: 300,
            fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 30,),
          Center(
            child: Text(
              'Bienvenid@ ${widget.token.user.fullName}',
              style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
              ),
            ),
          )
        ],
      ),
    );
  }

 Widget _getMechanicMenu() {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       // ignore: prefer_const_literals_to_create_immutables
       children: <Widget>[
         const DrawerHeader(child: Image(
           image: AssetImage("assets/vehicles_logo.png"),
          )
         ),
         ListTile(
           leading: Icon(Icons.two_wheeler),
           title: Text("Marcas"),
           onTap: () {},
         ),
         ListTile(
            leading: Icon(Icons.precision_manufacturing),
            title: const Text('Procedimientos'),
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute( 
                  builder: (context) => ProceduresScreen(token: widget.token,)
                )
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.badge),
            title: const Text('Tipos de Documento'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.toys),
            title: const Text('Tipos de Veh??culos'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.people),
            title: const Text('Usuarios'),
            onTap: () {},
          ),
          const Divider(
            color: Colors.black, 
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: const Text('Editar Perfil'),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Cerrar Sesi??n'),
            onTap: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute( 
                  builder: (context) => LoginScreen()
                )
              );
            },
          ),
       ],
     ),
   );
 }

 Widget _getCustomerMenu() {
   return Drawer(
     child: ListView(
       padding: EdgeInsets.zero,
       // ignore: prefer_const_literals_to_create_immutables
       children: <Widget>[
         const DrawerHeader(child: Image(
           image: AssetImage("assets/vehicles_logo.png"),
          )
         ),
         ListTile(
           leading: Icon(Icons.two_wheeler),
           title: Text("Mis vehiculos"),
           onTap: () {},
         ),
          const Divider(
            color: Colors.black, 
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.face),
            title: const Text('Editar Perfil'),
            onTap: () { },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Cerrar Sesi??n'),
            onTap: () {
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute( 
                  builder: (context) => LoginScreen()
                )
              );
            },
          ),
       ],
     ),
   );
 }
}