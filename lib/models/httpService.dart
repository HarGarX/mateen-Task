import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:mateen/models/login.dart';
import 'package:mateen/models/shipments.dart' as shipments;
import 'package:mateen/models/shipments.dart';
import 'package:mateen/predef/secret.dart';

import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class HttpLoginService {
  Future<LoginResponse> getAuthCode(LoginRequest request) async {
    final String logUrl = "https://www.codiraq.com/ShipmentsAPI/login.php";

    //posting
    Response response = await post(Uri.parse(logUrl),
        body: jsonEncode(
            request) // change from request.toJson()  to  jsonEncode(request)
        );

    // print("GAFAR");
    // print(jsonEncode(response.body));
    if (response.statusCode == 200 || response.statusCode == 400) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load data');
    }
  }
}

class HttpFetchShipmentService  {
  int count;
  var box ;
  final String logUrl =
      //"https://www.codiraq.com/ShipmentsAPI/DriversShipments.php?driverCode=Ehmtx123"; //comment this line and add another line to change the driver code

      "https://www.codiraq.com/ShipmentsAPI/DriversShipments.php?driverCode=${Secret.driverCode}";

  // GAFAR : CHECK THE LOCAL DATA BASE FOR THE LIST OF SHIPMET IF THERE NONE  GET LIST OF SHIPMENT FROM THE API AND INSERT THE LIST TO LOCAL DATA BASE TO BE USED AGAIN
  Future<List<shipments.Data>> getShipments(int state) async {
    List<shipments.Data> myShipments; //
    List<shipments.Data> shipmentsFromDataBase; //

    box = await Hive.openBox('ship'); //
    // var box = await Hive.openBox('ship');
    if (state == 1 ) { //
      try { //
        Response response = await get(logUrl, headers: {
          "Authorization": "${Secret.authCode}",
          "Accept": "application/json"
        }); //
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);
          myShipments = shipments.Shipments.fromJson(jsonData).data;
          print(myShipments.runtimeType); //
          await box.put('ships', myShipments); //
          print("FROM API"); //
          print(myShipments.runtimeType);//
          return myShipments;//
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        shipmentsFromDataBase = await box.get('ships'); //

        var tempvariable = shipmentsFromDataBase.where((element) =>
        element.shipmentReference == 'Test10',
            ); //
        print("MAMAMYA$tempvariable"); //
        await box.put('ships',shipmentsFromDataBase); //
        return shipmentsFromDataBase; //
      } catch (e) {
        print(e);
      }
    }
  }

  //GAFAR :  IMPLEMENT REMOVE THE SHIPMENT FROM THE DATA BASE
  Future<List<shipments.Data>> removeShipment( String shipmentReference ) async {
//
    try { //
      box = await Hive.openBox('ship'); //
    var  shipmentsFromDataBase = await box.get('ships'); //
      print("BEFORE DELETE$shipmentsFromDataBase"); //
      shipmentsFromDataBase.removeWhere((element) =>
      element.shipmentReference == 'Test10',
      );//
      await box.put('ships',shipmentsFromDataBase);
      return shipmentsFromDataBase;
    } catch (e) {
      print(e);
    }

  }

}
