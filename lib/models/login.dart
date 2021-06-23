class LoginResponse {
  final bool status;
  final Data data;

  LoginResponse({this.status, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
    status : json['status'],
    data : json['data'] != null ? new Data.fromJson(json['data']) : null);
  }

}

class LoginRequest{
  String username;
  String password;

  LoginRequest({this.username, this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'user':username.trim(),
      'pass':password.trim()
    };
    print(data);
    return data;
  }

}

class Data {
  String driverCode;
  String authCode;

  Data({this.driverCode, this.authCode});

  Data.fromJson(Map<String, dynamic> json) {
    driverCode = json['driver_code'];
    authCode = json['auth_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driver_code'] = this.driverCode;
    data['auth_code'] = this.authCode;
    return data;
  }
}
