import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';

class ConnectivityWrapper extends StatefulWidget {
  const ConnectivityWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  bool _isConnected = true;
  Timer? _timer;
  bool _dialogShown = false;

  @override
  void initState() {
    super.initState();
    // Delay first check to ensure Navigator is available
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) _checkConnectivity();
    });
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (mounted) _checkConnectivity();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 3));
      final connected = result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      if (mounted) {
        final wasDisconnected = !_isConnected;
        setState(() {
          _isConnected = connected;
        });

        if (!connected && !_dialogShown) {
          _showNoConnectionDialog();
        } else if (connected && wasDisconnected) {
          _dialogShown = false;
        }
      }
    } on SocketException catch (_) {
      if (mounted) {
        setState(() {
          _isConnected = false;
        });
        if (!_dialogShown) {
          _showNoConnectionDialog();
        }
      }
    } on TimeoutException catch (_) {
      if (mounted) {
        setState(() {
          _isConnected = false;
        });
        if (!_dialogShown) {
          _showNoConnectionDialog();
        }
      }
    }
  }

  void _showNoConnectionDialog() {
    // Check if we have a valid navigator context
    final navigator = Navigator.maybeOf(context);
    if (navigator == null) {
      // No Navigator available yet, just show the banner
      return;
    }

    _dialogShown = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 64,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            const Text(
              'لا يوجد اتصال بالإنترنت',
              style: TextStyles.bold16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'يرجى التحقق من اتصالك بالإنترنت والمحاولة مرة أخرى',
              style: TextStyles.regular13,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _dialogShown = false;
                  _checkConnectivity();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text(
                  'إعادة المحاولة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (!_isConnected)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off, color: Colors.white, size: 16),
                      SizedBox(width: 8),
                      Text(
                        'لا يوجد اتصال بالإنترنت',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
