import 'package:blockchain/VaccineInfo.dart';
import 'package:blockchain/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _QRCodeScanner();
  }
}
const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';
class _QRCodeScanner extends State<QRCodeScanner> {
  Barcode result;
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  @override
  void reassemble() {
    super.reassemble();
    controller.pauseCamera();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(child: _buildQrView(context)),
          Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text('Barcode Type: ${describeEnum(result.format)}   Data: ${result.code}',style: subheading,),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Scan a code",style: subheading,),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            if (controller != null) {
                              controller.toggleFlash();
                              if (_isFlashOn(flashState)) {
                                setState(() {
                                  flashState = flashOff;
                                });
                              } else {
                                setState(() {
                                  flashState = flashOn;
                                });
                              }
                            }
                          },
                          child: Padding(
                            child: (_isFlashOn(flashState))?Icon(Icons.flash_on,size: 30,):Icon(Icons.flash_off,size: 30,),
                            padding: EdgeInsets.all(10),
                          ),
                      ),
                      GestureDetector(
                          onTap: () {
                            if (controller != null) {
                              controller.flipCamera();
                              if (_isBackCamera(cameraState)) {
                                setState(() {
                                  cameraState = frontCamera;
                                });
                              } else {
                                setState(() {
                                  cameraState = backCamera;
                                });
                              }
                            }
                          },
                          child: Padding(
                            child: Icon(Icons.flip_camera_android_outlined,size: 30,),
                            padding: EdgeInsets.all(10),
                          )
                        ),
                      GestureDetector(
                          onTap: () {
                            controller?.pauseCamera();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.pause,size: 30,),
                          ),
                        ),
                       GestureDetector(
                          onTap: () {
                            controller?.resumeCamera();
                          },
                          child: Padding(
                            child: Icon(Icons.play_arrow_rounded),
                            padding: EdgeInsets.all(10),
                          )
                        ),
                    ],
                  ),
                ],
              ),
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
        MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          Future.microtask(
                  () => controller?.updateDimensions(qrKey, scanArea: scanArea));
          return false;
        },
        child: SizeChangedLayoutNotifier(
            key: const Key('qr-size-notifier'),
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
              ),
            )));
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      controller.dispose();
      await Navigator.popAndPushNamed(context, '/vaccineInfo',arguments: scanData);
    });
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}