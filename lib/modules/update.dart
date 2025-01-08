import 'dart:convert';
import 'package:crud1/modules/form.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:crud1/data/connect/api.dart';
import 'package:crud1/data/models/PetModels.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class UpdateView extends StatefulWidget {
  final PetModels pets;
  const UpdateView({super.key, required this.pets});

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  late TextEditingController namahewanC, jenisC, hargaC;

  Future<http.Response> editData() async {
    try {
      final response = await http.post(
        Uri.parse(ConnectDB.edit),
        body: {
          "id": widget.pets.id.toString(),
          "nama_hewan": namahewanC.text,
          "jenis": jenisC.text,
          "harga": hargaC.text,
        },
      );
      return response;
    } catch (e) {
      print("Terjadi kesalahan saat mengirim data: $e");
      rethrow;
    }
  }

  void _onConfirm(BuildContext context) async {
    try {
      final response = await editData();
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
      Fluttertoast.showToast(msg: "Terjadi Kesalahan: $e");
    }
  }

  @override
  void initState() {
    namahewanC = TextEditingController(text: widget.pets.namahewan);
    jenisC = TextEditingController(text: widget.pets.jenis);
    hargaC = TextEditingController(text: widget.pets.harga.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Update",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Center(
          child: FormView(
            namahewan_C: namahewanC,
            jenis_C: jenisC,
            harga_C: hargaC,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            _onConfirm(context);
          },
          child: const Text("Update"),
        ),
      ),
    );
  }
}
