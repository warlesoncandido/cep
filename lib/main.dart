import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';



void main() async{



  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
  ));
}


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController cep = TextEditingController();
  String cepCompleto = " ";





  Future<Map>buscadorCep()async{

    if(cep.text.length <= 7 || cep.text.length >= 9 || cep.text == null){
      setState(() {
        cepCompleto= "Digite um CEP valido";
      });


    }else{

      var request = 'https://api.postmon.com.br/v1/cep/${cep.text}';

      http.Response response = await http.get(request);

      json.decode(response.body)['logradouro'];

      setState(() {
        cepCompleto = "Logradouro : ${json.decode(response.body)['logradouro']} \n\n"
            "Bairro : ${json.decode(response.body)['bairro']}\n\n"
            "Cidade : ${json.decode(response.body)['cidade']}\n\n"
            "Estado : ${json.decode(response.body)['estado']}\n\n"
            "CEP Pesquisado : ${cep.text}";
      });
    }



     print(cep.text.length);
  }
  void _resetFields(){

      cep.clear();
    setState(() {
      cepCompleto = "";
    });



  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:Text("Buscador de CEP",
        style:
          TextStyle(
            fontSize: 25.0,color: Colors.white

          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],


      ),

      body:SingleChildScrollView(
        child: Padding(
            padding:EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Column(
              children: <Widget>[
                TextField(

                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0),
                  decoration:InputDecoration(

                      labelText: "Digite seu CEP",

                  ) ,
                  controller: cep,
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                  child: Container(
                    height: 50.0,
                    width:340.0 ,

                    child: RaisedButton(
                        color: Colors.blue,

                        child: Text("Buscar",
                          style: TextStyle(fontSize: 20.0,
                              color: Colors.white),
                        )
                        ,onPressed: buscadorCep,
                        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                    ),
                  ),
                ),
                Text(cepCompleto,
                    style: TextStyle(color: Colors.blueGrey,
                      fontSize: 25.0,

                    ),
                    textAlign: TextAlign.left
                ),
              ],
            ),
        ),
      )
    );
  }
}
