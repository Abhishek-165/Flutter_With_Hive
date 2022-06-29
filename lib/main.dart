import 'package:databaseapp/services/hive_provider.dart';
import 'package:databaseapp/utils/helper.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    HiveProvider().getDatabaseInstance().then((value) {
      if (value != null) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  _buildListView() {
    return StreamBuilder(
        stream: HiveProvider().getInstance().streamController?.stream,
        builder: ((context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.none) {
            return const Center(child: Text("Database Not Initialised"));
          } else if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data.isInitialise) {
              return SafeArea(
                child: ListView.builder(
                    itemCount: snapshot.data!.value.length,
                    itemBuilder: (context, i) {
                      var data = snapshot.data.value[i];
                      return ListTile(
                        title: Text(data[data.keys.first]['name'].toString()),
                        subtitle: Text(data[data.keys.first]['age'].toString()),
                        trailing: InkWell(
                            onTap: () {
                              HiveProvider()
                                  .getInstance()
                                  .delete(data.keys.first);
                            },
                            child: const Icon(Icons.delete)),
                      );
                    }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
          return const SizedBox();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showCustomModalSheet(context),
          child: const Icon(Icons.add),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildListView());
  }
}
