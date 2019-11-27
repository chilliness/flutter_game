import 'package:flutter/material.dart';

import '../utils/tools.dart';
import '../utils/sudoku.dart';

class Sudoku extends StatefulWidget {
  Sudoku({Key key}) : super(key: key);

  _SudokuState createState() => _SudokuState();
}

class _SudokuState extends State<Sudoku> {
  int level;
  int curNum;
  List<int> btnList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  List<List> resList;
  List<List> dataList;

  @override
  void initState() {
    super.initState();
    handleTap();
  }

  void handleTap([int typeNum = 18]) {
    level = typeNum;
    curNum = 5;

    Map obj = handleInitSD(level);
    resList = obj['res'];
    dataList = obj['data'];
    setState(() {});
  }

  void handleNum(item) {
    item['val'] = curNum;
    handleCheckSD(dataList);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '数独游戏',
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
              crossAxisCount: 3,
              crossAxisSpacing: rpx(context, 4.0),
              mainAxisSpacing: rpx(context, 4.0),
              children: dataList.map((item) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: rpx(context, 2.0),
                    mainAxisSpacing: rpx(context, 2.0),
                    children: item.map((_item) {
                      Color color;
                      switch (_item['type']) {
                        case 1:
                          color = Colors.grey[100];
                          break;

                        case 2:
                          color = Colors.green;
                          break;

                        case 3:
                          color = Colors.red;
                          break;

                        case 4:
                          color = Colors.yellow;
                          break;

                        default:
                          color = Colors.white;
                      }
                      return GestureDetector(
                        onTap:
                            _item['type'] > 0 ? null : () => handleNum(_item),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color,
                          ),
                          child: Text(
                            _item['val'] == 0 ? '' : '${_item['val']}',
                            style: TextStyle(
                              fontSize: rpx(context, 36.0),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: rpx(context, 40.0),
              bottom: rpx(context, 30.0),
            ),
            child: Column(
              children: <Widget>[
                GridView.count(
                  shrinkWrap: true,
                  crossAxisSpacing: rpx(context, 6.0),
                  crossAxisCount: btnList.length,
                  children: btnList.map((item) {
                    return RaisedButton(
                      padding: EdgeInsets.zero,
                      elevation: 0.0,
                      color: curNum == item ? Colors.blue : Colors.grey,
                      onPressed: () {
                        curNum = item;
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '$item',
                          style: TextStyle(
                            fontSize: rpx(context, 36.0),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: rpx(context, 20.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: level == 9 ? null : () => handleTap(9),
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
                      onPressed: level == 18 ? null : () => handleTap(18),
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
                      onPressed: level == 27 ? null : () => handleTap(27),
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
                  height: rpx(context, 10.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () {
                        dataList = List.from(resList);
                        setState(() {});
                      },
                      child: Text(
                        '看答案',
                        style: TextStyle(
                          fontSize: rpx(context, 28.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    RaisedButton(
                      color: Colors.blue,
                      onPressed: () => handleTap(level),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
