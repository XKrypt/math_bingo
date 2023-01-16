import 'dart:developer';
import 'dart:math';

import 'package:math_bingo/formulas_data.dart';
import 'package:math_bingo/pages/formulas.dart';

class PlayController {
  List<String> formulasOutBox = [];
  List<String> formulasInBox = [
    "1 + 0",
    "1 + 1",
    "2 + 1",
    "2 + 2",
    "3 + 2",
    "4 + 2",
    "4 + 3",
    "5 + 3",
    "6 + 3",
    "7 + 3",
    "6 + 5",
    "7 + 5",
    "10 + 3",
    "7 + 7",
    "8 + 7",
    "8 + 8",
    "9 + 8",
    "12 + 6",
    "15 + 4",
    "16 + 4",
    "3 * 7",
    "2 * 11",
    "50 - 37",
    "3 * 8",
    "75 - 50",
    "48 - 22",
    "9 * 3",
    "4 * 7",
    "50 - 31",
    "60 / 2",
    "100 - 69",
    "4 * 8",
    "11 * 3",
    "2 * 17",
    "7 * 5",
    "6 * 6",
    "51 - 14",
    "82 - 44",
    "54 - 15",
    "160 / 4",
    "11 + 30",
    "7 * 6",
    "60 - 17",
    "22 + 22",
    "90 / 2",
    "23 + 23",
    "60 - 13",
    "96 / 2",
    "7 * 7",
    "100 / 2",
    "60 - 9",
    "85 - 33",
    "100 - 47",
    "162 / 3",
    "100 - 45",
    "8 * 7",
    "228 / 4",
    "100 - 42",
    "100 - 41",
    "120 / 2",
    "150 - 89",
    "31 * 2",
    "504 / 8",
    "320 / 5",
    "455 / 7",
    "726 / 11",
    "1005 / 15",
    "422 - 354",
    "6210 / 90",
    "490 / 7",
    "1310 - 1239",
    "360 / 5",
    "40 + 33",
    "863 - 789",
    "9975 / 133"
  ];

  PlayController();

  String getFormula() {
    var rand = Random();

    int randIndex = rand.nextInt(formulasInBox.length);
    String formula = formulasInBox[randIndex];
    formulasInBox.remove(formula);
    formulasOutBox.add(formula);
    print(formula);
    return formula;
  }

  bool hasGenerateAllFormulas() {
    return formulasInBox.length == 0;
  }
}
