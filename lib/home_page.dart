import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<StatefulWidget>{
  TextEditingController wtController = TextEditingController();
  TextEditingController ftController = TextEditingController();
  TextEditingController inController = TextEditingController();

  num bmi = 0.0;
  String imgPath = '';
  Color bgColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: Text('BMI'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Find your BMI',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: wtController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.line_weight),
                hintText: "Enter your Weight(in kGs)",
                label: Text('Weight(in KGs)'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue.shade500,
                        width: 1
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1
                    )
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: ftController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.height),
                hintText: "Enter your Height(in Feet)",
                label: Text('Height(in Feet)'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue.shade500,
                        width: 1
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1
                    )
                ),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: inController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.height),
                hintText: "Enter your Height(in Inch)",
                label: Text('Height(in Inch)'),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue.shade500,
                        width: 1
                    )
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(21),
                    borderSide: BorderSide(
                        color: Colors.blue,
                        width: 1
                    )
                ),
              ),
            ),
            SizedBox(
              height: 21,
            ),
            ElevatedButton(onPressed: () {
              ///calculate bmi
              num wt = double.parse(wtController.text.toString());
              int ft = int.parse(ftController.text.toString());
              int inch = int.parse(ftController.text.toString());

              int totalInches = (ft * 12) + inch;
              num totalCM = 2.54 * totalInches;
              num totalM = totalCM / 100;

              bmi = wt / pow(totalM, 2.0);

              if (bmi > 25) {
                bgColor = Colors.red.shade200;
                imgPath = 'assets/icons/ic_overwt.png';
              } else if (bmi < 18) {
                bgColor = Colors.orange.shade200;
                imgPath = 'assets/icons/ic_underwt.png';
              } else {
                bgColor = Colors.green.shade200;
                imgPath = 'assets/icons/ic_healthy.png';
              }

              setState(() {

              });

            }, child: Text('Calculate BMI')),
            SizedBox(
              height: 11,
            ),
            bmi == 0.0 ? Container() : Text("Your BMI is: ${bmi.toStringAsFixed(2)}"),
            imgPath == '' ? Container() : Image.asset(imgPath, width: 100, height: 100,),
          ],
        ),
      ),
    );
  }
}