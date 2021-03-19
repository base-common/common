import 'dart:async';

import 'package:common/common.dart';
import 'package:common/core/base_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// File web_view_custom
// @project tenk
// @author minhhoang on 17-06-2020

typedef OnLoadStart = Function(InAppWebViewController controller, String url);
typedef OnLoadStop = Function(InAppWebViewController controller, String url);

class WebViewInAppCustom extends StatefulWidget {
  final String url;
  final String title;
  final OnLoadStart onLoadStart;
  final OnLoadStop onLoadStop;

  const WebViewInAppCustom({Key key, @required this.url, this.title, this.onLoadStart, this.onLoadStop}) : super(key: key);

  @override
  _WebViewInAppCustomState createState() => _WebViewInAppCustomState();
}

class _WebViewInAppCustomState extends State<WebViewInAppCustom> {
  InAppWebViewController webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.title != null
            ? AppBar(
                elevation: 0.5,
                brightness: Brightness.light,
                backgroundColor: Colors.white,
                title: Text(
                  widget.title,
                  style: TextStyle(color: Colors.black),
                ),
                centerTitle: true,
                leading: ModalRoute.of(context).canPop
                    ? BackAppBar(
                        color: Colors.black,
                        onPressed: () async {
                          final canBack = await webViewController.canGoBack();
                          print(canBack);
                          if (canBack) {
                            webViewController.goBack();
                          } else {
                            Navigator.of(context).pop();
                          }
                        },
                      )
                    : null,
              )
            : null,
        body: WillPopScope(
          onWillPop: () async {
            final canBack = await webViewController.canGoBack();
            print(canBack);
            if (canBack) {
              webViewController.goBack();
            } else {
              Navigator.of(context).pop();
              return Future.value(true);
            }
            return Future.value(false);
          },
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                progress < 1.0 ? LinearProgressIndicator(value: progress) : Container(),
                Expanded(
                  child: InAppWebView(
                    initialUrl: widget.url,
                    gestureRecognizers: Set()..add(Factory(() => PlatformViewVerticalGestureRecognizer())),
                    initialHeaders: {},
                    initialOptions: InAppWebViewGroupOptions(
                        crossPlatform: InAppWebViewOptions(
                            supportZoom: false)),
                    onWebViewCreated: (InAppWebViewController controller) {
                      webViewController = controller;
                    },
                    onLoadStart: (InAppWebViewController controller, String url) async {
                      if (widget.onLoadStart != null) widget.onLoadStart(controller, url);
                    },
                    onLoadStop: (InAppWebViewController controller, String url) async {
                      if (widget.onLoadStop != null) widget.onLoadStop(controller, url);
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress / 100;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class PlatformViewVerticalGestureRecognizer extends VerticalDragGestureRecognizer {
  PlatformViewVerticalGestureRecognizer({PointerDeviceKind kind}) : super(kind: kind);

  Offset _dragDistance = Offset.zero;

  @override
  void addPointer(PointerEvent event) {
    startTrackingPointer(event.pointer);
  }

  @override
  void handleEvent(PointerEvent event) {
    _dragDistance = _dragDistance + event.delta;
    if (event is PointerMoveEvent) {
      final double dy = _dragDistance.dy.abs();
      final double dx = _dragDistance.dx.abs();

      if (dy > dx && dy > kTouchSlop) {
        // vertical drag - accept
        resolve(GestureDisposition.accepted);
        _dragDistance = Offset.zero;
      } else if (dx > kTouchSlop && dx > dy) {
        // horizontal drag - stop tracking
        stopTrackingPointer(event.pointer);
        _dragDistance = Offset.zero;
      }
    }
  }

  @override
  String get debugDescription => 'horizontal drag (platform view)';

  @override
  void didStopTrackingLastPointer(int pointer) {}
}
