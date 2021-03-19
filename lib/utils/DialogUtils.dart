import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

Future alertDialogConfirm(BuildContext context, dynamic message) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appName = packageInfo.appName;
  return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5),
                  child: Text("$appName",
                      style: TextStyle(fontWeight: FontWeight.bold))),
              Divider(
                height: 0.5,
                color: Colors.grey[300],
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  alignment: Alignment.center,
                  child: Text(
                    message.toString(),
                    textAlign: TextAlign.center,
                  )),
              Divider(
                color: Colors.grey,
                height: 4.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(ctx, true);
                },
                splashColor: Colors.transparent,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(32.0)),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32.0)),
                  ),
                  child: Text(
                    "Đồng ý",
                    style: TextStyle(
                        color: Color(0xff007aff),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      )) ??
      false;
}