import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditPegawai extends StatefulWidget {
  final data;

  EditPegawai(this.data);

  @override
  _EditPegawaiState createState() => _EditPegawaiState();
}

class _EditPegawaiState extends State<EditPegawai> {
  TextEditingController _namaController;
  TextEditingController _posisiController;
  TextEditingController _gajiController;

  @override
  void initState() {
    _namaController = TextEditingController(text: widget.data['nama']);
    _posisiController = TextEditingController(text: widget.data['posisi']);
    _gajiController = TextEditingController(text: widget.data['gaji']);
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
              ),
              TextFormField(
                controller: _posisiController,
              ),
              TextFormField(
                controller: _gajiController,
              ),
              MaterialButton(
                child: Text("Simpan"),
                color: Colors.green,
                onPressed: () {
                  editPegawai();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> editPegawai() async {
    final response = await http.post("http://192.168.10.17/server_pegawai/editPegawai.php", body: {
      "idPegawai": widget.data['id'],
      "namaPegawai": _namaController.text,
      "posisiPegawai": _posisiController.text,
      "gajiPegawai": _gajiController.text,
    });
    var resJson = jsonDecode(response.body);

    if (resJson['is_success'] == true) {
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
