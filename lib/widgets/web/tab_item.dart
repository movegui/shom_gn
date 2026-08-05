import 'package:flutter/material.dart';

class TabItem {
  final String title;
  final IconData icon;
  final String routeName;
  final bool enabled;
  TabItem({required this.title, required this.icon, required this.routeName, required this.enabled});
}