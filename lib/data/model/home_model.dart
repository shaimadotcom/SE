import 'package:flutter/cupertino.dart';

class HomeModel {
  final Widget? _child;
  final int? _index;

  get child => _child;
  get index => _index;

  HomeModel(this._child, this._index);
}
