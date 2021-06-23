import 'package:flutter/material.dart';

class ScannedItemInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
                      backgroundImage: AssetImage('assets/package.jpg'),
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
                            '054580156-gfgsd',
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
                'Address: Lorem ipsum dolor emet sit Lorem ipsum dolor emet sit',
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
                'COD Amount: ',
                style: TextStyle(
                  letterSpacing: 1.1,
                ),
              ),
              SizedBox(height:10.0),
              Text(
                'Currency: ',
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