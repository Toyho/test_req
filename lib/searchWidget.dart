import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'appBar.dart';
import 'member.dart';
import 'strings.dart';

class SearchState extends State<SearchWidget> {
  TextEditingController _controller = new TextEditingController();

  void _showToast(String nameOrganization) => Fluttertoast.showToast(
      msg: "Выбрано $nameOrganization", toastLength: Toast.LENGTH_SHORT);

  late int _selectedIndex = -1;
  int _selectedId = -1;

  static List<Member> myList = [
    Member(1, "Бош Авто Сервис Аллигатор",
        "Улица Сурена Шаумяна, дом 47, Москва", false, false),
    Member(2, "Stop&Clean",
        "7-я Кожуховская ул., 9, Москва, (ТРЦ Мозайка, этаж -1)", true, true),
    Member(3, "Клаксон", "Улица К. Либкнехта, дом 2, Архангельск", true, false),
    Member(4, "Мойка и Шиномонтаж 24",
        "Улица Большая Московская, дом 12, Владимир", false, false),
    Member(5, "Революция", "Улица Пушкина, дом 5, Орел", false, false),
  ];
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
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
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
      body: ListView.builder(
          itemCount: newMyList.length * 2,
          itemBuilder: (BuildContext context, int position) {
            if (position.isOdd) return Divider();
            final index = position ~/ 2;
            return _buildRow(index);
          }),
      floatingActionButton: SizedBox(
        width: 390,
        height: 65,
        child: FloatingActionButton.extended(
          onPressed: () {
            if (_selectedIndex != -1) {
              _showToast(myList[_selectedId-1].name);
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
      ),
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

  _loadData() async {
    setState(() {
      final membersJSON = json.decode('assets/jsonExample.json');
      var user = Member.fromJson(membersJSON);
      print(user);
    });
  }

}

class SearchWidget extends StatefulWidget {
  @override
  createState() => SearchState();
}
