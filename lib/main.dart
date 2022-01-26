import 'package:flutter/material.dart';
import 'package:jetrik_options_test/menu_group_model.dart';
import 'package:dio/dio.dart' as dio;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFetching = true;
  List<MenuGroupModel> options = [];
  Future getMenuOptions() async {
    try {
      var response = await dio.Dio().get(
        'https://jetrikapi.azurewebsites.net/api/menuoptions',
        queryParameters: {
          "customerId": "26800",
        },
      );
      var data = response.data;

      if (response.statusCode == 200) {
        setState(() {
          options = List.generate(
              data.length, (index) => MenuGroupModel.fromJson(data[index]));
        });
      }
    } catch (e) {
      print("Error: " + e.toString());
    }
  }

  @override
  void initState() {
    getMenuOptions().whenComplete(() {
      setState(() {
        isFetching = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Options"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: isFetching
            ? Center(
                child: CircularProgressIndicator(),
              )
            : options.isEmpty
                ? Center(
                    child: Text("Empty Data"),
                  )
                : ListView.builder(
                    itemCount: options.length,
                    itemBuilder: (context, index) {
                      var item = options[index];
                      return ExpansionTile(
                        collapsedBackgroundColor: Colors.white,
                        backgroundColor: Colors.grey.shade200,
                        title: Text(item.optionGroupName),
                        controlAffinity: ListTileControlAffinity.trailing,
                        children: List.generate(item.option.length, (index) {
                          var option = item.option[index];
                          return ListTile(
                            title: Text(option.optionName),
                          );
                        }),
                      );
                    },
                  ),
      ),
    );
  }
}
