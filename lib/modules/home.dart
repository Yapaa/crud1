import 'dart:convert';
import 'package:crud1/modules/create.dart';
import 'package:crud1/modules/detail.dart';
import 'package:http/http.dart' as http;
import 'package:crud1/data/connect/api.dart';
import 'package:crud1/data/models/PetModels.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late Future<List<PetModels>> pets;

  @override
  void initState() {
    pets = getPetList();
    super.initState();
  }

  Future<List<PetModels>> getPetList() async {
    final response = await http
        .get(Uri.parse(ConnectDB.view))
        .timeout(const Duration(seconds: 10));

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<PetModels> sw = items.map<PetModels>((json) {
      return PetModels.fromJson(json);
    }).toList();

    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.pets),
            Text(
              "Pet Shop",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: FutureBuilder<List<PetModels>>(
          future: pets,
          builder:
              (BuildContext context, AsyncSnapshot<List<PetModels>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text("No data found");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.pets),
                    title: Text(
                      data.namahewan,
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.jenis),
                      ],
                    ),
                    trailing: Text('${data.harga.toString()} IDR',
                      // data.harga.toString(),
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => DetailView(
                            pets: data,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CreateView()));
        },
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        child: Row(
          children: [
            Text(' Add'),
            Icon(Icons.add),
          ],
        ),
      ),
    );
  }
}
