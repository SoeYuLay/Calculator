import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String expression = '';
  String temp = '';

  void action(String text) {
    if(text=='AC'){
      setState(() {
        expression = '';
        temp = '';
      });
      return;
    }

    if (text == '='){
      // 5+10 -> =
      // 5,+,10
      RegExp regExp = RegExp(r'(\d+.\d+|\d+\+|\-|\x|\/|\%)');
      List<String> result = regExp.allMatches(expression).map((mobj)=>mobj.group(0)!).toList();
      // int a = int.parse(result[0]);
      // String op = result[1];
      // int b= int.parse(result[2]);
      // String ans = '';

      // 5 + 3 - 2 + 7
      List<String> ops = [];
      List<int> numbers = [];
      if (result.length == 2 && result[1] == '%'){
        setState(() {
          expression = '${int.parse(result[0])/100}';
        });
      }

      for(int i=0;i<result.length;i++){
        if(i%2 == 0) numbers.add(int.parse(result[i]));
        else ops.add(result[i]);
      }

      print(ops);
      print(numbers);
      int index = 1;
      int a = numbers[0], b=numbers[index],ans = 0;
      for(String op in ops){

        switch(op){
          case "+": ans = a+b; break;
          case "-": ans = a-b; break;
          case "x": ans = a*b; break;
          case "/": ans = a~/b; break;
        }

        a = ans;
        if(ops.length == 1 || index == ops.length) break;
        b = numbers[++index];
      }

      setState(() {
        temp = expression;
        expression = ans.toString();
      });

    }else{

      setState(() {
        temp = '';
        expression += text;
      });
    }
  }

  Widget buildCard(String text, {int flex = 1}) {
    Color color = (text == '/' ||
        text == 'x' ||
        text == '+' ||
        text == '-' ||
        text == '=')
        ? Colors.orange
        : Colors.white;
    return Expanded(
      flex: flex,
      child: InkWell(
        borderRadius: BorderRadius.circular(200),
        splashColor: Colors.orange,
        hoverColor: Colors.black12,
        onTap: () => action(text),
        child: Card(
          color: color,
          elevation: 10,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: TextStyle(fontSize: 24, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0,right: 5.0),
                  child: Text(temp, style: TextStyle(fontSize: 28, color: Colors.black54),),
                )),
            Align(
              alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0,right: 5.0),
                  child: Text(expression, style: TextStyle(fontSize: 28, color: Colors.black54),),
                )),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildCard('AC'),
                buildCard('+/-'),
                buildCard('%'),
                buildCard('/'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildCard('7'),
                buildCard('8'),
                buildCard('9'),
                buildCard('x'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildCard('4'),
                buildCard('5'),
                buildCard('6'),
                buildCard('-'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildCard('1'),
                buildCard('2'),
                buildCard('3'),
                buildCard('+'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                buildCard('0'),
                buildCard('.'),
                buildCard('=', flex: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
