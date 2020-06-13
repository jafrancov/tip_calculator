import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
    TipCalculator({Key key}) : super(key: key);

    @override
    _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
    double billAmount = 0.00;
    double tipPercentage = 0.00;
    double tip = 0.00;
    double total = 0.00;

    void updateAmounts() {
        setState(() {
            tip = billAmount * tipPercentage / 100.0;
            total = billAmount + tip;
        });
    }

    @override
    Widget build(BuildContext context) {
        TextField txtBillAmount = TextField(
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (String value) {
                try {
                    billAmount = double.parse(value);
                } catch (e) {
                    billAmount = 0;
                }
                updateAmounts();
            },
        );

        TextField txtTipPercentage = TextField(
            decoration: InputDecoration(labelText: "Tip %", hintText: "10"),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            onChanged: (String value) {
                try {
                    tipPercentage = double.parse(value);
                } catch (e) {
                    tipPercentage = 0;
                }
                updateAmounts();
            },
        );

        Container container = Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: <Widget>[txtBillAmount, txtTipPercentage],
            ),
        );

        Center center = Center(
            child: Container(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        Text(
                            "Tip: \$$tip".replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                            style: TextStyle(fontSize: 25.0)),
                        Text(
                            "Total: \$$total".replaceAllMapped(
                                new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},'),
                            style: TextStyle(fontSize: 25.0)),
                    ]),
            ));

        Stack stack = Stack(
            children: <Widget>[container, center],
        );

        AppBar appBar = AppBar(title: Text("Tip Calculator"));
        Scaffold scaffold = Scaffold(appBar: appBar, body: stack);
        return scaffold;
    }
}
