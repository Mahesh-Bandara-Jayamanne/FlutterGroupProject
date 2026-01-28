# FlutterGroupProject
Group Assessment

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      home: AppHome(),
    ),
  );
}

class AppHome extends StatefulWidget {
  const AppHome({super.key});

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 151, 191, 198),
        title: Text(
          "Tip Calculature",
          style: TextStyle(
            fontSize: 30,
            color: Colors.amber,
          ),
        ),
      ),
      body: const _AppBodyState(),
    );
  }
}

class _AppBodyState extends StatefulWidget {
  const _AppBodyState({super.key});

  @override
  State<_AppBodyState> createState() => __AppBodyStateState();
}

class __AppBodyStateState extends State<_AppBodyState> {

 TextEditingController billAmountCont = TextEditingController( );
  
  double tipPrecent = 0.0;
  double tipAmount = 0.0;
  double billAmount = 0.0;

  void Calculate (){
    double bill = double.tryParse(billAmountCont.text) ?? 0;
    setState(() {
      tipAmount = bill *tipPrecent / 100;
      billAmount = bill + tipAmount;
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //card1
          Card(
            shadowColor: const Color.fromARGB(255, 167, 156, 122),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "Bill Amount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //text feld
                TextField(
                  controller: null,
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    hintText: "Enter Bill Amount",
                    labelText: "Your Bill Amount",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          
          SizedBox(height: 10),

          //card2
          Card(
            shadowColor: const Color.fromARGB(255, 167, 156, 122),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "Tip percentage: ${tipPrecent.toInt()}%",
                  style: TextStyle(fontSize: 20, color: Colors.purple),
                ),
                SizedBox(height: 10),
                Slider(
                  value: tipPrecent,
                  onChanged: (value) {
                    setState(() {
                      tipPrecent = value;
                    });
                  },
                  min: 0,
                  max: 50,
                  divisions: 50,
                  label: "${tipPrecent.toInt()}%",
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: Calculate ,
          style: ElevatedButton.styleFrom(),
            child: const Text(
             "Calculate",
           style: TextStyle(
             fontSize: 20,
          fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 41, 180, 59),
       ),
      ),
      ),

          
          
          Card(
            shadowColor: const Color.fromARGB(255, 167, 156, 122),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text(
                  "Tip : ${tipAmount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Total Bill : $billAmount",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

               
                SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
      );
  }

}
