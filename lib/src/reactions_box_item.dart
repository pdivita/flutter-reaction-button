import 'package:flutter/material.dart';
import '../flutter_reaction_button.dart';

class ReactionsBoxItem extends StatefulWidget {
  final Function(Reaction) onReactionClick;

  final Reaction reaction;

  final Color highlightColor;

  final Color splashColor;

  const ReactionsBoxItem({
    Key key,
    @required this.reaction,
    @required this.onReactionClick,
    this.highlightColor,
    this.splashColor,
  }) : super(key: key);

  @override
  _ReactionsBoxItemState createState() => _ReactionsBoxItemState();
}

class _ReactionsBoxItemState extends State<ReactionsBoxItem>
    with TickerProviderStateMixin {
  AnimationController _scaleController;

  Animation<double> _scaleAnimation;

  double _scale = 1;

  @override
  void initState() {
    super.initState();

    // Start animationc
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1));

    final Tween<double> startTween = Tween(begin: 1, end: 1.3);
    _scaleAnimation = startTween.animate(_scaleController)
      ..addListener(() {
        setState(() {
          _scale = _scaleAnimation.value;
          print('scale: $_scale');
        });
      });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: _scale,
      child: InkWell(
        onTap: () {
          //print('ON TAP 3'); // 2
          _scaleController.reverse();
          widget.onReactionClick(widget.reaction);
        },
        onTapDown: (_) {
          //print('ON TAP DOWN 3'); // 1
          _scaleController.forward();
        },
        onTapCancel: () {
          //print('ON TAP CANCEL');
          _scaleController.reverse();
        },
        splashColor: widget.splashColor,
        highlightColor: widget.highlightColor,
        child: widget.reaction.previewIcon,
      ),
    );
  }
}
