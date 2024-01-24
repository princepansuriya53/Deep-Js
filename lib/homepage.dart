import 'dart:convert';
import 'package:api_calls/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<UserData> userDetails = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Data'),
      ),
      body: FutureBuilder(
          future: getdata(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: userDetails.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        gettext(
                            index, "id:-", userDetails[index].id.toString()),
                        gettext(index, "Username:-",
                            userDetails[index].username.toString()),
                        gettext(index, "name:-",
                            userDetails[index].name.toString()),
                        gettext(index, "Email:-",
                            userDetails[index].email.toString()),
                        gettext(index, "phone:-",
                            userDetails[index].phone.toString()),
                        gettext(index, "company:-",
                            "${userDetails[index].company.toString()}${userDetails[index].company.name.toString()}${userDetails[index].company.catchPhrase.toString()}"),
                        gettext(index, "Site:-",
                            userDetails[index].website.toString()),
                        gettext(index, "Address:-",
                            "${userDetails[index].address.suite.toString()},${userDetails[index].address.street.toString()},${userDetails[index].address.city.toString()}-${userDetails[index].address.zipcode.toString()}"),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator.adaptive());
            }
          }),
    );
  }

  Text gettext(int index, String filedname, String content) {
    return Text.rich(TextSpan(
      children: [
        TextSpan(
            text: filedname,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        TextSpan(text: content, style: const TextStyle(fontSize: 16)),
      ],
    ));
  }

  Future<List<UserData>> getdata() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        userDetails.add(UserData.fromMap(index));
      }
      return userDetails;
    } else {
      return userDetails;
    }
  }
}
