import 'package:flutter/material.dart';
import '../views/Societyviews.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LoginSociety extends StatefulWidget {
  @override
  _LoginSocietyState createState() => _LoginSocietyState();
}

class _LoginSocietyState extends State<LoginSociety> {
  final TextEditingController _passcontroller = new TextEditingController();

  final TextEditingController _namecontroller = new TextEditingController();
final _formKey = GlobalKey<FormState>();
final globalkey = GlobalKey<ScaffoldState>();
var error = "Error";
  @override
  final _firestore = FirebaseFirestore.instance;
  String email;
  String password;
  Widget build(BuildContext context) {
    return Scaffold(
       key: globalkey,
        body: Container(
            height : MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [Colors.green.shade800, Colors.green.shade200]
                )
            ),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                          new Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            child: new Image.asset("images/thapar.png",
                                height: 125,
                                width: 125,
                                fit: BoxFit.fill,
                            ),
                          ),
                          new SizedBox(height: 10.000,),
                          Center(
                              child: new Text("LOGIN AS SOCIETY",
                                  style: new TextStyle(fontSize: 25, decoration: TextDecoration.underline, color: Colors.white, fontFamily: "Poppins",))
                          ),

                          new SizedBox(height: 8.0,),
                          new Text("Enter your Email and Password to proceed",
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,


                            ),),
                          new SizedBox(height: 30.0,),
                          new Container(
                              height: MediaQuery.of(context).size.height*0.31,
                              width: MediaQuery.of(context).size.width*0.9,
                              child: Column(
                                  children:[ Container(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width*0.85,
                                    decoration: new BoxDecoration(
                                        borderRadius: BorderRadius.circular(25.0),
                                        color: Colors.transparent,
                                        border: Border.all(
                                            color: Colors.white,
                                            width: 0.5
                                        )
                                    ),
                                    child: Row(
                                        children:[
                                          new CircleAvatar(
                                            radius: 25.00,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.supervised_user_circle, color: Colors.greenAccent,),
                                          ),
                                          Expanded(
                                            child: new TextFormField(
                                              textAlign: TextAlign.center,
                                              controller: _namecontroller,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Email",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontFamily: "Poppins"
                                                  ),
                                                  contentPadding: EdgeInsets.fromLTRB(70, 0.0, 100, 0.0)

                                              ),
                                              onChanged: (value){
                                                setState((){
                                                  email = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),]
                                    ),
                                  ),
                                    SizedBox(height: 15.0,),
                                    Container(

                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width*0.85,
                                      decoration: new BoxDecoration(
                                          borderRadius: BorderRadius.circular(25.0),
                                          color: Colors.transparent,
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 0.5
                                          )
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          new CircleAvatar(
                                            radius: 25.00,
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.lock, color: Colors.greenAccent,),
                                          ),
                                          Expanded(
                                            child: new TextFormField(
                                              obscureText: true,
                                              textAlign: TextAlign.center,
                                              controller: _passcontroller,
                                              decoration: new InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Password",
                                                  labelStyle: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontFamily: "Poppins"
                                                  ),
                                                  contentPadding: EdgeInsets.fromLTRB(67, 0.0, 100, 0.0)
                                              ),
                                              onChanged: (value){
                                                setState((){
                                                  password   = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'Please enter some text';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    new SizedBox(height: 15.000,),
                                    SizedBox(
                                      height: 50.0,
                                      width: MediaQuery.of(context).size.width*0.85,
                                      child: new RaisedButton(onPressed: (){
                                    
                                        if(_formKey.currentState.validate()){
                                           FirebaseAuth.instance.signInWithEmailAndPassword(
                                            email: email,
                                            password: password)
                                            .then((FirebaseUser) {
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=> SocietyView()));
                                        })
                                            .catchError((e){
                                              print(e);
                                              setState((){
                                                error = e.toString();
                                              });
                                          final snackBar = SnackBar(content: Text(error, style : new TextStyle(color: Colors.greenAccent, fontFamily: "Poppins")));
                                          globalkey.currentState.showSnackBar(snackBar);
                                        });
                                        }
                                       _namecontroller.clear();
                             _passcontroller.clear();  
                                         }
                                      ,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(25.0),

                                        ),

                                        child: new Text("PROCEED", style: new TextStyle(
                                            fontSize: 20,
                                            color: Colors.greenAccent,
                                            fontFamily : "Poppins"
                                        ),),
                                        color: Colors.white,),
                                    ),
                                    new SizedBox(height: 20.0,),
                                  ])),
                        ])))));
  }
}