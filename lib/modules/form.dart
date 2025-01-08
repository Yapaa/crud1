import 'package:flutter/material.dart';

class FormView extends StatefulWidget {
  late TextEditingController namahewan_C, jenis_C, harga_C;
  FormView(
      {super.key,
      required this.namahewan_C,
      required this.jenis_C,
      required this.harga_C});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Form(
        autovalidateMode: AutovalidateMode.always,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
                  controller: widget.namahewan_C,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Nama Hewan",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
                  controller: widget.jenis_C,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Jenis Hewan",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
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
                  controller: widget.harga_C,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: "Harga",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
