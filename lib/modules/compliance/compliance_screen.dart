import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuellogic/config/extension/space_extension.dart';
import 'package:fuellogic/core/constant/app_colors.dart';
import 'package:fuellogic/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ComplianceScreen extends StatefulWidget {
  const ComplianceScreen({super.key});

  @override
  State<ComplianceScreen> createState() => _ComplianceScreenState();
}

class _ComplianceScreenState extends State<ComplianceScreen> {
  static const _privacyAsset = 'assets/html/fuelogic-privacy-policy.html';
  static const _termsAsset = 'assets/html/fuelogic-terms-conditions.html';

  int _selectedIndex = 0;
  late final WebViewController _webViewController;
  bool _isLoading = true;
  String? _htmlContent;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) => setState(() => _isLoading = false),
        ),
      );
    _loadHtml(_privacyAsset);
  }

  Future<void> _loadHtml(String assetPath) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final content = await rootBundle.loadString(assetPath);
      _htmlContent = content;
      _webViewController.loadHtmlString(content);
    } catch (e) {
      debugPrint('Error loading HTML: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isSimple: true,
        title: 'Legal Documents',
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                _tabButton('Privacy Policy', 0),
                const SizedBox(width: 8),
                _tabButton('Terms & Conditions', 1),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: Stack(
              children: [
                WebViewWidget(controller: _webViewController),
                if (_isLoading) ...[
                  const Center(child: CircularProgressIndicator()),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabButton(String title, int index) {
    final isSelected = index == _selectedIndex;
    return Expanded(
      child: InkWell(
        onTap: () {
          if (_selectedIndex != index) {
            setState(() => _selectedIndex = index);
            _loadHtml(index == 0 ? _privacyAsset : _termsAsset);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor.withCustomOpacity(0.4) : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppColors.primaryColor.withCustomOpacity(0.4) : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.black : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
