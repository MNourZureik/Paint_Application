// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:AEC_Mobile/main.dart';
import 'package:AEC_Mobile/modules/home_page/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({super.key});

  @override
  DownloadPageState createState() => DownloadPageState();
}

class DownloadPageState extends State<DownloadPage> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    // Register for download updates
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      'downloader_send_port',
    );

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      print('Download task ($id): $status - $progress%');
    });

    FlutterDownloader.registerCallback(downloadCallback as DownloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  // Start the download task
  void startDownload(String link) async {
    HomePageController controller = Get.find();
    controller.loader = const CircularProgressIndicator();
    controller.update(['load_file']);
    await Future.delayed(const Duration(milliseconds: 1500));
    String? url = HomePageController.campaign.file; // Example file URL
    final taskId = await FlutterDownloader.enqueue(
      url: url!,
      savedDir: '/storage/emulated/0/Download', // Change to your desired path
      fileName: 'campaign_file',
      showNotification: true, // Show download progress in the notification bar
      openFileFromNotification:
          true, // Allow the user to open the file from the notification
    );
    log("url file : $url");
    if (taskId != null) {
      appData!.setString(
        "campign_file",
        '/storage/emulated/0/Download/campign_file.pdf',
      );
    }
    controller.loader = null;
    controller.update(['load_file']);

    print('Download started: $taskId');
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

// Callback for FlutterDownloader updates
@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}
