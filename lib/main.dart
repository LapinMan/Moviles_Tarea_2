import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(Tarea_2());

class Tarea_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  //Variables
  double _IMC = 0;

  bool _weightSelected = false;
  bool _heightSelected = false;
  var _weightCol = Colors.grey;
  var _heightCol = Colors.grey;

  var _maleSelected = Colors.grey;
  var _femaleSelected = Colors.grey;
  var _selectedSex = null;

  var _grid_list = [
    "Edad",
    "IMC Ideal",
    "16 - 17",
    "19 - 24",
    "18",
    "19 - 24",
    "19 - 24",
    "19 - 24",
    "25 - 34",
    "20 - 25",
    "35 - 44",
    "21 - 26",
    "45 - 54",
    "22 - 27",
    "55 - 64",
    "23 - 28",
    "65 - 90",
    "25 - 30"
  ];

  late TextEditingController _heightController;
  late TextEditingController _weightController;

  final FocusNode _heightFocusNode = new FocusNode();
  final FocusNode _weightFocusNode = new FocusNode();

  //functions

  _manage_wh_buttons(bool n) {
    //_reset_wh_buttons();
    _turn_off_WH_button(!n);
    if (n == true) {
      _heightSelected = !_heightSelected;
      if (_heightSelected == true) {
        _heightCol = Colors.green;
      } else {
        _heightFocusNode.unfocus();
        _heightCol = Colors.grey;
      }
    } else {
      _weightSelected = !_weightSelected;
      if (_weightSelected == true) {
        _weightCol = Colors.green;
      } else {
        _weightCol = Colors.grey;
        _weightFocusNode.unfocus();
      }
    }
  }

  _turn_off_WH_button(bool n) {
    if (n == true) {
      _heightCol = Colors.grey;
      _heightSelected = false;
      _heightFocusNode.unfocus();
    } else {
      _weightCol = Colors.grey;
      _weightSelected = false;
      _weightFocusNode.unfocus();
    }
  }

  _reset_wh_buttons() {
    _heightSelected = false;
    _heightCol = Colors.grey;
    _heightFocusNode.unfocus();

    _weightSelected = false;
    _weightCol = Colors.grey;
    _weightFocusNode.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  _reset_sex_buttons() {
    _maleSelected = Colors.grey;
    _femaleSelected = Colors.grey;
    _selectedSex = null;
  }

  _male_or_female(bool n) {
    if (n == true) return "hombre";
    return "mujer";
  }

  _manage_sex_colors(bool selected) {
    //Reset Colors
    _reset_sex_buttons();
    //Set Color
    if (selected == true) {
      _maleSelected = Colors.blue;
    } else {
      _femaleSelected = Colors.pink;
    }
    _selectedSex = selected;
  }

  _reset_all() {
    _reset_sex_buttons();
    _reset_wh_buttons();
    _heightController.clear();
    _weightController.clear();
  }

  _any_field_is_empty() {
    if (_selectedSex == null) return true;
    if (_heightController.text == "") return true;
    if (_weightController.text == "") return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calcular IMC"),
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _reset_all();
                });
              },
              icon: Icon(Icons.delete_forever),
              color: Colors.white,
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            const Text("Ingrese sus datos para calcular el IMC",
                style: TextStyle(fontSize: 18)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _manage_sex_colors(true);
                      });
                    },
                    icon: const Icon(Icons.male),
                    color: _maleSelected),
                IconButton(
                    onPressed: () {
                      setState(() {
                        _manage_sex_colors(false);
                      });
                    },
                    icon: const Icon(Icons.female),
                    color: _femaleSelected)
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _manage_wh_buttons(true);
                        _heightFocusNode.requestFocus();
                      });
                    },
                    icon: Icon(
                      Icons.square_foot_rounded,
                      color: _heightCol,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    //Visual
                    style: TextStyle(color: Colors.black),

                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Colors.green)),
                        border: OutlineInputBorder(),
                        labelText: 'Ingresar altura (Metros)',
                        hintText: 'Altura en Metros',
                        labelStyle: TextStyle(
                            color: _heightFocusNode.hasFocus
                                ? Colors.green
                                : Colors.grey)),

                    //Funcional
                    onTap: () {
                      //Aparentemente esto forza un update
                      setState(() {});
                    },
                    controller: _heightController,
                    focusNode: _heightFocusNode,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _manage_wh_buttons(false);
                        _weightFocusNode.requestFocus();
                      });
                    },
                    icon: Icon(
                      Icons.monitor_weight,
                      color: _weightCol,
                    )),
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: TextField(
                    //Visual
                    style: TextStyle(color: Colors.black),

                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 3, color: Colors.green)),
                        border: OutlineInputBorder(),
                        labelText: 'Ingresar peso (KG)',
                        hintText: 'Peso en Kilogramos',
                        labelStyle: TextStyle(
                            color: _weightFocusNode.hasFocus
                                ? Colors.green
                                : Colors.grey)),

                    //Funcional
                    onTap: () {
                      setState(() {});
                    },
                    controller: _weightController,
                    focusNode: _weightFocusNode,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d*'))
                    ],
                  ),
                )
              ],
            ),
            TextButton(
                onPressed: () {
                  if (_any_field_is_empty()) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Text("Error"),
                              content: Text("Alguno de los campos esta vacio"),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 0);
                                    },
                                    child: Text("Volver"))
                              ],
                            ));
                  } else {
                    _IMC = (double.parse(_weightController.text)) /
                        pow(double.parse(_heightController.text), 2);
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Tu IMC: ${_IMC.toStringAsFixed(2)}"),
                                    SizedBox(height: 20),
                                    Text(
                                        "Tabla del IMC para ${_male_or_female(_selectedSex)}",
                                        style: TextStyle(fontSize: 16))
                                  ]),
                              content: Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child: GridView.count(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5,
                                  shrinkWrap: true,
                                  children:
                                      List.generate(_grid_list.length, (index) {
                                    return Text(_grid_list[index]);
                                  }),
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, 1);
                                      setState(() {
                                        //_reset_all();
                                      });
                                    },
                                    child: Text(
                                      "Aceptar",
                                      style: TextStyle(color: Colors.black),
                                    ))
                              ],
                            ));
                  }
                },
                child: const Text("Calcular",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                style: TextButton.styleFrom(primary: Colors.black))
          ],
        ));
  }
}
