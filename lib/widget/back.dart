import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackWidget extends StatefulWidget {
  const BackWidget({Key? key}) : super(key: key);

  @override
  _BackWidgetState createState() => _BackWidgetState();
}

class _BackWidgetState extends State<BackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      decoration: const BoxDecoration(
        color: Color(0xffffffff)
      ),
      child: Row(
        children: [
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios)
          ),
          const Text('Artist'),

        ],
      ),
    );
  }
}
