import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mateen/models/shipments.dart';
import 'package:mateen/predef/routeGenerator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  new Directory(appDocDirectory.path + '/' + 'dir')
      .create(recursive: true)
      .then((Directory directory) async {
    var path = await directory.path;
    Hive.init(path);
    // ignore: unnecessary_statements
    Hive.isAdapterRegistered(1)
        ? print("ADAPTER IS NOT REGISTERED")
        : Hive.registerAdapter(DataAdapter());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}