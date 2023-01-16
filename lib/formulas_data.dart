import 'dart:ffi';

class FormulasData {
  List<Formula> formulas;

  FormulasData({required this.formulas});

  void saveFormulas() {}

  void addFormula(String formula, String result) {
    formulas.add(Formula(formula: formula, result: result));
  }

  void removeFormula(String formula) {
    formulas.removeWhere((e) => e.formula == formula && e.result == e.result);
  }

  Map toJson() {
    return {'formulas': formulas};
  }

  static FormulasData fromJson(Map json) {
    List<Formula> formulas = [];
    for (var formula in json['formulas']) {
      formulas.add(Formula.fromJson(formula));
    }

    return FormulasData(formulas: formulas);
  }
}

class Formula {
  String formula;
  String result;
  Formula({required this.formula, required this.result});

  Map toJson() {
    return {'formula': formula, 'result': result};
  }

  static Formula fromJson(Map json) {
    return Formula(
        formula: json['formula'] ?? '', result: json['result'] ?? '');
  }
}
