


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/home.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/login_page.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  String name="",emailorno="",password="";
  TextEditingController nameController= new TextEditingController();
  TextEditingController mailornoController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();

  final _formkey=GlobalKey<FormState>();

registration() async{
  if(password!=null&&nameController!=" "&&mailornoController!="")
    {
      try{
        UserCredential userCredential=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailorno, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register Successfully',style: TextStyle(fontSize: 20),)));
        Navigator.push(context, MaterialPageRoute(builder: (context)=>loginPage()));
      }on FirebaseAuthException catch(e){
        if(e.code=='email-already-in-use'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor:Colors.green,content: Text('Email already exist',style: TextStyle(fontSize: 20),)));
        }else if(e.code=='weak-password'){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor:Colors.green,content: Text('Password is to weak',style: TextStyle(fontSize: 20),)));
        }
      }
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WasteWisePro'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                '"images/icon.png"',
                height: 150,
              ),
              SizedBox(height: 20),
              Text(
                'Create an Account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value){
                            if(value==null||value.isEmpty)
                              {
                                return 'Enter Name';
                              }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(

                            labelText: 'Name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        validator: (value){
                          if(value==null||value.isEmpty)
                          {
                            return 'Enter Number or email';
                          }
                          return null;
                        },
                        controller: mailornoController,
                        decoration: InputDecoration(
                          labelText: 'Mobile Number/Email',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        validator: (value){
                          if(value==null||value.isEmpty)
                          {
                            return 'Enter password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(height: 16),

                      
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            setState(() {
                              name=nameController.text;
                              emailorno=mailornoController.text;
                              password=passwordController.text;
                            });
                          }
                          registration();

                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 60, vertical: 16),
                            textStyle: TextStyle(fontSize: 18),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                        ),
                        child: Text('Register'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

