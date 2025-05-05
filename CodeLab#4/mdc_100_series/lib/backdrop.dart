import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';

import 'model/product.dart';

//Add Velocity Constant
const double _kFlingVelocity = 0.5;

//created backdrop widget
class Backdrop extends StatefulWidget {
  final Category currentCategory;
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const Backdrop({
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(key: key);

  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<Backdrop>
    with SingleTickerProviderStateMixin {
  final GlobalKey _backdropKey = GlobalKey(debugLabel: 'Backdrop');

  //Add AnimationController Widget
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      value: 1.0,
      vsync: this,
    );
    _controller.addListener(() {
      print("Animation Status: ${_controller.status}");
    });
  }

  //add functions to get and change front layer visibility
  bool get _frontLayerVisible {
    final status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  void _toggleBackdropLayerVisibility() {
    print("Backdrop visibility tiggled!");
    setState(() {
      _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
      );
    });
  }

  // add override for didUpdateWidget
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Build Stack Widget

  //Add BuildCOntext and BoxCOnstraints parameters to _buildStack
  Widget _buildStack(BuildContext contect, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height - layerTitleHeight;
    final double layerBottom = layerTop + layerSize.height;

    // Debug print statements
    print("Layer Size: $layerSize");
    print("Layer Top: $layerTop");

    //Create A relativerectween animation
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, layerTop, 0.0, layerBottom),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(_controller.view);
    //print out the current vlaues to help debug
    layerAnimation.addListener(() {
      print("Animation Value: ${layerAnimation.value}");
    });
    return Stack(key: _backdropKey, children: <Widget>[
      // Wrap BackLayer in an ExcludeSemnatic Widget
      ExcludeSemantics(
        child: widget.backLayer,
        excluding: _frontLayerVisible,
      ),
      //add a positioned transition
      PositionedTransition(
          rect: layerAnimation,
          child: _FrontLayer(
            child: widget.frontLayer,
          )),
      //wrap front layer in _FrontLayer
  
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      backgroundColor: kShrinePink100,
      //Replace leading menu icon with IconButton
      // remove leading property
      //create title with _BackdropTitle param
      //replace leading menu icon with IconButton
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: _toggleBackdropLayerVisibility,
      ),
      title: const Text('SHRINE'),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.search,
            semanticLabel: 'search',
          ),
          onPressed: () {
            //Add Open Login
          },
        ),
      ],
    );
    return Scaffold(
        appBar: appBar,
        //return a layoutBuilderWidget
        body: LayoutBuilder(
          builder:  _buildStack,
          )
        );
  }
}

//Add _frontLayer class

class _FrontLayer extends StatelessWidget {
  //add on tap callback
  const _FrontLayer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 16.0,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(46.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Add a gesture dector
            Expanded(
              child: child,
            )
          ],
        ));
  }
}
