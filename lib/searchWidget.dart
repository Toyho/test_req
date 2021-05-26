import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'appBar.dart';
import 'consts.dart';
import 'member.dart';
import 'strings.dart';

class SearchWidget extends StatefulWidget {
  @override
  createState() => SearchState();
}

class SearchState extends State<SearchWidget> {
  TextEditingController _controller = new TextEditingController();

  void _showToast(String nameOrganization) => Fluttertoast.showToast(
      msg: "Выбрано $nameOrganization", toastLength: Toast.LENGTH_SHORT);

  int _selectedIndex = -1;
  int _selectedId = -1;

  static List<Member> myList = [];

  List<Member> newMyList = List.from(myList);

  final _titleFont =
      const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold);
  final _subtitleFont =
      const TextStyle(fontSize: 15.0, fontStyle: FontStyle.normal);

  onItemChanged(String value) {
    setState(() {
      newMyList = myList
          .where((string) =>
              string.location.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _parseJson();
    onItemChanged("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Consts.heightAppBar),
        child: AppBar(
          centerTitle: true,
          title: Text(
            Strings.appTitle,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.quiz_outlined),
                color: Colors.grey)
          ],
          bottom: MyCustomAppBar(_controller, onItemChanged),
        ),
      ),
      body: ListView.separated(
              itemCount: newMyList.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
              itemBuilder: (BuildContext context, int index) {
                return _buildRow(index);
              },
            ),
      floatingActionButton: Padding(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: SizedBox(
            width: double.infinity,
            height: 65,
            child: FloatingActionButton.extended(
              onPressed: () {
                if (_selectedIndex != -1) {
                  _showToast(myList[_selectedId - 1].name);
                }
              },
              label: const Text(
                Strings.FABText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              backgroundColor: Colors.yellow[600],
              elevation: 0,
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildRow(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: ListTile(
          title: Text("${newMyList[index].name}", style: _titleFont),
          subtitle: Text("${newMyList[index].location}", style: _subtitleFont),
          leading: Stack(
            alignment: Alignment(0.8, 1),
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundColor: newMyList[index].id == _selectedId
                    ? Colors.lightBlue[50]
                    : Colors.grey[200],
                child: Icon(Icons.pin_drop_outlined,
                    color:
                        newMyList[index].placeType ? Colors.blue : Colors.grey,
                    size: 35),
              ),
              CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 12.0,
                  child: CircleAvatar(
                    backgroundColor:
                        newMyList[index].online ? Colors.green : Colors.grey,
                    radius: 10.0,
                    child: Icon(
                      Icons.map_outlined,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  )),
            ],
          ),
          trailing: newMyList[index].id == _selectedId
              ? Icon(
                  Icons.done,
                  color: Colors.blue,
                  size: 24.0,
                )
              : SizedBox(
                  width: 24,
                  height: 24,
                ),
          onTap: () {
            setState(() {
              _selectedId = newMyList[index].id;
              _selectedIndex = index;
            });
          },
        ));
  }

  void _parseJson() async {
    var jsonFile = await DefaultAssetBundle.of(context)
        .loadString("assets/jsonExample.json");
    var decodeJson = json.decode(jsonFile);
    for (int i = 0; i < decodeJson.length; i++) {
      var ccc = Member.fromJson(decodeJson[i]);
      myList.add(ccc);
    }
    setState(() {
      newMyList = List.from(myList);
    });
  }
}
