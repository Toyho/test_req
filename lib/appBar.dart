import 'package:flutter/material.dart';



class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  var controller;
  var onItemChanged;

  MyCustomAppBar(TextEditingController controller, Function(String value) onItemChanged){
    this.controller = controller;
    this.onItemChanged = onItemChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: TextField(
                onChanged: onItemChanged,
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  labelText: 'Поиск точки обслуживания',
                ),
              )
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);

}