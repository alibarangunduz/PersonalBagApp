
import 'package:flutter/material.dart';
import 'package:mybagapp/src/services/coins_service.dart';

class AddCoin extends StatefulWidget {
  AddCoin({Key key}) : super(key: key);

  @override
  _AddCoinState createState() => _AddCoinState();
}

class _AddCoinState extends State<AddCoin> {
  List<String> coins = [
    "bitcoin",
    "tether",
    "ethereum",
  ];

  String selectedCoin = "bitcoin";
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text('Add Currency'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(

              value: selectedCoin,
              onChanged: (String x) {
                setState(() {
                  selectedCoin = x;
                });
              },
              items: coins.map<DropdownMenuItem<String>>((String x) {
                return DropdownMenuItem<String>(
                  value: x,
                  child: Text(x),
                );
              }).toList(),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: "Coin Amount",
                ),
              ),
            ),
            SizedBox(
              width: 11,
              height: 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white24,
                boxShadow: null
              ),
              child: MaterialButton(
                onPressed: () async {
                  await addCoin(selectedCoin, _amountController.text);
                  Navigator.of(context).pop();
                },

                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}