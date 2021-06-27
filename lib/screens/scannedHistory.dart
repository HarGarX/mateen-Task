import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mateen/models/httpService.dart';
import 'package:mateen/models/shipments.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:mateen/predef/secret.dart';
import 'package:mateen/screens/loginScreen.dart';
import 'package:mateen/widgets/scannedItem.dart';

import 'package:cron/cron.dart';



// Changed ScannedHistory From stless Widget to stful Widget to handel 12 hrs shift logut & update autCode & Driver Code
class ScannedHistory extends StatefulWidget {
  const ScannedHistory({Key key}) : super(key: key);

  @override
  _ScannedHistoryState createState() => _ScannedHistoryState();
}



class _ScannedHistoryState extends State<ScannedHistory> {

  Timer timer; //set timer

  @override
  void initState() {
    super.initState();
    //when excute state init count the time to fire logout
    // timer = Timer.periodic(Duration(seconds: 5), (Timer t) => logOut());
    var cron = new Cron();
    cron.schedule(new Schedule.parse('0 */12 * * *'),() async {
      print('every 12 hr');
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen()
          ),
          ModalRoute.withName("/")
      );
    } );


  }

  void logOut() async {
    print('every three minutes');
     Navigator.pushAndRemoveUntil(
         context,
         MaterialPageRoute(
             builder: (context) => LoginScreen()
         ),
         ModalRoute.withName("/")
     );
  }

  @override
  void dispose() {
    timer?.cancel();
    print("STATE ENDED");
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: HttpFetchShipmentService().getShipments(1), //
          builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot){
            return (!snapshot.hasData) ?
              Center(child: Column(
                children: [
                  Text('Fetching data...'),
                  CircularProgressIndicator(),
                ],
              ),) :
              ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index)=>
                  ScannedItem(
                    deliveryArea: snapshot.data[index].deliveryArea,
                    deliveryCity: snapshot.data[index].deliveryCity,
                    shipmentReference: snapshot.data[index].shipmentReference,
                    cODAmount: snapshot.data[index].cODAmount,
                    barcode: snapshot.data[index].barcode,
                  ),
              );
          },

        )
        // ListView(
        //   children: [
        //     ScannedItem(),
        //     ScannedItem(),
        //   ]
        // )
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
        onPressed: (){
        },
        backgroundColor: ColorPalette().secondaryColor,
        child: PopupMenuButton(
          offset: Offset.fromDirection(1,1),
          itemBuilder: (context)=>[
            PopupMenuItem(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/barCodeScanPage');
                },
                child: Row(
                  children:[
                    Icon(Icons.scanner_outlined, color: ColorPalette().defaultColor,),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('Bar Code',
                      style: TextStyle(
                        color: ColorPalette().defaultColor,
                      ),),
                    )
                  ]
                ),
              ),
            ),
            PopupMenuItem(
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: (){
                  Navigator.of(context).pushNamed('/scanPage');
                },
                child: Row(
                  children:[
                    Icon(Icons.scanner_outlined, color: ColorPalette().defaultColor,),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text('Qr Code',
                      style: TextStyle(
                        color: ColorPalette().defaultColor,
                      ),),
                    )
                  ]
                ),
              ),
            )
          ],
          child: Icon(Icons.qr_code),
        ),
      ),

      bottomNavigationBar: Container(
        color: ColorPalette().defaultColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            IconButton(
              iconSize: 24.0,
              icon: Icon(Icons.cached),
              color: Colors.white,
              onPressed: (){
                HttpFetchShipmentService().getShipments(0).then((value) { // // GAFAR: AUTO REFRESH FOR THE SCANNED HISTORY PAGE FROM THE DATA BASE
                  Navigator.pushReplacement( //
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => super.widget)); //
                });

              },
            ),
            IconButton(
              iconSize: 24.0,
              icon: Icon(Icons.logout),
              color: Colors.white,
              onPressed: (){
                showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context){
      return AlertDialog(
        title: Text('Logout'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children:[
            Text('Are you sure you want to logout from this app?'),
          ]
        ),
        actions: [
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                color: ColorPalette().defaultColor,
              ),
            ),
            onPressed: (){
              //go back to the login page and clear the navigator stack
              // GAFAR : LOG OUT APPLIED DELETE THE AUTHCODE & DRIVER CODE //
              Secret.driverCode = '';
              Secret.authCode = '' ;
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(
                color: ColorPalette().defaultColor,
              ),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
      );
    });
              },
            )
          ]
        ),
      )
    );
  }


}


// class ScannedHistory extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: FutureBuilder(
//           future: HttpFetchShipmentService().getShipments(),
//           builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot){
//             return (!snapshot.hasData) ?
//               Center(child: Column(
//                 children: [
//                   Text('Fetching data...'),
//                   CircularProgressIndicator(),
//                 ],
//               ),) :
//               ListView.builder(
//                 itemCount: snapshot.data.length,
//                 itemBuilder: (BuildContext context, int index)=>
//                   ScannedItem(
//                     deliveryArea: snapshot.data[index].deliveryArea,
//                     deliveryCity: snapshot.data[index].deliveryCity,
//                     shipmentReference: snapshot.data[index].shipmentReference,
//                     cODAmount: snapshot.data[index].cODAmount,
//                     barcode: snapshot.data[index].barcode,
//                   ),
//               );
//           },
//
//         )
//         // ListView(
//         //   children: [
//         //     ScannedItem(),
//         //     ScannedItem(),
//         //   ]
//         // )
//       ),
//
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//
//       floatingActionButton: FloatingActionButton(
//         onPressed: (){
//         },
//         backgroundColor: ColorPalette().secondaryColor,
//         child: PopupMenuButton(
//           offset: Offset.fromDirection(1,1),
//           itemBuilder: (context)=>[
//             PopupMenuItem(
//               // ignore: deprecated_member_use
//               child: FlatButton(
//                 onPressed: (){
//                   Navigator.of(context).pushNamed('/barCodeScanPage');
//                 },
//                 child: Row(
//                   children:[
//                     Icon(Icons.scanner_outlined, color: ColorPalette().defaultColor,),
//                     Padding(
//                       padding: const EdgeInsets.only(left:8.0),
//                       child: Text('Bar Code',
//                       style: TextStyle(
//                         color: ColorPalette().defaultColor,
//                       ),),
//                     )
//                   ]
//                 ),
//               ),
//             ),
//             PopupMenuItem(
//               // ignore: deprecated_member_use
//               child: FlatButton(
//                 onPressed: (){
//                   Navigator.of(context).pushNamed('/scanPage');
//                 },
//                 child: Row(
//                   children:[
//                     Icon(Icons.scanner_outlined, color: ColorPalette().defaultColor,),
//                     Padding(
//                       padding: const EdgeInsets.only(left:8.0),
//                       child: Text('Qr Code',
//                       style: TextStyle(
//                         color: ColorPalette().defaultColor,
//                       ),),
//                     )
//                   ]
//                 ),
//               ),
//             )
//           ],
//           child: Icon(Icons.qr_code),
//         ),
//       ),
//
//       bottomNavigationBar: Container(
//         color: ColorPalette().defaultColor,
//         height: 60,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children:[
//             IconButton(
//               iconSize: 24.0,
//               icon: Icon(Icons.cached),
//               color: Colors.white,
//               onPressed: (){Navigator.pop(context);},
//             ),
//             IconButton(
//               iconSize: 24.0,
//               icon: Icon(Icons.logout),
//               color: Colors.white,
//               onPressed: (){
//                 showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (context){
//       return AlertDialog(
//         title: Text('Logout'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children:[
//             Text('Are you sure you want to logout from this app?'),
//           ]
//         ),
//         actions: [
//           TextButton(
//             child: Text(
//               'Logout',
//               style: TextStyle(
//                 color: ColorPalette().defaultColor,
//               ),
//             ),
//             onPressed: (){
//               //go back to the login page and clear the navigator stack
//               Navigator.of(context).pushReplacementNamed('/');
//             },
//           ),
//           TextButton(
//             child: Text(
//               'Cancel',
//               style: TextStyle(
//                 color: ColorPalette().defaultColor,
//               ),
//             ),
//             onPressed: (){
//               Navigator.pop(context);
//             },
//           )
//         ],
//       );
//     });
//               },
//             )
//           ]
//         ),
//       )
//     );
//   }
//
//
//
// }


