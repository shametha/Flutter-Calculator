import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main(){
  runApp(MyCalculator());
}

class MyCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class  _SimpleCalculatorState extends State<SimpleCalculator>{
  String equation="0",result="0",expression="",temp="";
  double eqnFontSize=38, resFontSize=48;
  buttonPressed(buttonText){
    setState(() {
      if(buttonText == "C"){
        equation="0";
        result="0";
      }
      else if(buttonText == "DEL"){
        equation=equation.substring(0,equation.length-1);
        if(equation=="")
          equation="0";
      }
      else if(buttonText == "ANS") {
          equation+=temp;
      }
      else if(buttonText == "="){
        expression=equation;
        expression=expression.replaceAll("×", "*");
        expression=expression.replaceAll("÷", "/");
        try{
          Parser P = new Parser();
          Expression exp = P.parse(expression);
          ContextModel cm =ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          temp=result;
        }
        catch(e){
          result="Error";
        }

      }
      else{
        if(equation=="0")
          equation=buttonText;
        else
          equation=equation+buttonText;
      }
    });

  }
  Widget buildButton(String buttonText,double buttonHeight,Color buttonColor){
    return Container(
      height:MediaQuery.of(context).size.height*0.1*buttonHeight,
      color: buttonColor,
      child: SizedBox(
        width: 5,
        height: 5,
        child: FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.white,width: 1,
                style: BorderStyle.solid),
          ),
          padding: EdgeInsets.all(0),
          onPressed: ()=> buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title :
          Text('Calculator',style:
          TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          )

          )
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10,20,10,0),
            child: Text(equation,style: TextStyle(fontSize: eqnFontSize),),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10,30,10,0),
            child: Text(result,style: TextStyle(fontSize: resFontSize),),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                color: Colors.white,
                width:MediaQuery.of(context).size.width*0.80,
                child: Table(
                children:[
                  TableRow(
                    children:[
                      buildButton("C", 1.2, Colors.green),
                      buildButton("DEL", 1.2, Colors.red),
                      buildButton("ANS", 1.2, Colors.indigo),
                    ]
                  ),
                  TableRow(
                      children:[
                        buildButton("7", 1.2, Colors.blue),
                        buildButton("8", 1.2, Colors.blue),
                        buildButton("9", 1.2, Colors.blue),
                      ]
                  ),
                  TableRow(
                      children:[
                        buildButton("4", 1.2, Colors.blue),
                        buildButton("5", 1.2, Colors.blue),
                        buildButton("6", 1.2, Colors.blue),
                      ]
                  ),
                  TableRow(
                      children:[
                        buildButton("1", 1.2, Colors.blue),
                        buildButton("2", 1.2, Colors.blue),
                        buildButton("3", 1.2, Colors.blue),
                      ]
                  ),
                  TableRow(
                      children:[
                        buildButton(".", 1.2, Colors.blue),
                        buildButton("0", 1.2, Colors.blue),
                        buildButton("00", 1.2, Colors.blue),
                      ]
                  ),
                ]
                ),
              ),
              Container(
                width:MediaQuery.of(context).size.width*0.20,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("÷", 1, Colors.indigo),
                      ]
                    ),
                    TableRow(
                        children: [
                          buildButton("×", 1, Colors.indigo),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("+", 1, Colors.indigo),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("-", 1, Colors.indigo),
                        ]
                    ),
                    TableRow(
                        children: [
                          buildButton("=", 2, Colors.green),
                        ]
                    ),
                  ],
                ),
              )
            ],

          )
        ],
      ),
    );
  }
}