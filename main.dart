import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App para consumo de api',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
  }
    class HomePage  extends StatefulWidget {
      @override
      _HomePageState createState () {
        return _HomePageState();
      }
    }

    class _HomePageState extends State<HomePage>  {
      List<dynamic> products = [];

      @override
      void initState(){
        super.initState();
        fetchposts();
      }

      Future<void> fetchposts() async{
        final response = await http.get(Uri.parse('https://app-uniara-eb91fc9ec7bf.herokuapp.com/list')
        );

        if (response.statusCode ==200){
          setState(() {
            String data = response.body;
            products = json.decode(data);
        });      
        }else {
          throw Exception('Nâo consegue chamar API');
        }
      }


      @override
      Widget build (BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Lista de produtos'),
          ),
          body: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: products.length, 
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(products[index]['description']),
              );
            }));        

      }
    }
    