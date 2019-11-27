import 'dart:async';
import 'package:flutter/material.dart';

import '../utils/tools.dart';

class Schulte extends StatefulWidget {
  Schulte({Key key}) : super(key: key);

  _SchulteState createState() => _SchulteState();
}

class _SchulteState extends State<Schulte> with TickerProviderStateMixin {
  int total = 9;
  int lastVal = 0;
  double time = 0.0;
  bool isOver = false;
  Timer timer;
  List<int> dataList = [];
  List<AnimationController> listCtrl = List<AnimationController>();
  List<Animation<Color>> listAnim = List<Animation<Color>>();

  @override
  void initState() {
    super.initState();
    handleSetup();
  }

  @override
  void dispose() {
    timer?.cancel();
    listCtrl.forEach((item) => item.dispose());
    super.dispose();
  }

  void handleSetup([int type = 16]) {
    timer?.cancel();
    total = type;
    lastVal = 0;
    time = 0.0;
    isOver = false;
    dataList = [];
    listCtrl = [];
    listAnim = [];
    List.generate(total, (index) {
      dataList.add(index + 1);
      listCtrl.add(AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 500,
        ),
      ));
      listAnim.add(ColorTween(
        begin: Colors.white,
        end: Colors.green,
      ).animate(listCtrl[index])
        ..addListener(() => setState(() {})));
    });
    dataList.shuffle();
    setState(() {});
  }

  void handleTap(int index) {
    bool flag = dataList[index] == lastVal + 1;
    Color color = flag ? Colors.green : Colors.red;
    if (flag) {
      lastVal = dataList[index];
      if (lastVal == 1) {
        const duration = Duration(
          milliseconds: 100,
        );
        timer = Timer.periodic(duration, (timer) {
          time += 0.1;
          setState(() {});
        });
      } else if (lastVal == total) {
        timer?.cancel();
        isOver = true;
      }
    }
    listAnim[index] = ColorTween(
      begin: Colors.white,
      end: color,
    ).animate(listCtrl[index])
      ..addListener(() => setState(() {}));
    listCtrl[index].forward().then((_) => listCtrl[index].reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '舒尔特方格',
          style: TextStyle(
            fontSize: rpx(context, 36.0),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(rpx(context, 4.0)),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: total == 9 ? 3 : (total == 16 ? 4 : 5),
              crossAxisSpacing: rpx(context, 4.0),
              mainAxisSpacing: rpx(context, 4.0),
              children: List.generate(dataList.length, (index) {
                return GestureDetector(
                  onTap: isOver ? null : () => handleTap(index),
                  child: Container(
                    child: Text(
                      '${dataList[index]}',
                      style: TextStyle(fontSize: rpx(context, 60.0)),
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: listAnim[index].value,
                    ),
                  ),
                );
              }),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: rpx(context, 30.0),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  !isOver
                      ? time.toStringAsFixed(1)
                      : '本次耗时 ${time.toStringAsFixed(1)} 秒',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: rpx(context, 48.0),
                  ),
                ),
                SizedBox(
                  height: rpx(context, 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: total == 9 ? null : () => handleSetup(9),
                      child: Text(
                        '简单',
                        style: TextStyle(
                          fontSize: rpx(context, 28.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: total == 16 ? null : () => handleSetup(16),
                      child: Text(
                        '普通',
                        style: TextStyle(
                          fontSize: rpx(context, 28.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: total == 25 ? null : () => handleSetup(25),
                      child: Text(
                        '困难',
                        style: TextStyle(
                          fontSize: rpx(context, 28.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: rpx(context, 20.0),
                ),
                RaisedButton(
                  color: Colors.blue,
                  onPressed: () => handleSetup(total),
                  child: Text(
                    '换一局',
                    style: TextStyle(
                      fontSize: rpx(context, 28.0),
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
