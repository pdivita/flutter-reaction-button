import 'package:flutter/material.dart';
import 'reactions_position.dart';
import 'reactions_box.dart';
import 'reaction.dart';
import 'utils.dart';

class FlutterReactionButton extends StatefulWidget {
  /// This triggers when reaction button value changed.
  final Function(Reaction, int) onReactionChanged;

  /// Default reaction button widget
  final Reaction initialReaction;

  final List<Reaction> reactions;

  final Color highlightColor;

  final Color splashColor;

  /// Position reactions box for the button [default = TOP]
  final Position boxPosition;

  /// Reactions box color [default = white]
  final Color boxColor;

  /// Reactions box elevation [default = 5]
  final double boxElevation;

  /// Reactions box radius [default = 50]
  final double boxRadius;

  /// Reactions box show/hide duration [default = 200 milliseconds]
  final Duration boxDuration;

  FlutterReactionButton({
    Key key,
    @required this.onReactionChanged,
    @required this.reactions,
    this.initialReaction,
    this.highlightColor,
    this.splashColor,
    this.boxPosition = Position.TOP,
    this.boxColor = Colors.white,
    this.boxElevation = 5,
    this.boxRadius = 50,
    this.boxDuration = const Duration(milliseconds: 1),
  })  : assert(reactions != null),
        super(key: key);

  @override
  _FlutterReactionButtonState createState() => _FlutterReactionButtonState();
}

class _FlutterReactionButtonState extends State<FlutterReactionButton> {
  final GlobalKey _buttonKey = GlobalKey();

  Reaction _selectedReaction;

  _FlutterReactionButtonState();

  @override
  void initState() {
    super.initState();
    _selectedReaction = widget.initialReaction;
  }

  @override
  Widget build(BuildContext context) => InkWell(
        key: _buttonKey,
        highlightColor: widget.highlightColor,
        splashColor: widget.splashColor,
        onTap: () => _showReactionButtons(context),
        child: (_selectedReaction ?? widget.reactions[0]).icon,
      );

  void _showReactionButtons(BuildContext context) async {
    final buttonOffset = Utils.getButtonOffset(_buttonKey);
    final buttonSize = Utils.getButtonSize(_buttonKey);
    final reactionButton = await Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        transitionDuration: Duration(milliseconds: 200),
        pageBuilder: (context, _, __) => ReactionsBox(
              buttonOffset: buttonOffset,
              buttonSize: buttonSize,
              reactions: widget.reactions,
              position: widget.boxPosition,
              color: widget.boxColor,
              elevation: widget.boxElevation,
              radius: widget.boxRadius,
              duration: widget.boxDuration,
              highlightColor: widget.highlightColor,
              splashColor: widget.splashColor,
            )));
    if (reactionButton != null) {
      _updateReaction(reactionButton);
    }
  }

  void _updateReaction(Reaction reaction) {
    final selectedIndex = widget.reactions.indexOf(reaction);
    widget.onReactionChanged(reaction, selectedIndex);
    setState(() {
      _selectedReaction = reaction;
    });
  }
}
