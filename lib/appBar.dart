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
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          children: [
            Container(
              color: Colors.white,
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
          ],
        ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

}