import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';

import 'model/product.dart';

//Add Velocity Constant
const double _kFlingVelocity = 2.0;

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
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }
  //add functions to get and change front layer visibility 
  bool get _frontLayerVisible {
    final status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
  void _toggleBackdropLayerVisibility() {
    _controller.fling(
      velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
    );
  }


  // add override for didUpdateWidget
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  //Add BuildCOntext and BoxCOnstraints parameters to _buildStack
  Widget _buildStack() {
    return Stack(
      key: _backdropKey, 
      children: <Widget>[
      // Wrap BackLayer in an ExcludeSemnatic Widget
      ExcludeSemantics(
        child: widget.backLayer,
        excluding: _frontLayerVisible,
      ),
    
      //add a positonedtransition
      //wrap front layer in _FrontLayer
      _FrontLayer(child: widget.frontLayer),
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
      leading: const Icon(Icons.menu),
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
        //return a lyoutBuilderWidget
        body: _buildStack());
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
