import 'package:flutter/material.dart';


class ScannedItem extends StatelessWidget {

  final String shipmentReference;
  final String cODAmount;
  final String deliveryCity;
  final String deliveryArea;
  final String barcode;

  const ScannedItem({
    Key key, 
    @required this.shipmentReference, 
    @required this.cODAmount, 
    @required this.deliveryCity, 
    @required this.deliveryArea, 
    @required this.barcode}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children:[
                  Expanded(
                    flex:1,
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/package.jpg',),
                      radius: 25.0,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$barcode',
                            style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Status',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
              ),
              SizedBox(height:10.0),
              Text(
                'Customer Name: ',
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height:10.0),
              Text(
                'Address: $deliveryArea',
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height:10.0),
              Text(
                'Description:',
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height:10.0),
              Text(
                'COD Amount: $cODAmount',
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height:10.0),
            ],
          ),
        )
      ),
    );
  }
}