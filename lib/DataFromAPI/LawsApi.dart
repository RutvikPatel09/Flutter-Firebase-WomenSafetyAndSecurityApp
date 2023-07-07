import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LawsAPI extends StatefulWidget {
  const LawsAPI({super.key});

  @override
  State<LawsAPI> createState() => _LawsAPIState();
}

class _LawsAPIState extends State<LawsAPI> {
  Future getUserData() async {
    var response = await http
        .get(Uri.https('mocki.io', '/v1/fa6355db-97da-420c-a1a3-f8ec8c593c4f'));
    //https://mocki.io/v1/fa6355db-97da-420c-a1a3-f8ec8c593c4f
    //https://mocki.io/fake-json-api

    var jsonData = jsonDecode(response.body);
    List<Rule> rules = [];

    for (var u in jsonData) {
      Rule user = Rule(u['rule']);
      rules.add(user);
    }
    print(rules.length);
    return rules;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("LAWS"),
          backgroundColor: Color(0xFF80C038),
        ),
        body: Container(
          child: Card(
              child: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(snapshot.data[i].rule),
                      );
                    });
            },
          )),
        ));
  }
}

class Rule {
  final String rule;
  Rule(this.rule);
}
