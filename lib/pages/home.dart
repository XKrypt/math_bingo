import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_bingo/pages/formulas.dart';
import 'package:math_bingo/pages/play.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int pageIndex = 0;

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff400101),
      body: PageView(
        controller: pageController,
        onPageChanged: (int page) {
          setState(() {
            pageIndex = page;
          });
        },
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                          width: 1,
                          color: Colors.white,
                        )),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayScreen()));
                        },
                        child: const Text(
                          'Começar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Formulas()
        ],
      ),
    );
  }
}
