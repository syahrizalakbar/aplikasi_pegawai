import 'dart:convert';

import 'package:aplikasipegawai/add_pegawai.dart';
import 'package:aplikasipegawai/detail_pegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplikasi Pegawai',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> getPegawai() async {
    final response = await http.get("http://172.16.0.4/server_pegawai/getPegawai.php");

    return jsonDecode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Pegawai"),
      ),

      body: FutureBuilder(
        future: getPegawai(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _showPegawai(snapshot.data['data']);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddPegawai()
          ));
        },
      ),
    );
  }

  Widget _showPegawai(List data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(data[index]['nama']),
            subtitle: Text(data[index]['posisi']),
            leading: Icon(Icons.list),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => DetailPegawai(data[index])
              ));
            }
          ),
        );
      },
    );
  }
}
