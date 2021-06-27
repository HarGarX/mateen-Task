import 'package:flutter/material.dart';
import 'package:mateen/models/httpService.dart';
import 'package:mateen/models/login.dart';
import 'package:mateen/predef/colorPalette.dart';
import 'package:mateen/predef/secret.dart';
import 'package:mateen/screens/scannedHistory.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username;
  String password;
  LoginRequest request;
  bool hidePassword = true;
  bool isLoading = false;
  setLoading(bool state) => setState(() => isLoading = state);
  final nameController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    request = new LoginRequest();
    setLoading(true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mateen Driver'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 86, 0, 232),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'User Name',
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(5.0)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 86, 0, 232),
                      )),
                  suffixIcon: Icon(Icons.remove_red_eye),
                  hintText: 'John Doe',
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: passwordController,
                obscureText: hidePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.all(const Radius.circular(5.0)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color.fromARGB(255, 86, 0, 232),
                      )),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(hidePassword == true
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                  hintText: 'Password',
                ),
              ),
            ),
            SizedBox(height: 25),
            // ignore: deprecated_member_use
            RaisedButton(

              onPressed: !isLoading ? null : ()  async {

                setLoading(false);

                setState(() {
                  username = nameController.text;
                  password = passwordController.text;
                });

                request.password = password;
                request.username = username;

                HttpLoginService loginService = new HttpLoginService();

                await loginService.getAuthCode(request).then((value) {
                  print(value.status);
                  print("GAFAR");

                  if (value.LoginData != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: ColorPalette().defaultColor,
                      content: Row(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                          SizedBox(width:5.0),
                          Text('Login successfull'),
                        ],
                      ),
                    ));
                    setLoading(true);

                    Secret.authCode = value.LoginData.authCode; // GAFAR : SETTING THE AUTH CODE & DRIVE CODE TO BE USED IN ANY REQUEST AND VALIDATE IF THE USER IS LOGED IN OR NOT
                    Secret.driverCode = value.LoginData.driverCode;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ScannedHistory()));
                  }
                  else{
                    setLoading(true);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Row(
                        children: [
                          Icon(
                            Icons.warning_outlined,
                            color: Colors.white,
                          ),
                          SizedBox(width:5.0),
                          Text('Wrong User Name Or Password'),
                        ],
                      ),
                    ));
                  }
                });
              },
              color: Color.fromARGB(255, 86, 0, 232),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
