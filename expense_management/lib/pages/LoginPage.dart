import 'package:flutter/material.dart';
import './HomePage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          padding: EdgeInsets.fromLTRB(20, 10+statusBarHeight, 20, 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () => {},
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight : FontWeight.bold
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).backgroundColor,
                      onPrimary: Theme.of(context).textTheme.headline1!.color,
                      elevation: 0,
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text("Hi, \nWelcome back",
                  style: Theme.of(context).textTheme.headline1),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email or Phone Number",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Forgot Password?",
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              HomePage(title: "Expense Tracker"),
                        ),
                      )
                    },
                    child: Center(
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontWeight : FontWeight.bold,
                          color: Theme.of(context).backgroundColor,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              Row(children: <Widget>[
                Expanded(
                  child: Divider(),
                ),
                Text("    Or continue with    ", style:Theme.of(context).textTheme.bodyText1),
                Expanded(
                  child: Divider(),
                ),
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage('assets/icons/facebook.png'),
                    width: 50,
                  ),
                  SizedBox(width: 40),
                  Image(
                    image: AssetImage('assets/icons/google.png'),
                    width: 50,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
