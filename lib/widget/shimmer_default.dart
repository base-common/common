import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerDefault extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrain) {
        var maxHeight = constrain.maxHeight.isInfinite
            ? constrain.maxWidth
            : constrain.maxHeight;
        var maxWidth = constrain.maxWidth.isInfinite
            ? constrain.maxHeight
            : constrain.maxWidth;
        var ratio = maxHeight / maxWidth;
        var heightRect;
        var widthRect;
        if (ratio > 1) {
          heightRect = maxWidth / 2.5;
          widthRect = heightRect;
        } else {
          heightRect = maxHeight / 2.5;
          widthRect = heightRect;
        }
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: maxHeight, maxWidth: maxWidth),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white,
                )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: widthRect,
                      height: heightRect,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: heightRect / 3.5,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: double.infinity,
                            height: heightRect / 3.5,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Container(
                            width: heightRect / 2,
                            height: heightRect / 3.5,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  color: Colors.white,
                )),
              ],
            ),
          ),
        );
      },
    );
  }
}

final shimmerApp = Shimmer.fromColors(
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[400],
    child: ShimmerDefault()
);
