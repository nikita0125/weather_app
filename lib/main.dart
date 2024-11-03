import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return   MaterialApp(
      home:const WeatherScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
     
     
    
    );
  }
}





//Layout Theory
//Constraints go down,sizes go up,parent sets  position  
// Constraints go down::  constarinst means boundries so widget recieve boundries from parent widget 

// 3 types of widget tree: 1. widget tree 2. element tree(brain) 3. render object tree  
// run time of buildcontext is stateless element changes acc to the state
