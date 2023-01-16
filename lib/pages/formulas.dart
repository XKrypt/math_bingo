import 'dart:convert';
import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_bingo/formulas_data.dart';
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
        setState(() {});
      }
    });
  }

  bool validate() {
    String formula = controllerFormula.text;
    String result = controllerResult.text;
    return !(formula == "" ||
        result == "" ||
        formula == null ||
        result == null);
  }

  void saveFormula() async {
    String formula = controllerFormula.text;
    String result = controllerResult.text;

    log(formula);
    log(result);
    SharedPreferences preferences = await prefs;
    formulasData.addFormula(formula, result);
    String json = JsonEncoder().convert(formulasData.toJson());
    log(json);
    preferences.setString('formulasData', json);
  }

  void saveFormulas() async {
    SharedPreferences preferences = await prefs;
    String json = JsonEncoder().convert(formulasData.toJson());
    log(json);
    preferences.setString('formulasData', json);
  }

  void getFormulas() async {
    SharedPreferences preferences = await prefs;
    String jsonData = preferences.getString('formulasData') ?? "";
    log(jsonData);
    Map json = JsonDecoder().convert(jsonData);

    formulasData = FormulasData.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff400101),
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
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 2, color: Colors.white)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: Color(0xff6DC75E))),
                          labelText: "Formula",
                          labelStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 70,
                    child: TextField(
                      controller: controllerResult,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 2, color: Color(0xff6DC75E))),
                        labelText: "Resultado",
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    height: 70,
                    child: IconButton(
                      onPressed: () {
                        if (validate()) {
                          saveFormula();
                          getFormulas();
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        FluentIcons.add_20_filled,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...formulasData.formulas
                        .map((e) => Container(
                              height: 35,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.formula,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "Resposta: " + e.result,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      formulasData.removeFormula(e.formula);
                                      saveFormulas();
                                      getFormulas();
                                      setState(() {});
                                    },
                                    icon: const Icon(
                                        FluentIcons.delete_20_filled),
                                    color: Color(0xff730202),
                                  ),
                                ],
                              ),
                            ))
                        .toList()
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
