import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:testing_app/widgets/text_widget.dart';
import 'package:testing_app/widgets/widget.dart';
import 'SignUpPage.dart';
import 'CustomCalendarPage.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging();

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

  loginMethod(){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomCalendar()),
    );
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
            text1('Log in to your existing account', Colors.grey[500], FontWeight.normal, 15.0),
            mailField(),
            passwordField(),
            forgotPasswordButton(),
            submitButton(context, loginMethod, 'Login'),
            text1('Or connect using', Colors.grey[500], FontWeight.normal, 15.0),
            fgButton(),
            navText(
                context, SignUpPage(), 'Don\'t have an account?', 'Sign Up'),
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
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        controller: mailController,
        decoration: InputDecoration(
          labelText: 'User Name',
          prefixIcon: Icon(Icons.account_circle_rounded),
        ),
      ),
    );
  }

  Widget passwordField() {
    return new Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      // height: 50,
      child: TextField(
        keyboardType: TextInputType.text,
        obscureText: true,
        controller: passwordController,
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
