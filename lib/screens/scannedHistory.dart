import 'package:flutter/material.dart';
import 'package:mateen/models/httpService.dart';
import 'package:mateen/models/shipments.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:mateen/widgets/scannedItem.dart';


class ScannedHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: HttpFetchShipmentService().getShipments(),
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
              onPressed: (){Navigator.pop(context);},
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