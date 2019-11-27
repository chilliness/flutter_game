import 'package:flutter/material.dart';

import './utils/tools.dart';
import './pages/schulte.dart';
import './pages/sudoku.dart';

void main() {
  handleForceVertical();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '益智游戏',
      home: JumpLink(),
    );
  }
}

class JumpLink extends StatelessWidget {
  const JumpLink({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '首页',
          style: TextStyle(
            fontSize: rpx(context, 36.0),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              padding: EdgeInsets.zero,
              color: Colors.blue,
              onPressed: () => push(context, Schulte()),
              child: Container(
                width: rpx(context, 200.0),
                height: rpx(context, 200.0),
                alignment: Alignment.center,
                child: Text(
                  '方格游戏',
                  style: TextStyle(
                    fontSize: rpx(context, 32.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: rpx(context, 20.0),
              height: rpx(context, 20.0),
            ),
            RaisedButton(
              padding: EdgeInsets.zero,
              color: Colors.blue,
              onPressed: () => push(context, Sudoku()),
              child: Container(
                width: rpx(context, 200.0),
                height: rpx(context, 200.0),
                alignment: Alignment.center,
                child: Text(
                  '数独游戏',
                  style: TextStyle(
                    fontSize: rpx(context, 32.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
