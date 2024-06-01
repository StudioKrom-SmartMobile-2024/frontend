import 'dart:async';
import 'package:flutter/material.dart';

/*
! Important disclaimer !
This piece of code was not thought of, designed or created by anyone in the Overload app. 
All credits go to THALLIVA on Github
-> 
*/

class AnyMarqueeSpeed {
  static const double NORMAL_SPEED = 150.0;
}

class MarqueeEffect extends StatefulWidget {
  MarqueeEffect({
    required this.children,
    super.key,
    required this.marginLeft,
    required this.betweenSpacing,
    required this.width,
    required this.height,
    this.speedRate = 1,
    this.scrollFromEnd = true,
    this.delayedStart = const Duration(seconds: 0),
  });

  double marginLeft;
  double betweenSpacing;
  final List<Widget> children;
  double width;
  double height;
  final double speedRate;
  bool scrollFromEnd;
  Duration delayedStart;

  @override
  _MarqueeEffectState createState() => _MarqueeEffectState();
}

class _MarqueeEffectState extends State<MarqueeEffect> {
  late Timer _anyMarqueeTimer;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(initialScrollOffset: 1000);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(widget.delayedStart);
      startTimer();
    });
  }

  void startTimer() {
    _anyMarqueeTimer = Timer.periodic(Duration(microseconds: 16), (timer) {
      if (_scrollController.hasClients) {
        final distance = _scrollController.offset;
        _scrollController.jumpTo(
            distance + (1 / AnyMarqueeSpeed.NORMAL_SPEED) * widget.speedRate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNotificationInterceptor(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final biggestWidth = constraints.biggest.width;
          final biggestHeight = constraints.biggest.height;
          widget.marginLeft =
              widget.marginLeft != 0 ? widget.marginLeft : biggestWidth;
          widget.betweenSpacing =
              widget.betweenSpacing != 0 ? widget.betweenSpacing : biggestWidth;
          widget.width = widget.width != 0 ? widget.width : biggestWidth;
          widget.height = widget.height != 0 ? widget.height : biggestHeight;

          return Container(
            width: widget.width,
            height: widget.height,
            alignment: Alignment.center,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: double.maxFinite.toInt(),
              itemBuilder: (context, index) {
                final childIndex = index % widget.children.length;
                final distance =
                    (index == 0 ? widget.marginLeft : widget.betweenSpacing);
                return Container(
                  padding: EdgeInsets.only(
                      left: widget.scrollFromEnd ? distance : 0),
                  alignment: Alignment.center,
                  child: widget.children[childIndex],
                );
              },
              controller: _scrollController,
              physics: NeverScrollableScrollPhysics(),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _anyMarqueeTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}

class ScrollNotificationInterceptor extends StatelessWidget {
  final Widget child;

  ScrollNotificationInterceptor({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        return true;
      },
      child: this.child,
    );
  }
}
