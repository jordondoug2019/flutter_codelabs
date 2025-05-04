import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';

import 'model/product.dart';

//Add Velocity Constant
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

  //Add BuildCOntext and BoxCOnstraints parameters to _buildStack
  Widget _buildStack() {
    return Stack(
      key: _backdropKey, children: <Widget>[
      // Wrap BackLayer in an ExcludeSemnatic Widget
      widget.backLayer,
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
      backgroundColor: kShrineSurfaceWhite,
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
          ],));
  }
}
