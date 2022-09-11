import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:math_bingo/pages/formulas.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: pageIndex,
        backgroundColor: Color(0xff66281F),
        unselectedItemColor: Color(0xffEA5C46),
        selectedItemColor: Colors.white,
        onTap: (int index) {
          pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 100),
            curve: Curves.easeIn,
          );
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.home_20_filled), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(FluentIcons.math_formula_20_filled),
              label: 'Formulas'),
        ],
      ),
      backgroundColor: Color(0xffD6675A),
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
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Começar',
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
