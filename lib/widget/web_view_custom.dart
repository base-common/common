import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../core/base_widget.dart';

// File web_view_custom
// @project learning
// @author minhhoang on 10-12-2020
class WebViewCustom extends StatefulWidget {
  final String url;
  final String title;
  final ValueChanged<String> onPageStarted;
  final ValueChanged<String> onPageFinished;

  const WebViewCustom({Key key, this.url, this.title, this.onPageStarted, this.onPageFinished}) : super(key: key);

  @override
  _WebViewCustomState createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

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
                          final webViewController = await _controller.future;
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
            final webViewController = await _controller.future;
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
            child: WebView(
              initialUrl: widget.url,
              javascriptMode: JavascriptMode.unrestricted,
              debuggingEnabled: true,
              gestureRecognizers: Set()..add(Factory(() => VerticalDragGestureRecognizer())),
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              javascriptChannels: <JavascriptChannel>[
                _toasterJavascriptChannel(context),
              ].toSet(),
              onPageStarted: (String url) {
                if (widget.onPageStarted != null) widget.onPageStarted(url);
              },
              onPageFinished: (String url) {
                if (widget.onPageFinished != null) widget.onPageFinished(url);
              },
            ),
          ),
        ));
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
