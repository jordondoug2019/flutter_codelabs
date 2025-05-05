import 'package:flutter/material.dart';
import 'package:shrine/colors.dart';

import 'model/product.dart';

//Backdrop appears behind all other content and components.
//It is composed of 2 layers: -BackLayer(Displays actions and filters) -frontLayer(Displays content)
//Use a Backdrop to display interactive information and actions, such as Navigation or content filters
//Add Velocity Constant
//Velocity represents the speed and direction of movement
//typicaaly used in gesture-driven animations and scroll physics.
const double _kFlingVelocity = 0.5;

//created backdrop widget
//Stateful Widget: Can change overt time (UI may update based on interaction or data changes.)
class Backdrop extends StatefulWidget {
  //Parameters passed into the widget
  final Category currentCategory; //Controls which caregory of data is shown
  final Widget
      frontLayer; //Widget shown in the foreground (like a product list)
  final Widget backLayer; //Widget in the background (like a category menu)
  final Widget frontTitle; // Title displayed when front layer is visible
  final Widget backTitle; //Title displayed when back layer is visible

//The constructor: creates and initalize an objcct when its first created.
  const Backdrop({
    //Const makes the widget instance immutavle and compile-time constant when possible
    required this.currentCategory,
    required this.frontLayer,
    required this.backLayer,
    required this.frontTitle,
    required this.backTitle,
    Key? key,
  }) : super(
            key:
                key); //Passes the key to the superclass (StatefulWIdget), useful for widget identity

//Ties the widget to a _BackdrpState class, where all the interactive logic will be implemented
//like showing/hiding the front layer
  @override
  _BackdropState createState() => _BackdropState();
}

class _BackdropState extends State<
        Backdrop> //State object for the Backdrop widget (defined earlier)
    with
        SingleTickerProviderStateMixin {
  //allows the class to act as a ticker provider for animations- specifically for the ANimation COntroller
  final GlobalKey _backdropKey = GlobalKey(
      debugLabel:
          'Backdrop'); //Globalkey gives access to the widget tree for actions like measuring size or identifying widgets uniquely

  //Add AnimationController Widget
  late AnimationController
      _controller; //Controls the animation of the front layer sliding up/down

  @override
  void initState() {
    //Initializing the Animation
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      value: 1.0, //Animates a value from 0.0 to 1.0 (used in transitions)
      vsync:
          this, //Reduces unneccasry rendering using SingleTickerProviderStateMixin
    );
    _controller.addListener(() {
      print(
          "Animation Status: ${_controller.status}"); //logs the status of the animation when it changes
    });
  }

  //add functions to get and change front layer visibility
  //Checks whether the front layer is currently visible or becoming visible.
  bool get _frontLayerVisible {
    final status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
//toggle layer visibility

  void _toggleBackdropLayerVisibility() {
    print("Backdrop visibility tiggled!");
    setState(() {
      //Fling- simulates a physical spring-like motion, allowing an animation to smoothly continue from a defined velocity
      //after the user initates a drag or fling gesture
      _controller.fling(
        velocity: _frontLayerVisible ? -_kFlingVelocity : _kFlingVelocity,
      );
    });
  }

  // add override for didUpdateWidget
  //will be called whenever the widget configuration changes function in _BackdropState
  @override
  void didUpdateWidget(Backdrop old) {
    super.didUpdateWidget(old);

    if (widget.currentCategory != old.currentCategory) {
      _toggleBackdropLayerVisibility();
    } else if (!_frontLayerVisible) {
      _controller.fling(velocity: _kFlingVelocity);
    }
  }

  //disposed the controler when the widget is removed from the tree to free memory
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //Build Stack Widget

  //Add BuildCOntext and BoxCOnstraints parameters to _buildStack
  //LayoutBuilder calls this to dynamically lay out the widget tree based on screen size
  //_BuildStack() is the UI Layers
  Widget _buildStack(BuildContext contect, BoxConstraints constraints) {
    const double layerTitleHeight = 48.0;
    final Size layerSize = constraints.biggest;
    final double layerTop = layerSize.height -
        layerTitleHeight; //Define the start point for the animation
    final double layerBottom =
        layerTop + layerSize.height; //Define the end points for the animation

    // Debug print statements
    print("Layer Size: $layerSize");
    print("Layer Top: $layerTop");

    //Create A relativerectween animation
    Animation<RelativeRect> layerAnimation = RelativeRectTween(
      //RelativeRectTween: Defines the slide animation
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
          //uses this to animate the front layer
          rect: layerAnimation,
          child: _FrontLayer(
            onTap: _toggleBackdropLayerVisibility,
            child: widget.frontLayer,
          )),
      //wrap front layer in _FrontLayer
    ]);
  }

//Main UI
//Builds an Appbar w/a menu button that toggles the front layer
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
          //used to layout the backdrop layers using _buildStack
          builder: _buildStack,
        ));
  }
}

//Add _frontLayer widget
//Important for visual appearance and elevation
//Used to add a cut in the upper left corner
class _FrontLayer extends StatelessWidget {

  //add on tap callback
  //  final VoidCallback? onTap;
  const _FrontLayer({
    Key? key,
    this.onTap,
    required this.child,
  }) : super(key: key);
//on-tap callback to the backdrop layer
  final VoidCallback? onTap;
  final Widget child;

//Uswed BeveledRectangleBorder and Expanded to stretch the child widget
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
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: Container (
                height: 40.0,
                alignment: AlignmentDirectional.centerStart,
              ),
            ),
            Expanded(
              child: child,
            )
          ],
        ));
  }
}
