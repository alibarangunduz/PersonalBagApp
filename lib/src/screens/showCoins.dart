import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mybagapp/src/services/api_methods.dart';
import 'addCoins.dart';


class ShowCoins extends StatefulWidget {
  ShowCoins({Key key}) : super(key: key);

  @override
  _ShowCoinsState createState() => _ShowCoinsState();
}

class _ShowCoinsState extends State<ShowCoins> {
  double bitcoin = 0.0;
  double ethereum = 0.0;
  double tether = 0.0;

  @override
  // ignore: must_call_super
  initState() {
    updateValues();
  }

  updateValues() async {
    bitcoin = await getUsdPrice("bitcoin");
    ethereum = await getUsdPrice("ethereum");
    tether = await getUsdPrice("tether");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    getValue(String id, double amount) {
      if (id == "bitcoin") {
        return (bitcoin * amount).toStringAsFixed(2);
      } else if (id == "ethereum") {
        return (ethereum * amount).toStringAsFixed(2);
      } else {
        return (tether * amount).toStringAsFixed(2);
      }
    }

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        title: const Text('Coins Amount'),
      ),
      body: Container(

        decoration: BoxDecoration(
          color: Colors.white54,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('Coins')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(

                  children: snapshot.data.docs.map((doc) {
                    return Container(

                        child: Row(

                          children: [
                            SizedBox(
                              width: 10,
                              height: 10,
                            ),
                            Text("Coin: ${doc.id}"),
                            Text(
                                "Price: ${getValue(doc.id, doc.data()['Amount'])}"),
                          ],
                        ));
                  }).toList(),
                );
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCoin(),
            ),
          );
        },
        backgroundColor: Colors.black,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}