// import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/helper/authenticate.dart';
import 'package:testing_app/helper/helperfunctions.dart';
import 'package:testing_app/services/database.dart';
import 'package:testing_app/services/firebase_auth.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';

// import 'CustomCalendarPage.dart';
import 'ChatRoomsPage.dart';

class SignUpPage extends StatefulWidget {
  final Function toggle;
  @override
  _SignUpPageState createState() => _SignUpPageState();

  SignUpPage(this.toggle);
}

class _SignUpPageState extends State<SignUpPage> {
  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods db = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  // TextEditingController phoneController = TextEditingController();

  // TextEditingController confpasswordController = TextEditingController();

  List<String> countries = ['Bangladesh', 'India', 'Nepal', 'Bhutan'];
  String c = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),
        body: isLoading
            ? Container(
                child: Center(child: CircularProgressIndicator()),
              )
            : Container(
                padding: const EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[
                    text1('Let\'s get started!', Colors.black, FontWeight.w500,
                        30.0),
                    text1('Create an account', Colors.grey[500],
                        FontWeight.normal, 20.0),
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
                    navText(context, widget.toggle, 'Already have an account?',
                        'Sign in'),
                  ],
                )));
  }

  signUpMethod() async{
    if (formKey.currentState.validate()) {
      Map<String, String> userInfoMap = {
        "name": nameController.text,
        "email": emailController.text
      };
     HelperFunctions.saveUserNameSharedPref(nameController.text);
     HelperFunctions.saveUserEmailSharedPref(emailController.text);
      setState(() {
        isLoading = true;
      });

      authMethods
          .signUpWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((val) {
        // print("$val.uid");


        db.uploadUserInfo(userInfoMap);
        // HelperFunctions.saveUserLoggedInSharedPref(true);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
      });

    }
  }

  Widget nameField() {
    return new Container(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: TextInputType.name,
        controller: nameController,
        validator: (val) {
          return val.isEmpty || val.length < 3
              ? "Needs 4 Characters or more"
              : null;
        },
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
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        controller: emailController,
        validator: (val) {
          return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(val)
              ? null
              : "Enter valid email";
        },
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
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
        validator: (val) {
          return val.length < 6 ? "Enter Password 6+ characters" : null;
        },
        decoration: InputDecoration(
            labelText: 'Password', prefixIcon: Icon(Icons.lock)),
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
      keyboardType: TextInputType.text,
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
