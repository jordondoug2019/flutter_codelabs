// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';
//Root of the Login Page
//Represents the entire page displayed in the simulator 
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

//Login Widget- Stateful widget- State is changeable 
//function controls how all the widgets in our UI are created
class _LoginPageState extends State<LoginPage> {
  // TODO: Add text editing controllers (101)
  //Allows for text fields to be clear
   final _usernameController = TextEditingController();
   final _passwordController = TextEditingController();
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset('assets/diamond.png'),
                const SizedBox(height: 16.0),
                Text(
                  'SHRINE',
                style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            //  Remove filled: true values (103)
            // Add TextField widgets (101)

            // Username
          Padding(
           padding: const EdgeInsets.only(bottom: 12.0), // 👈 adds spacing below
          child: TextField(
          decoration: const InputDecoration(
          labelText: 'Username',
    ),
       controller: _usernameController,
  ),
),
          // [Password]
          Padding(
         padding: const EdgeInsets.only(bottom: 24.0), // optional: spacing before buttons
        child: TextField(
         decoration: const InputDecoration(
        labelText: 'Password',
    ),
    obscureText: true,
    controller: _passwordController,
  ),
),
            // TODO: Add button bar (101)
  
            //Overflow Bar is a layout widget that tries to put all its children in a row, but if they dont fit
            //it wraps the rest to the next line
           OverflowBar(
  alignment: MainAxisAlignment.end,
  // TODO: Add a beveled rectangular border to CANCEL (103)
  children: <Widget>[
        // TODO: Add buttons (101)
    TextButton(
      child: const Text('CANCEL'),
      onPressed: () {
        //clears out text fields 
          _usernameController.clear();
          _passwordController.clear();
      },
    ),
    // TODO: Add an elevation to NEXT (103)
    // TODO: Add a beveled rectangular border to NEXT (103)
    ElevatedButton(
      child: const Text('NEXT'),
      onPressed: () {
    // TODO: Show the next page (101) 
      Navigator.pop(context);
      },
    ),
  ],
),
          ],    
        ),
      ),
    );
  }
}
