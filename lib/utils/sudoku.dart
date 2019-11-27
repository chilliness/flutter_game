// 生成随机数组
List<int> handleShuffle(List arr) {
  arr.shuffle();
  return List.from(arr);
}

// 反转数组
void handleReserve(targetArr, newArr) {
  for (int i = 0; i < 9; i++) {
    int y = 0;
    if (i < 3) {
      y = 0;
    } else if (i < 6) {
      y = 3;
    } else {
      y = 6;
    }

    int x = 0;
    if (i % 3 == 0) {
      x = 0;
    } else if (i % 3 == 1) {
      x = 3;
    } else {
      x = 6;
    }
    List arr1 = targetArr[y].sublist(x, x + 3);
    List arr2 = targetArr[y + 1].sublist(x, x + 3);
    List arr3 = targetArr[y + 2].sublist(x, x + 3);
    newArr[i]..addAll(arr1)..addAll(arr2)..addAll(arr3);
  }
}

// 初始化数独
Map<String, List> handleInitSD([level = 9]) {
  // 循环次数
  int count = 0;
  // 基数
  List<int> baseArr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  // 标准数独
  List<List> sdList = List.generate(9, (index) => List(9));
  // 适合组件标准数独
  List<List> gradList = List.generate(9, (index) => List());
  // 使用数据
  List<List> usedList = List.generate(9, (index) => List(9));
  // 答案数组
  List<List> resList = List.generate(9, (index) => List(9));
  // 难度
  int blankNum = 9;

  // 判断难度范围是否合理
  if (level > 8 && level < 55) {
    blankNum = level;
  }

  try {
    // 打乱数组并给出第一行数据
    sdList[0] = handleShuffle(baseArr);
    for (int x = 1; x < 9; x++) {
      // 打乱数据并获取当前数据
      List<int> rowArr = handleShuffle(baseArr);
      for (int y = 0; y < 9; y++) {
        // 获取当前单元格数据
        bool flag = y - 1 > -1;
        int tempNum = flag ? sdList[x][y - 1] : -1;
        rowArr.remove(tempNum);
        // 删除列内重复数字，行内循环中，保持rowArr每次减一个重复数字
        List<int> tempRowArr = handleShuffle(rowArr);
        for (int i = x - 1; i >= 0; i--) {
          tempNum = sdList[i][y];
          tempRowArr.remove(tempNum);
          ++count;
        }

        int posY = y % 3;
        for (int posX = x % 3; posX > 0; posX--) {
          for (int i = 0; i < 3; i++) {
            if (i != posY) {
              tempNum = sdList[x - posX][y - posY + i];
              tempRowArr.remove(tempNum);
              if (++count > 2500) {
                return handleInitSD(level);
              }
            }
          }
        }

        if (tempRowArr.length > 0) {
          sdList[x][y] = tempRowArr[0];
        } else {
          y = -1;
          rowArr = handleShuffle(baseArr);
        }
      }
    }
  } catch (e) {
    print(e);
    handleInitSD(level);
  }

  // 反转生成符合flutter的数组
  handleReserve(sdList, gradList);

  // 生成随机位置
  List tempArr = List.generate(81, (index) => index < blankNum)..shuffle();
  List blankList = [];
  for (int i = 0; i < 81; i += 9) {
    blankList.addAll([tempArr.sublist(i, i + 9)]);
  }

  for (int i = 0; i < gradList.length; i++) {
    var item = gradList[i];
    for (int j = 0; j < item.length; j++) {
      bool flag = blankList[i][j];
      resList[i][j] = {'val': item[j], 'type': flag ? 4 : 1};
      usedList[i][j] = {'val': flag ? 0 : item[j], 'type': flag ? 0 : 1};
    }
  }
  return {'res': resList, 'data': usedList};
}

// 校验数独(type: 0|留空值, 1|初始值, 2|正确, 3|错误, 4|答案)
void handleCheckSD(List<List> sdList) {
  // 满足条件数
  int level = 0;

  // 完整性校验
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      if (sdList[i][j]['val'] == 0) {
        return;
      }
    }
  }

  List newArr = List.generate(9, (index) => List());
  handleReserve(sdList, newArr);

  // 行校验
  for (int i = 0; i < 9; i++) {
    List arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    for (int j = 0; j < 9; j++) {
      var item = newArr[i][j];
      arr.remove(item['val']);
    }

    if (arr.length == 0) {
      level++;
    }
  }

  // 列校验
  for (int i = 0; i < 9; i++) {
    List arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    // 拼数组
    List tempList = List.generate(9, (index) => List());
    for (int j = 0; j < 9; j++) {
      tempList[i].add(newArr[j][i]);
    }

    for (int j = 0; j < 9; j++) {
      var item = tempList[i][j];
      arr.remove(item['val']);
    }

    if (arr.length == 0) {
      level++;
    }
  }

  // 小9宫格校验
  for (int i = 0; i < 9; i++) {
    List arr = [1, 2, 3, 4, 5, 6, 7, 8, 9];
    for (int j = 0; j < 9; j++) {
      arr.remove(sdList[i][j]['val']);
    }

    if (arr.length == 0) {
      level++;
    }
  }

  // 用户答案结果
  for (int i = 0; i < 9; i++) {
    for (int j = 0; j < 9; j++) {
      var item = sdList[i][j];
      if (item['type'] == 0) {
        item['type'] = level == 27 ? 2 : 3;
      }
    }
  }
}
