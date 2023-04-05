import 'package:flutter/material.dart';
import '../../../Services/view_helper.dart';
import '../Order/Win_Order.dart';

class NextScreenArguments {
  final List<String> smoothieNames;
  final List<String> snackNames;
  final List<String> addonNames;

  NextScreenArguments({required this.smoothieNames, required this.snackNames, required this.addonNames});
}

class Loading_Order_Win extends StatefulWidget {
  static const String route = '/loading_order';
  @override
  _Loading_Order_WinState createState() => _Loading_Order_WinState();
}

class _Loading_Order_WinState extends State<Loading_Order_Win> {
  late Future<List<String>> _smoothieNames;
  late Future<List<String>> _snackNames;
  late Future<List<String>> _addonNames;

  @override
  void initState() {
    super.initState();
    _smoothieNames = view_helper().get_unique_smoothie_names();
    _snackNames = view_helper().get_snack_names();
    _addonNames = view_helper().get_addon_names();

    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {
    List<String> smoothieNames = await _smoothieNames;
    List<String> snackNames = await _snackNames;
    List<String> addonNames = await _addonNames;

    Navigator.pushReplacementNamed(
      context,
      '/order',
      arguments: NextScreenArguments(
        smoothieNames: smoothieNames,
        snackNames: snackNames,
        addonNames: addonNames,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
