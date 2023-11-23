import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:raymondrealty/cp_apis/controllers/generate_invoice_controller.dart';
import 'package:raymondrealty/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../components/widgets.dart';


class DownloadFilePage extends StatefulWidget {
  final String? link, invoiceNo;

  DownloadFilePage(this.link, this.invoiceNo);

  @override
  _DownloadFilePageState createState() => new _DownloadFilePageState();
}

class _DownloadFilePageState extends State<DownloadFilePage> {

  final GlobalKey webViewKey = GlobalKey();
  GenerateInvoiceController generateInvoiceController = GenerateInvoiceController.to;

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,

      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  TextEditingController cancelReason = TextEditingController();
  Future<bool> _showPopup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Please the reason for cancellation'),
        content: Form(
          key: _formKey,
          child: MyWidgets.textFormFields(cancelReason,
              TextInputType.text,
              false.obs,
              false,
              'Cancel reason'
          ),
        ),
        actions:[
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
            child:const Text('Cancel',style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            onPressed: () {
              if(_formKey.currentState!.validate()){
                generateInvoiceController.submitInvoice(
                    widget.invoiceNo.toString(),
                    'CANCEL', widget.link.toString(),
                    cancelReason.text
                );
              }
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
            child:const Text('Continue',style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    )??false; //if showDialog had returned null, then return false
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Tax Invoice',)),
        body: SafeArea(
            child: Column(children: [
              // TextField(
              //   decoration: InputDecoration(
              //       prefixIcon: Icon(Icons.search)
              //   ),
              //   controller: urlController,
              //   keyboardType: TextInputType.url,
              //   onSubmitted: (value) {
              //     var url = Uri.parse(value);
              //     if (url.scheme.isEmpty) {
              //       url = Uri.parse("https://www.google.com/search?q=" + value);
              //     }
              //     webViewController?.loadUrl(
              //         urlRequest: URLRequest(url: url));
              //   },
              // ),
              Expanded(
                child: Stack(
                  children: [
                    InAppWebView(
                      key: webViewKey,
                      initialUrlRequest:
                      URLRequest(url: Uri.parse(widget.link.toString())),
                      initialOptions: options,
                      pullToRefreshController: pullToRefreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      onLoadStart: (controller, url) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      androidOnPermissionRequest: (controller, origin, resources) async {
                        return PermissionRequestResponse(
                            resources: resources,
                            action: PermissionRequestResponseAction.GRANT);
                      },
                      shouldOverrideUrlLoading: (controller, navigationAction) async {
                        var uri = navigationAction.request.url!;

                        if (![ "http", "https", "file", "chrome",
                          "data", "javascript", "about"].contains(uri.scheme)) {
                          if (await canLaunch(url)) {
                            // Launch the App
                            await launch(
                              url,
                            );
                            // and cancel the request
                            return NavigationActionPolicy.CANCEL;
                          }
                        }

                        return NavigationActionPolicy.ALLOW;
                      },
                      onLoadStop: (controller, url) async {
                        pullToRefreshController.endRefreshing();
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onLoadError: (controller, url, code, message) {
                        pullToRefreshController.endRefreshing();
                      },
                      onProgressChanged: (controller, progress) {
                        if (progress == 100) {
                          pullToRefreshController.endRefreshing();
                        }
                        setState(() {
                          this.progress = progress / 100;
                          urlController.text = this.url;
                        });
                      },
                      onUpdateVisitedHistory: (controller, url, androidIsReload) {
                        setState(() {
                          this.url = url.toString();
                          urlController.text = this.url;
                        });
                      },
                      onConsoleMessage: (controller, consoleMessage) {
                        print(consoleMessage);
                      },
                    ),
                    progress < 1.0
                        ? LinearProgressIndicator(value: progress)
                        : Container(),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    child: Text('    Cancel    '),
                    onPressed: () {
                      //webViewController?.goBack();
                     _showPopup();
                    },
                  ),
                  SizedBox(width: 10,),
                  ElevatedButton(
                    child: Text('    Submit    ',style: TextStyle(color: AppColors.cTextWhiteColor)),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.themeColor)),
                    onPressed: () {
                      //webViewController?.goForward();
                      generateInvoiceController.submitInvoice(
                          widget.invoiceNo.toString(),
                          'SUBMIT', widget.link.toString(),
                          ''
                      );
                    },
                  ),
                  // ElevatedButton(
                  //   child: Icon(Icons.refresh),
                  //   onPressed: () {
                  //     webViewController?.reload();
                  //   },
                  // ),
                ],
              ),
            ])
        )
    );
  }
}