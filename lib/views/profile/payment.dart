import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sica/views/home/dashboard.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';


class MakePayment extends StatefulWidget {
  const MakePayment({Key? key, required this.url, required this.callBackurl}) : super(key: key);
  final String url;
  final String callBackurl;
  @override
  State<MakePayment> createState() => _MainPageState();
}

class _MainPageState extends State<MakePayment> {
  late WebViewController _controller; // Declare the WebViewController
  bool _isLoading = true; // To track loading state

  bool showFloat = false;
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    loadurl();
    // Initialize the WebViewController and load the URL
  }

  loadurl() {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      WebKitWebViewController(params)
          .setAllowsBackForwardNavigationGestures(true);
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }
    WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..enableZoom(true)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            const LoadingPage();
            // Update loading bar.
          },
          onPageStarted: (String url) {
            if (this.mounted) {
              setState(() {
               // if (widget.url.toString() == widget.url.toString()) {
                  _isLoading = true; // Show loader when page starts loading
               // }
              });
            }
          },
          onPageFinished: (String url) {
            if (this.mounted) {
              setState(() {
                _isLoading = false; // Hide loader when page finishes loading
              });
            }
          },
          onNavigationRequest: (NavigationRequest request) async {
            print("launchaa" + request.url);
            if (request.url.contains("orderStatus=FAILED")) {
              print("FAILED" + request.url);
              //  Navigator.pushReplacement(
              //       context,
              //       MaterialPageRoute(
              //           builder: (BuildContext context) => TransactionStatus(type: 2,)),
                  
              //       );
             // flutter: launchaahttps://www.codingcrown.com/?razorpay_payment_id=pay_N5Ahv1uI5SB3S1&razorpay_payment_link_id=plink_N5Ag0kOnHScGHZ&razorpay_payment_link_reference_id=&razorpay_payment_link_status=paid&razorpay_signature=0cbe8ea4b70489ab4a2829f8a90b26858b198aaf66455e533a06f0e51ed1692d
              return NavigationDecision.prevent;
            } else if (request.url.contains("orderStatus=SUCCESS")) {
                //  Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => TransactionStatus(type: 1,)),
                  
                //     );
              return NavigationDecision.prevent;
            } else if (request.url.startsWith('tel:') ||
                request.url.startsWith('whatsapp:') ||
                request.url.startsWith('fb:') ||
                request.url.startsWith('tg:')) {
              if (await canLaunch(request.url)) {
                await launch(request.url);
              }
              return NavigationDecision.prevent;
            }
            else{
              return NavigationDecision.navigate;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url.toString()));
    _controller = controller;
  }

  DateTime? lastBackPressedTime;

  @override
  Widget build(BuildContext context) {
    return buildWillPopScope();
  }

  int index = 0;
  bool onWillPop = false;
  late DateTime currentBackPressTime;
  buildWillPopScope() {
    return WillPopScope(
      onWillPop: () async {
        if (await _controller.canGoBack()) {
          _controller.goBack();

          return false;
        }
        // Stay App
        else {
          return true;
        }

        // if (await controller.canGoBack()) {
        //   print("onwill goback");
        //   controller.goBack();
        //   return Future.value(true);
        // } else {
        //   print("onwill not");

        //   return Future.value(false);
        // }
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: FloatingActionButton.small(
          shape: const CircleBorder(),
          // isExtended: true,
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
          backgroundColor: Colors.red,
          onPressed: () {
            if (this.mounted) {
              setState(() {
                showFloat = false;
                // context.pushReplacement("/home");
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MyDashBoard(currentIndex: 3,)),
                    ModalRoute.withName(
                        '/') // Replace this with your root screen's route name (usually '/')
                    );
              });
            }
          },
        ),
        body: Stack(
          children: [
            SafeArea(
              child: WebViewWidget(
                controller: _controller,
              ),
            ),
            if (_isLoading)
              const Center(
                child: LoadingPage(), // Loader widget
              ),
          ],
        ),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.red,
        ),
      ),
    );
  }
}
