class Shipments {
  bool status;
  List<Data> data;

  Shipments({this.status, this.data});

  Shipments.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String shipmentReference;
  String cODAmount;
  String deliveryCity;
  String deliveryArea;
  String barcode;

  Data(
      {this.shipmentReference,
      this.cODAmount,
      this.deliveryCity,
      this.deliveryArea,
      this.barcode});

  Data.fromJson(Map<String, dynamic> json) {
    shipmentReference = json['Shipment Reference'];
    cODAmount = json['COD Amount'];
    deliveryCity = json['Delivery City'];
    deliveryArea = json['Delivery Area'];
    barcode = json['Barcode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Shipment Reference'] = this.shipmentReference;
    data['COD Amount'] = this.cODAmount;
    data['Delivery City'] = this.deliveryCity;
    data['Delivery Area'] = this.deliveryArea;
    data['Barcode'] = this.barcode;
    return data;
  }
}
