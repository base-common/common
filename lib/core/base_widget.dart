import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseWidget extends StatefulWidget {
  final String title;
  final Color colorTitle;
  final Widget buildTitle;
  final Widget buildBackAppBar;
  final Color colorWidget;
  final Color colorIconBack;
  final Widget bottomNavigationBar;
  final Widget child;
  final Widget floatingActionButton;
  final List<Widget> actions;
  final Color backgroundColorAppbar;
  final Brightness brightness;
  final PreferredSizeWidget bottomAppBar;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final GlobalKey<ScaffoldState> keyScaffold;
  final double elevation;
  final Widget appBar;

  const BaseWidget(
      {Key key,
      this.title,
      this.buildTitle,
      this.buildBackAppBar,
      this.colorWidget,
      @required this.child,
      this.actions,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.backgroundColorAppbar,
      this.floatingActionButtonLocation =
          FloatingActionButtonLocation.centerDocked,
      this.keyScaffold,
      this.bottomAppBar,
      this.brightness,
      this.elevation,
      this.colorTitle,
      this.colorIconBack,
      this.appBar})
      : assert(child != null),
        super(key: key);

  @override
  _BaseWidgetState createState() => _BaseWidgetState();
}

class _BaseWidgetState extends State<BaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.keyScaffold,
      appBar: widget.buildTitle != null || widget.title != null
          ? AppBar(
              elevation: widget.elevation,
              backgroundColor: widget.backgroundColorAppbar,
              title: widget.buildTitle == null
                  ? Text(
                      widget.title,
                      style:
                          TextStyle(color: widget.colorTitle ?? Colors.white),
                    )
                  : widget.buildTitle,
              centerTitle: true,
              leading: ModalRoute.of(context).canPop
                  ? widget.buildBackAppBar == null
                      ? BackAppBar(
                          color: widget.colorIconBack ?? Colors.white,
                        )
                      : widget.buildBackAppBar
                  : null,
              actions: widget.actions,
              brightness: widget.brightness,
              bottom: widget.bottomAppBar,
            )
          : widget.appBar,
      body: Container(
        color: widget.colorWidget,
        constraints: BoxConstraints.expand(),
        child: SafeArea(top: false, bottom: true, child: widget.child),
      ),
      bottomNavigationBar: widget.bottomNavigationBar,
      floatingActionButton: widget.floatingActionButton,
      floatingActionButtonLocation: widget.floatingActionButtonLocation,
    );
  }
}

class BackAppBar extends StatelessWidget {
  final Color color;
  final VoidCallback onPressed;

  const BackAppBar({Key key, this.color, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        highlightColor: Colors.transparent,
        icon: Icon(
          CupertinoIcons.back,
          size: 30,
          color: color,
        ),
        onPressed: onPressed == null
            ? () {
                Navigator.of(context).pop();
              }
            : onPressed);
  }
}
