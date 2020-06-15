import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPegawai extends StatefulWidget {
  @override
  _AddPegawaiState createState() => _AddPegawaiState();
}

class _AddPegawaiState extends State<AddPegawai> {

  TextEditingController _namaController;
  TextEditingController _posisiController;
  TextEditingController _gajiController;

  @override
  void initState() {
    _namaController = TextEditingController();
    _posisiController = TextEditingController();
    _gajiController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Pegawai"),
      ),

      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: "Nama",
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _posisiController,
                decoration: InputDecoration(
                  hintText: "Posisi",
                  labelText: "Posisi",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 8,),
              TextFormField(
                controller: _gajiController,
                decoration: InputDecoration(
                  hintText: "Gaji",
                  labelText: "Gaji",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              MaterialButton(
                child: Text("Simpan"),
                color: Colors.green,
                onPressed: () {
                  savePegawai();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> savePegawai() async {
    final response = await http.post("http://192.168.10.17/server_pegawai/addPegawai.php", body: {
      "namaPegawai": _namaController.text,
      "posisiPegawai": _posisiController.text,
      "gajiPegawai": _gajiController.text,
    });
    var resJson = jsonDecode(response.body);

    if (resJson['is_success'] == true) {
      Navigator.pop(context);
    }
  }
}
