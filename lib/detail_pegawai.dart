import 'dart:convert';

import 'package:aplikasipegawai/edit_pegawai.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DetailPegawai extends StatelessWidget {
  final data;
  DetailPegawai(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pegawai"),
      ),

      body: Container(
        margin: EdgeInsets.all(16),
        child: ListView(
          children: <Widget>[
            Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Text("Nama : ${data['nama']}"),
                    SizedBox(height: 8,),
                    Text("Posisi : ${data['posisi']}"),
                    SizedBox(height: 8,),
                    Text("Gaji : ${data['gaji']}"),
                  ],
                ),
              ),
            ),

            Column(
              children: <Widget>[
                RaisedButton(
                  child: Text("Edit", style: TextStyle(color: Colors.white),),
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => EditPegawai(data)
                    ),);
                  },
                ),
                RaisedButton(
                  child: Text("Delete", style: TextStyle(color: Colors.white),),
                  color: Colors.red,
                  onPressed: () {
                    _showConfirmDialog(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  void _showConfirmDialog(context) {
    AlertDialog dialog = AlertDialog(
      title: Text("Hapus ${data['nama']} ?"),
      actions: <Widget>[
        FlatButton(
          child: Text("Ya"),
          onPressed: () {
            deletePegawai(context);
          },
        ),
        
        FlatButton(
          child: Text("Tidak"),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );

    showDialog(context: context, child: dialog);
  }
  
  Future<void> deletePegawai(context) async {
    final response = await http.post("http://192.168.10.17/server_pegawai/deletePegawai.php", body: {
      "idPegawai": data['id']
    });
    var resJson = jsonDecode(response.body);

    if (resJson['is_success'] == true) {
      Navigator.pop(context);
      Navigator.pop(context);
    }


  }
}
