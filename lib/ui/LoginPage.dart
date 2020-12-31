import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:testing_app/helper/helperfunctions.dart';
import 'package:testing_app/services/database.dart';
import 'package:testing_app/services/firebase_auth.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';
import 'CustomCalendarPage.dart';

class LoginPage extends StatefulWidget {
  final Function toggle;

  @override
  _LoginPageState createState() => _LoginPageState();

  LoginPage(this.toggle);
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods db = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  QuerySnapshot snapshotUserInfo;
  bool isLoading = false;

  @override
  void initState() {
    //for firebase notification
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        // _showItemDialog(message);
        showOverlayNotification((context) {
          //overlay support used because on message doesn't work
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: SafeArea(
              child: ListTile(
                leading: SizedBox.fromSize(
                    size: const Size(40, 40),
                    child: ClipOval(
                        child: Container(
                      color: Colors.black,
                    ))),
                title: Text(message['notification']['title']),
                subtitle: Text(message['notification']['body']),
                trailing: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      OverlaySupportEntry.of(context).dismiss();
                    }),
              ),
            ),
          );
        }, duration: Duration(milliseconds: 4000));
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // _navigateToItemDetail(message);
      },
    );
  }

  loginMethod() {
    if (formKey.currentState.validate()) {
      HelperFunctions.saveUserEmailSharedPref(emailController.text);
      setState(() {
        isLoading = true;
      });
      db.getUserByUserEmail(emailController.text).then((val) {
        snapshotUserInfo = val;
        HelperFunctions.saveUserEmailSharedPref(
            snapshotUserInfo.docs[0].data()["email"]);
        HelperFunctions.saveUserNameSharedPref(
            snapshotUserInfo.docs[0].data()["name"]);
      });
      authMethods
          .signInWithEmailAndPassword(
              emailController.text, passwordController.text)
          .then((value) {
        if (value != null) {
          HelperFunctions.saveUserLoggedInSharedPref(true);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => CustomCalendar()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: buildPadding(),
    );
  }

  Padding buildPadding() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            imageAtTop(),
            text1('Welcome!', Colors.black, FontWeight.w500, 30.0),
            text1('Log in to your existing account', Colors.grey[500],
                FontWeight.normal, 15.0),
            Form(
              key: formKey,
              child: Column(children: [mailField(), passwordField()]),
            ),
            forgotPasswordButton(),
            submitButton(context, loginMethod, 'Login'),
            text1(
                'Or connect using', Colors.grey[500], FontWeight.normal, 15.0),
            fgButton(),
            navText(
                context, widget.toggle, 'Don\'t have an account?', 'Sign Up'),
          ],
        ));
  }

  Widget imageAtTop() {
    return new Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Image(
          image: AssetImage('assets/butterfly.jpg'),
          height: 100,
          width: 100,
        ));
  }

  Widget mailField() {
    return new Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      // height: 50,
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
          labelText: 'Email Address',
          prefixIcon: Icon(Icons.account_circle_rounded),
        ),
      ),
    );
  }

  Widget passwordField() {
    return new Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      // height: 50,
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
        validator: (val) {
          return val.length < 6 ? "Needs 6+ characters" : null;
        },
        decoration: InputDecoration(
            labelText: 'Password', prefixIcon: Icon(Icons.lock)),
      ),
    );
  }

  Widget forgotPasswordButton() {
    return new FlatButton(
      onPressed: () {
        //forgot password screen
      },
      textColor: Colors.black,
      child: Text('Forgot Password?'),
    );
  }

  Widget fgButton() {
    return new Container(
      child: Row(
        children: <Widget>[
          FlatButton(
            onPressed: () {},
            textColor: Colors.white,
            color: Colors.blue[700],
            child: Text('Facebook'),
          ),
          SizedBox(width: 5),
          FlatButton(
            onPressed: () {},
            textColor: Colors.white,
            color: Colors.red,
            child: Text('Google'),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}
