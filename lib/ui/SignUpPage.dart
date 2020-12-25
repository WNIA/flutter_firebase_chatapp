import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';
import 'CustomCalendarPage.dart';
import 'LoginPage.dart';

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

  // TextEditingController phoneController = TextEditingController();
  // TextEditingController confpasswordController = TextEditingController();

  // bool isValid = false;

  List<String> countries = ['Bangladesh', 'India', 'Nepal', 'Bhutan'];
  String c = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                text1(
                    'Let\'s get started!', Colors.black, FontWeight.w500, 30.0),
                text1('Create an account', Colors.grey[500], FontWeight.normal,
                    20.0),
                nameField(),
                emailField(),
                // pCField(countries, c),
                passwordField(),
                // confirmPassword(),
                submitButton(context, CustomCalendar(), 'Register'),
                NavText(context, LoginPage(), 'Already have an account?',
                    'Sign in'),
              ],
            )));
  }

  Widget nameField() {
    return new Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: nameController,
        decoration: InputDecoration(
            //   border: OutlineInputBorder(),
            labelText: 'User Name',
            prefixIcon: Icon(Icons.person)),
      ),
    );
  }

  Widget emailField() {
    return new Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        controller: emailController,
        decoration: InputDecoration(
            // border: OutlineInputBorder(),
            labelText: 'Email',
            prefixIcon: Icon(Icons.email)),
      ),
    );
  }

  Widget passwordField() {
    return new Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
            //border: OutlineInputBorder(),
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

/*Widget pCField(country, code) {
    return new Container(
        // padding: EdgeInsets.all(10),
        child: Column(
      children: <Widget>[
        DropDownField(
          // controller: phoneController,
          hintText: 'select a country',
          enabled: true,
          items: country,
          onValueChanged: (value) {
            code = value;
          },
        ),
        TextField(
          decoration: InputDecoration(
              //border: OutlineInputBorder(),
              labelText: 'Phone',
              prefixIcon: Icon(Icons.phone)),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    ));
  }

  Widget confirmPassword() {
    return new Container(
      padding: EdgeInsets.all(10),
      child: TextField(
        obscureText: true,
        // controller: confpasswordController,
        decoration: InputDecoration(
            //border: OutlineInputBorder(),
            labelText: 'Confirm Password',
            prefixIcon: Icon(Icons.lock)),
      ),
    );
  }*/
}
