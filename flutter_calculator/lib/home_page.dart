import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  State createState() =>  HomePageState();
}

class HomePageState extends State<HomePage>{

  var num1="0", num2="0", ansStr='0', ans=0, oper='', flag=0 ;

  void _clear() {
    setState(() {
          num1="0"; num2="0"; ansStr='0'; ans=0; oper=''; flag=0 ;
        });
  }

  void _add(){
    setState(() {
      oper= '+';
      if(flag==0){
        num2 = num1;
      }
      else {
        num2 = ansStr;
      }
        num1 = '0';
        ansStr= oper;
    });
  }
  void _sub(){
    setState(() {
      oper= '-';
      if(flag==0){
        num2 = num1;
      }
      else {
        num2 = ansStr;
      }
        num1 = '0';
      ansStr= oper;
        });
  }
  void _mul(){
    setState(() {
          oper= '*';
          if(flag==0){
            num2 = num1;
          }
          else{
            num2 = ansStr;
          }
          num1 = '0';
          ansStr= oper;
        });
  }
  
  void _div(){
    setState(() {
          oper= '/';
          if(flag==0){
            num2 = num1;
          }
          else{
            num2 = ansStr;
          }
          num1 = '0';
          ansStr= oper;
        });
  }
  void _one(){
    setState(() {
          num1+="1";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _two(){
    setState(() {
          num1+="2";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _three(){
    setState(() {
          num1+="3";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _four(){
    setState(() {
          num1+="4";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _five(){
    setState(() {
          num1+="5";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }  
  void _six(){
    setState(() {
          num1+="6";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _seven(){
    setState(() {
          num1+="7";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _eight(){
    setState(() {
          num1+="8";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _nine(){
    setState(() {
          num1+="9";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }
  void _zero(){
    setState(() {
          num1+="0";
          ans =int.parse(num1);
          ansStr = "$ans";
        });
  }

  void _disp() {
    setState(() {
      if(oper=='+'){
        ans = int.parse(num1)+int.parse(num2);
        flag++;
      }
      else if(oper == '-'){
        ans = int.parse(num2)-int.parse(num1);
        flag++;        
      }
      else if(oper == '*'){
        ans = int.parse(num2)*int.parse(num1);
        flag++;        
      }
      else if(oper == '/'){
        ans = int.parse(num2)~/int.parse(num1);
        flag++;        
      }
      ansStr = "$ans";
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:  AppBar(
        title:  Text("Calculator"),
      ),
      body:  Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             Container(
              constraints:  BoxConstraints.expand(
                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0,
              ),
              alignment: Alignment.bottomRight,
              child:  Text(
                "$ansStr",
                style:  TextStyle(
                  fontSize: 50.0,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("9", _nine),
                 _button("8", _eight),
                 _button("7", _seven),
                 _button("+", _add)
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("6", _six),
                 _button("5", _five),
                 _button("4", _four),
                 _button("-", _sub)
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("3", _three),
                 _button("2", _two),
                 _button("1", _one),
                 _button("*", _mul)
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("C", _clear),
                 _button("0", _zero),
                 _button("=", _disp),
                 _button("/", _div)               
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _button (String number, Function() f){
    return MaterialButton(
      height: 100.0,
      child: Text(number,
      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.grey[100],
      onPressed: f,
    );
  }
}