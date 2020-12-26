// import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';
// import 'CustomCalendarPage.dart';
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
  final formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  // TextEditingController confpasswordController = TextEditingController();



  List<String> countries = ['Bangladesh', 'India', 'Nepal', 'Bhutan'];
  String c = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                text1(
                    'Let\'s get started!', Colors.black, FontWeight.w500, 30.0),
                text1('Create an account', Colors.grey[500], FontWeight.normal,
                    20.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      nameField(),
                      emailField(),
                      // pCField(countries, c),
                      passwordField(),
                      // confirmPassword(),
                    ],
                  ),
                ),
                submitButton(context, signUpMethod, 'Register'),
                navText(context, LoginPage(), 'Already have an account?',
                    'Sign in'),
              ],
            )));
  }

  signUpMethod(){
    if(formKey.currentState.validate()){

    }
  }
  Widget nameField() {
    return new Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        validator: (val) {
          return "This won't work";
        },
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
      padding: const EdgeInsets.all(10),
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
      padding: const EdgeInsets.all(10),
      child: TextField(
        obscureText: true,
        controller: passwordController,
        decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

/*  Widget pCField(country, code) {
    return new Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          DropDownField(
            controller: phoneController,
            hintText: 'select a country',
            enabled: true,
            items: country,
            onValueChanged: (value) {
              code = value;
            },
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                labelText: 'Phone', prefixIcon: Icon(Icons.phone)),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
    );
  }

  Widget confirmPassword() {
    return new Container(
      padding: const EdgeInsets.all(10),
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
