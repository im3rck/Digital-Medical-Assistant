import 'package:flutter/material.dart';
import 'package:med_app/Widgets/widgets.dart';
import 'package:med_app/services/auth.dart';

class SignUpCareGiver extends StatefulWidget{
  @override
  _SignUpCareGiverState createState() => _SignUpCareGiverState();
}

class _SignUpCareGiverState extends State<SignUpCareGiver>{

  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  signMeUP(){
    if(formKey.currentState.validate()){
      setState(() {
        isLoading = true;
      });
      authMethods.signUpwithEmailandPassword(emailTextEditingController.text, passwordTextEditingController.text).then((value) => print("$value"));
    }
  }


  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: appBarMain(context),
        body: isLoading ? Container(
          child: Center (child: CircularProgressIndicator(
          ),
        )
        ):
        SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height - 50,
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              validator: (val){
                              return val.isEmpty || val.length < 4 ? "Invalid Username":null;
                            },
                        controller: userNameTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('Username'),
                      ),
                            TextFormField(
                              validator: (val){
                                return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(val) ? null : "Invalid Email";
                              },
                        controller: emailTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Email"),
                      ),
                            TextFormField(
                              obscureText: true,
                              validator: (val){
                                return val.length < 6 ? "Enter a stronger Password" : null;
                              },
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration("Password"),
                      ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Text('Forgot Password?', style: simpleTextStyle(),),
                        ),
                      ),
                      SizedBox(height: 16,),
                      GestureDetector(
                        onTap: (){
                          signMeUP();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    const Color(0xff007EF4),
                                    const Color(0xff2A75BC)
                                  ]
                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text("Sign Up",style: mediumTextStyle(),),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: Text("Sign up with Google",style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                        ),
                      ),
                      SizedBox(height: 16,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?  ",style: mediumTextStyle(),),
                          Text("Sign In",style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            decoration: TextDecoration.underline,
                          ),
                          ),
                        ],
                      ),
                      SizedBox(height: 50,),
                    ],
                  )
              )
          ),
        ),
      );

  }
}