import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double sw(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double sh(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double st(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

double rpx(BuildContext context, double val) {
  return sw(context) / 750 * val;
}

void handleForceVertical() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

void push(BuildContext context, Widget wgt) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => wgt));
}
