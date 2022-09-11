import 'dart:convert';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_bingo/formulas.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Formulas extends StatefulWidget {
  const Formulas({super.key});

  @override
  State<Formulas> createState() => _FormulasState();
}

class _FormulasState extends State<Formulas> {
  TextEditingController controllerFormula = TextEditingController();
  TextEditingController controllerResult = TextEditingController();
  final prefs = SharedPreferences.getInstance();
  FormulasData formulasData = FormulasData(formulas: []);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences sharedPreferences = await prefs;

      if (sharedPreferences.containsKey('formulasData')) {
        getFormulas();
      }
    });
  }

  void SaveFormula() async {
    String formula = controllerFormula.text;
    String result = controllerResult.text;
    SharedPreferences preferences = await prefs;
    formulasData.addFormula(formula, result);
    String json = JsonEncoder().convert(formulasData.toJson());

    preferences.setString('formulasData', json);
  }

  void getFormulas() async {
    SharedPreferences preferences = await prefs;
    String jsonData = preferences.getString('formulasData') ?? "";

    Map json = JsonDecoder().convert(jsonData);

    formulasData = FormulasData.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 70,
                    child: TextField(
                      controller: controllerFormula,
                      decoration: InputDecoration(
                        labelText: "Formula",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 70,
                    child: TextField(
                      controller: controllerResult,
                      decoration: InputDecoration(
                        labelText: "Resultado",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 70,
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(FluentIcons.add_20_filled),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView(
                  children: [
                    Text('data'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
