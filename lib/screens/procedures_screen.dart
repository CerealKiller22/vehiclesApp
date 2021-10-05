import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vehicles_app/components/loader_component.dart';
import 'package:vehicles_app/helpers/constans.dart';
import 'package:vehicles_app/models/procedure.dart';
import 'package:vehicles_app/models/token.dart';
import "package:http/http.dart" as http;
import 'package:vehicles_app/screens/procedure_screen.dart';

class ProceduresScreen extends StatefulWidget {
  final Token token;

  ProceduresScreen({required this.token}); 

  @override
  _ProceduresScreenState createState() => _ProceduresScreenState();
}

class _ProceduresScreenState extends State<ProceduresScreen> {
  List<Procedure> _procedures = [];
  bool _showLoader = false;

  void initState() {
    super.initState();  //Se invoca el metodo cuando la pantalla cambia
    _getProcedures();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title:  const Text("Procedimientos"),
      ),
      body: Center(
        child: _showLoader ? LoaderComponent(text:"Por favor espere..." ,) : _getContent(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                context, 
                MaterialPageRoute( 
                  builder: (context) => ProcedureScreen(
                    token: widget.token, 
                    procedure: Procedure(id: 0, description: "", price: 0), 
                  )
                )
              );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _getProcedures() async {
    setState(() {
      _showLoader = true;
    });

    var url = Uri.parse('${Constans.apiUrl}/api/Procedures');
    var response = await http.get(
      url,
      headers: {
        'content-type' : 'application/json',
        'accept' : 'application/json',
        'authorization' : 'bearer ${widget.token.token}',
      },
    );

    setState(() {
      _showLoader = false;
    });

    var body = response.body;
    var decodeJson = jsonDecode(body);

    if(decodeJson != null){
      for (var item in decodeJson) {
        _procedures.add(Procedure.fromJson(item));
      }
    }

    print(_procedures);
  }

   Widget _getContent() {
     return _procedures.length == 0 ? _noContent() : _getListView();

  }

  Widget _noContent() {
    return Center(
      child : Container(
        margin: EdgeInsets.all(20),
        child: const Text(
          "No hay procedimientos almacenados", 
          style : TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
   }

  Widget _getListView() {
    return ListView(
      children: _procedures.map((e) {
        return Card(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context, 
                MaterialPageRoute( 
                  builder: (context) => ProcedureScreen(
                    token: widget.token, 
                    procedure: e, 
                  )
                )
              ); 
            },
          child: Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child:  Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.description, 
                      style: TextStyle(
                        fontSize: 16
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text(
                        '${NumberFormat.currency(symbol: '\$').format(e.price)}',  
                        style: TextStyle(
                          fontWeight : FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ); 
  }
}