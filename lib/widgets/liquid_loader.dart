import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';


class LoadLiquid extends StatefulWidget {
  @override
  _LoadLiquidState createState() => new _LoadLiquidState();
}

class _LoadLiquidState extends State<LoadLiquid> {
  @override
  Widget build(BuildContext context) {
    return new FlareActor("images/liquid_loader.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"load");
  }
}