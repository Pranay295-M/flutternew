


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/home.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/register.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String mail="",Password="";
  TextEditingController mailcontrol=new TextEditingController();
  TextEditingController passcontrol=new TextEditingController();

  final _formkey= GlobalKey<FormState>();
  userLogin() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: mail, password: Password);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>home()));
    }
    on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor:Colors.green,content: Text("No user found for that email",style: TextStyle(fontSize: 20),
        )
        )
        );

      }
      else if(e.code=='wrong-password'){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor:Colors.green,content: Text("Wrong Password",style: TextStyle(fontSize: 20),
        )
        )
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WasteWisePro'),),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 300,
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Login'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value){
                          if(value==null||value.isEmpty)
                          {
                            return 'Enter Email';
                          }
                          return null;
                        },
                        controller: mailcontrol,
                        decoration:InputDecoration(
                            labelText: 'Enter Mobile No./Email',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value){
                          if(value==null||value.isEmpty)
                          {
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: passcontrol,
                        decoration:InputDecoration(
                            labelText: 'Password',
                            border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed:(){
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            mail=mailcontrol.text;
                            Password=passcontrol.text;
                          });
                        }
                        userLogin();
                      },
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                          child: Text('Login')
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>register()
                            )
                        );
                      },
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
                          child: Text('New User')
                      ),
                    )

                  ],


                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}


