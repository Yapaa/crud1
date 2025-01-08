import 'dart:convert';
import 'package:crud1/data/connect/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateView extends StatefulWidget {
  const CreateView({super.key});

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  TextEditingController namahewan = TextEditingController();
  TextEditingController jenis = TextEditingController();
  TextEditingController harga = TextEditingController();

  Future<http.Response> createData() async {
    try {
      Map<String, String> fields = {
        'nama_hewan': namahewan.text,
        'jenis': jenis.text,
        'harga': harga.text,
      };

      final response = await http.post(
        Uri.parse(ConnectDB.create),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(fields),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return response;
      } else {
        throw Exception(
            "Gagal Mengisi Data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Data Error: $e");
      rethrow;
    }
  }

  void _onConfirm(BuildContext context) async {
    try {
      http.Response response = await createData();
      final data = json.decode(response.body);

      if (response.statusCode == 200 && data['Berhasil'] == true) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(data['message'] ?? 'Gagal Menyimpan Data'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Terjadi Kesalahan: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: namahewan,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Nama Hewan",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: jenis,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Jenis Hewan",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                controller: harga,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50),
                foregroundColor: Colors.white,
                backgroundColor: Colors.pink,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                _onConfirm(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        )),
      ),
    );
  }
}
