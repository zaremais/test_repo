import 'package:api_dio_register/models/dog_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String image = "";
  Dio dio = Dio();

  Future<void> getData() async {
    Response response =
        await dio.get("https://dog.ceo/api/breeds/image/random");
    DogsModel model = DogsModel.fromJson(response.data);
    image = model.message ?? "";
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            image,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          Center(
              child: ElevatedButton(
                  onPressed: getData, child: const Text("Get Data")))
        ],
      ),
    );
  }
}
