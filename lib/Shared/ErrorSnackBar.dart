import 'dart:ui';
import 'package:flutter/material.dart';

class SnackbarController {
  OverlayEntry? _overlayEntry;

  // Function to show a temporary error snackbar
  void showTemporaryErrorSnackBar(BuildContext context, String message) {
    // Ensure that no existing overlay entry is displayed
    if (_overlayEntry != null) {
      _overlayEntry!.remove(); // Remove the previous snackbar
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.red, // Background color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlayState.insert(_overlayEntry!);

    // Remove the overlay after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      hideErrorSnackBar(); // Call to remove the snackbar
    });
  }

  // Function to show a permanent error snackbar
  void showPermanentErrorSnackBar(BuildContext context, String message) {
    // Ensure that no existing overlay entry is displayed
    if (_overlayEntry != null) {
      _overlayEntry!.remove(); // Remove the previous snackbar
    }

    OverlayState? overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: SafeArea(
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              color: Colors.red, // Background color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.white),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    overlayState.insert(_overlayEntry!);
  }

  // Function to hide the snackbar
  void hideErrorSnackBar() {
    _overlayEntry?.remove(); // Remove the snackbar if it exists
    _overlayEntry = null; // Clear the overlay entry
  }
}
