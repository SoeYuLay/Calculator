import 'dart:math';

import 'package:calculator/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String input = '';
  String result = '';
  var hideInput = false;


  calculate(String value){
    if(value == 'AC'){
      input = "";
      result = "";
    }else if(value == '<'){
      if(value.isNotEmpty){
        input = input.substring(0,input.length-1);
      }
    }else if(value == '='){
      if(value.isNotEmpty){
        var calculateValue = input.replaceAll('x', '*');
        Parser p = Parser();
        Expression expression = p.parse(calculateValue);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        result = finalValue.toString();
        if(result.endsWith('.0')){
          result = result.substring(0,result.length-2);
        }
        input = result;
        hideInput = true;
      }
    }else{
      input +=value;
      hideInput = false;
    }
    setState(() {});
  }

  bool isOperator(String text){
    return ['AC','<','+/-','/','x','-','+','=','%'].contains(text);
  }



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    Widget buildCard(String text) {
      Color cardColor = isOperator(text) ? AppColors.operatorColor : (isDark ? AppColors.numberColorD : AppColors.numberColorL);
      Color cardTextColor = isOperator(text) ? AppColors.operatorText : (isDark ? AppColors.numberTextD : AppColors.numberTextL);
      return Expanded(
          flex: 1,
          child: InkWell(
            borderRadius: BorderRadius.circular(200),
            splashColor: const Color(0xFFD9E4F7),
            hoverColor: Colors.black12,
            onTap: ()=>calculate(text),
            child: Card(
              color: cardColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(text,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        color: cardTextColor
                    )),
              ),
            ),
          ));
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Text(hideInput ? " " : input,
                      style: TextStyle(fontSize: 35, color: isDark ? AppColors.valueD : AppColors.valueL))),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: Text(result,
                    style: TextStyle(fontSize: 35, color: isDark ? AppColors.valueD : AppColors.valueL)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  buildCard('AC'),
                  buildCard('<'),
                  buildCard('+/-'),
                  buildCard('/'),
                ],
              ),
              Row(
                children: [
                  buildCard('7'),
                  buildCard('8'),
                  buildCard('9'),
                  buildCard('x'),
                ],
              ),
              Row(
                children: [
                  buildCard('4'),
                  buildCard('5'),
                  buildCard('6'),
                  buildCard('-'),
                ],
              ),
              Row(
                children: [
                  buildCard('1'),
                  buildCard('2'),
                  buildCard('3'),
                  buildCard('+'),
                ],
              ),
              Row(
                children: [
                  buildCard('%'),
                  buildCard('0'),
                  buildCard('.'),
                  buildCard('='),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
