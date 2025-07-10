import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';

class QRDialog extends StatelessWidget {
  final String name;
  final String companyId;
  final String email;

  const QRDialog({
    super.key,
    required this.name,
    required this.companyId,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final qrData = jsonEncode({
      "name": name,
      "companyId": companyId,
      "email": email,
    });

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Fleet Card QR", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200,
              backgroundColor: Colors.white,
            ),
            const SizedBox(height: 10),
            Text(
              "Scan this QR to view fleet card info.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Close"),
            )
          ],
        ),
      ),
    );
  }
}
