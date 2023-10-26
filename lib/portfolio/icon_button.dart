import 'package:flutter/material.dart';
import '../res/res.dart';

class PortfolioIconButton extends StatefulWidget {
  final void Function()? onPressed;
  final IconData icon;
  PortfolioIconButton({required this.onPressed, required this.icon});

  @override
  _PortfolioIconButtonState createState() => _PortfolioIconButtonState();
}

class _PortfolioIconButtonState extends State<PortfolioIconButton>
    with SingleTickerProviderStateMixin {
  bool _isHovering = false;
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;
  final borderRadius = BorderRadius.circular(8);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _color1 = ColorTween(
            begin: ThemeColors.textGradients[0],
            end: ThemeColors.textGradients[1])
        .animate(_controller);
    _color2 = ColorTween(
            begin: ThemeColors.textGradients[1],
            end: ThemeColors.highlightGradientColor)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeColors.secondaryBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: widget.onPressed,
        hoverColor: Colors.transparent,
        onHover: (isHovering) {
          setState(() {
            _isHovering = isHovering;
          });
          if (_isHovering) {
            _controller.forward();
          } else {
            _controller.reverse();
          }
        },
        child: AnimatedContainer(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: _isHovering
                ? ThemeColors.secondaryBackgroundColor
                : Colors.transparent,
          ),
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  _color1.value ?? Colors.white,
                  _color2.value ?? Colors.white
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(
                Rect.fromPoints(bounds.topLeft, bounds.bottomRight),
              ),
              child: Icon(widget.icon, size: 20),
            ),
          ),
        ),
      ),
    );
  }
}
