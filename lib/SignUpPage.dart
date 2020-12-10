import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/LoginPage.dart';


class SignUpPage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    body: SignUpScreen(),
  );
}
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController confpasswordController = TextEditingController();
  // bool isValid = false;

  List<String> countries = ['Bangladesh','India','Nepal','Bhutan'];
  String c = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                welcomeText(),
                subText1(),
                nameField(nameController),
                emailField(emailController),
                pCField(countries, phoneController, c),
                passwordField(passwordController),
                confirmPassword(confpasswordController),
                submitButton(),
                loginPage(context),
              ],
            )));
  }
}

Widget welcomeText(){
  return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 40),
      child: Text(
        'Let\'s get started!',
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 30),
      ));
}
Widget subText1(){
  return new Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(10,10,10,0),
      child: Text(
        'Create an account',
        style: TextStyle(fontSize: 20, color: Colors.grey[500]),
      ));
}
Widget nameField(nameController){
  return new Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: nameController,
      decoration: InputDecoration(
        //   border: OutlineInputBorder(),
          labelText: 'User Name',
          prefixIcon: Icon(Icons.person)
      ),
    ),
  );
}
Widget emailField(emailController){
  return new Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: emailController,
      decoration: InputDecoration(
        // border: OutlineInputBorder(),
          labelText: 'Email',
          prefixIcon: Icon(Icons.email)
      ),

    ),
  );
}
Widget pCField(country, phoneController, code){
  return new Container(
    // padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          DropDownField(
            controller: phoneController,
            hintText: 'select a country',
            enabled: true,
            items: country,
            onValueChanged: (value){
              code = value;
            },
          ),
          TextField(
            decoration: InputDecoration(
              //border: OutlineInputBorder(),
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone)
            ),
          ),

        ],
        mainAxisSize: MainAxisSize.min,
      )
  );
}
Widget passwordField(passwordController){
  return new Container(
    padding: EdgeInsets.all(10),
    child:TextField(
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        //border: OutlineInputBorder(),
          labelText: 'Password',
          prefixIcon: Icon(Icons.lock)
      ),
    ),

  );
}
Widget confirmPassword(confpasswordController){
  return new Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      obscureText: true,
      controller: confpasswordController,
      decoration: InputDecoration(
        //border: OutlineInputBorder(),
          labelText: 'Confirm Password',
          prefixIcon: Icon(Icons.lock)
      ),
    ),
  );
}
Widget submitButton(){
  return new Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: SizedBox(
          height: 50,
          width: 100,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            textColor: Colors.white,
            color: Colors.pink,
            child: Text('Login'),
            onPressed: () {
              //print(nameController.text);
              //print(passwordController.text);
            },
          )));
}
Widget loginPage(context){
  return new Container(
      child: Row(
        children: <Widget>[
          Text('Already have an account?'),
          FlatButton(
            textColor: Colors.blue,
            child: Text(
              'Sign in',
              style: TextStyle(fontSize: 20),
            ),
            onPressed: () {
              //signup screen
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ));
}