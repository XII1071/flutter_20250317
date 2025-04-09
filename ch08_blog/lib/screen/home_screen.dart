import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _urlController = TextEditingController();
  late final WebViewController _webViewController;
  final String urlHome = "https://chatgpt.com/";

  @override
  void initState() {
    super.initState();
    _webViewController =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageFinished: (String url) {
                print('Loaded: $url');
              },
            ),
          )
          ..loadRequest(Uri.parse(urlHome));
  }

  void _loadUrl() {
    final text = _urlController.text.trim();
    if (text.isNotEmpty) {
      final formattedUrl = text.startsWith('http') ? text : 'https://$text';
      _webViewController.loadRequest(Uri.parse(formattedUrl));
      _urlController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("My Browser"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _webViewController.loadRequest(Uri.parse(urlHome));
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              _webViewController.goBack();
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          IconButton(
            onPressed: () {
              _webViewController.goForward();
            },
            icon: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _urlController,
                    decoration: InputDecoration(
                      hintText: 'Enter URL',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    ),
                    onSubmitted: (_) {
                      _loadUrl();
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(onPressed: _loadUrl, child: Text("Go")),
              ],
            ),
          ),
          Expanded(child: WebViewWidget(controller: _webViewController)),
        ],
      ),
    );
  }
}
