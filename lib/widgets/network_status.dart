import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'dart:async';
import 'dart:developer' as developer;

import 'package:flutter/services.dart';

class NetworkStatus extends StatefulWidget {
  const NetworkStatus({super.key});

  @override
  State<NetworkStatus> createState() => _NetworkStatusState();
}

class _NetworkStatusState extends State<NetworkStatus> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('Connectivity changed: $_connectionStatus');
  }

  void _showConnectivitySnackBar(ConnectivityResult result) {
    String message;
    Color backgroundColor;

    switch (result) {
      case ConnectivityResult.wifi:
        message = 'Connected to WiFi';
        backgroundColor = Colors.green;
        break;
      case ConnectivityResult.mobile:
        message = 'Connected to Mobile Network';
        backgroundColor = Colors.green;
        break;
      case ConnectivityResult.none:
        message = 'No Internet Connection';
        backgroundColor = Colors.red;
        break;
      default:
        message = 'Unknown Network Status';
        backgroundColor = Colors.orange;
    }

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      duration: Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Plus Example'),
        elevation: 4,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Spacer(flex: 2),
          Text(
            'Active connection types:',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Spacer(),
          ListView(
            shrinkWrap: true,
            children: List.generate(
                _connectionStatus.length,
                (index) => Center(
                      child: Text(
                        _connectionStatus[index].toString(),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    )),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
