import 'package:http/http.dart';
import 'dart:convert';
import 'package:mateen/models/login.dart';
import 'package:mateen/models/shipments.dart' as shipments;
import 'package:mateen/predef/secret.dart';

class HttpLoginService {
  Future<LoginResponse> getAuthCode(LoginRequest request) async {


    final String logUrl = "https://www.codiraq.com/ShipmentsAPI/login.php";

    //posting
    Response response = await post(
      Uri.parse(logUrl),
      body: jsonEncode(request)  // change from request.toJson()  to  jsonEncode(request)
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

class HttpFetchShipmentService {
  final String logUrl =
      //"https://www.codiraq.com/ShipmentsAPI/DriversShipments.php?driverCode=Ehmtx123"; comment this line and add another line to change the driver code

      "https://www.codiraq.com/ShipmentsAPI/DriversShipments.php?driverCode=${Secret.driverCode}";
  Future<List<shipments.Data>> getShipments() async {
    List<shipments.Data> myShipments;
/*

 */
    try {
      Response response = await get(logUrl, headers: {
        "Authorization": "${Secret.authCode}", // uncomment this line and comment the undernith one
        //"Authorization": "LrwiXi5D37RxHeoweCbafOtafBTUlB",
        "Accept": "application/json"
      });
        print("GAFAR GET SHIPMENT");
        print(Secret.authCode);
        print(response.body);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        myShipments = shipments.Shipments.fromJson(jsonData).data;
      }
    } catch (e) {
      print(e);
    }

    return myShipments;
  }
}
