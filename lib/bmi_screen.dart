import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();

  var bgColor = Colors.indigo[50];

  var result='';

  void calculateBmi(){

  var wt= wtController.text.trim();
  var ft= ftController.text.trim();
  var inch= inchController.text.trim();

  if(wt.isNotEmpty && ft.isNotEmpty && inch.isNotEmpty){
    try{
      var intWt= int.parse(wt);
      var intFt= int.parse(ft);
      var intInch= int.parse(inch);

      var totalInch= (intFt * 12) + intInch;
      var totalCm= totalInch * 2.54;
      var totalMeter= totalCm/100;

      var bmi= intWt/(totalMeter* totalMeter);
      var msg= '';

      if(bmi<=18.5){
        msg= 'You are under Weight';
        bgColor= Colors.red.shade200;
      }else if(bmi>=18.5 && bmi<24.9){
        msg= 'Congrats, You are healthy';
        bgColor= Colors.green.shade100;
      }else if(bmi>= 24.9 && bmi<30){
        msg= 'You are over Weight';
        bgColor= Colors.orange.shade200;
      }else{
        msg = 'You are obese';
        bgColor= Colors.orange.shade400;
      }

      setState(() {
        result= '$msg \nYour BMI is ${bmi.toStringAsFixed(4)}';
      });
    }catch(e){
      setState(() {
        result='please enter valid numbers';
      });
    }
  }else{
   setState(() {
     result = 'please fill all required fields to perform Calculations';
   });
  }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            const Text(
            'BMI Calculator',
            style: TextStyle(
                color: Colors.black,
                fontSize: 35,
                wordSpacing: 1,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10,),
          TextField(
            keyboardType: TextInputType.number,
            controller: wtController,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.line_weight),
              labelText: 'Enter weight in Kg',

              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),),
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: ftController,
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.height),
                labelText: 'Enter Height in Feet',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),),
                border: OutlineInputBorder(),
          ),

        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: TextInputType.number,
          controller: inchController,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.height),
            labelText: 'Enter Height in Inches',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),),
            border: OutlineInputBorder(),

          ),

        ),
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                shape: const RoundedRectangleBorder()),
            onPressed:calculateBmi,
            child: const Text('Calculate')),
         const SizedBox(height: 10,),
         Text(result,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 16,),
         textAlign: TextAlign.center,),
        ],
      ),
    ),)
    ,
    );
  }
}
