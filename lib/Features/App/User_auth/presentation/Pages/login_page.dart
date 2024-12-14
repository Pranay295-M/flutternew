


import 'package:flutter/material.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/home.dart';
import 'package:flutternew/Features/App/User_auth/presentation/Pages/register.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WasteWisePro'),),
      body: Center(
        child: Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Login'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration:InputDecoration(
                      labelText: 'Enter Mobile No./Email',
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20))
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>home()
                      )
                  );
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

    );
  }
}
