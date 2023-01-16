
import 'dart:developer';

import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:math_bingo/formulas_data.dart';
import 'package:math_bingo/play_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final prefs = SharedPreferences.getInstance();
  FormulasData formulasData = FormulasData(formulas: []);
  late final PlayController _playController = PlayController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  String currentFormula = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff400101),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(FluentIcons.arrow_left_20_regular))
            ],
          )
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xff400101),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'Informações do game',
                        style: TextStyle(color: Colors.white, fontSize: 26),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Formulas restantes : ${_playController.formulasInBox.length}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Formulas lançadas : ${_playController.formulasOutBox.length}',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                )),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Formulas já lançadas',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: ListView(
                children: [
                  ..._playController.formulasOutBox
                      .map(
                        (e) => ListTile(
                          title: Text(e,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16)),
                          onTap: () {
                            // Update the state of the app.
                            // ...
                          },
                        ),
                      )
                      .toList()
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Formulas restantes',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 250,
              child: ListView(
                children: [
                  ..._playController.formulasInBox.reversed
                      .map(
                        (e) => ListTile(
                          title: Text(
                            e,
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          onTap: () {
                            // Update the state of the app.
                            // ...
                          },
                        ),
                      )
                      .toList()
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_playController.hasGenerateAllFormulas()) {
            currentFormula = _playController.getFormula();
          } else {
            currentFormula = "* Game Over *";
          }
          setState(() {});
        },
        backgroundColor: Colors.white,
        child: const Icon(
          FluentIcons.arrow_step_over_20_filled,
          color: Color(0xffD6675A),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                currentFormula == ""
                    ? "Pressione o botão do lado inferior direito para lançar uma formula"
                    : currentFormula,
                style: TextStyle(
                  fontSize: currentFormula == "" ? 16 : 32,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
