import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class generateReports extends StatefulWidget {
  @override
  State<generateReports> createState() => _generateReportsState();
}

class _generateReportsState extends State<generateReports> {
  final pdf = pw.Document();

  final CollectionReference complaints =
      FirebaseFirestore.instance.collection('createComplaint');

  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    QuerySnapshot querySnapshot = await complaints.get();
    final name = querySnapshot.docs.map((data) => data['name']).toList();
    final email = querySnapshot.docs.map((data) => data['email']).toList();
    final mobile = querySnapshot.docs.map((data) => data['mobile']).toList();
    final address = querySnapshot.docs.map((data) => data['address']).toList();
    final city = querySnapshot.docs.map((data) => data['city']).toList();
    final category =
        querySnapshot.docs.map((data) => data['category']).toList();
    final status = querySnapshot.docs.map((data) => data['status']).toList();

    final font1 = await PdfGoogleFonts.openSansRegular();
    final font2 = await PdfGoogleFonts.openSansBold();

    var nameTostring = name.join();
    var categoryTostring = category.join();
    var cityTostring = city.join();
    var mobileTostring = mobile.join();
    var statusTostring = status.join();
    // final image = await imageFromAssetBundle('assets/r2.svg');

    String? _logo = await rootBundle.loadString('assets/img/logo.svg');

    doc.addPage(
      pw.Page(
        pageTheme: pw.PageTheme(
          pageFormat: format.copyWith(
            marginBottom: 0,
            marginLeft: 0,
            marginRight: 0,
            marginTop: 0,
          ),
          orientation: pw.PageOrientation.portrait,
          theme: pw.ThemeData.withFont(
            base: font1,
            bold: font2,
          ),
        ),
        build: (context) {
          return pw.Center(
              child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Flexible(
                child: pw.SvgImage(
                  svg: _logo,
                  height: 500,
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Center(
                child: pw.Text(
                  'All Complaints Report',
                  style: pw.TextStyle(
                    fontSize: 50,
                  ),
                ),
              ),
              pw.SizedBox(
                height: 20,
              ),
              pw.Divider(),

              // pw.Row(
              //   mainAxisAlignment: pw.MainAxisAlignment.center,
              //   children: [
              //     pw.Text(
              //       'Name : ',
              //       style: pw.TextStyle(
              //         fontSize: 40,
              //       ),
              //     ),
              //     pw.Text(
              //       name.join(),
              //       style: pw.TextStyle(
              //         fontSize: 35,
              //       ),
              //     ),
              //   ],
              // ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Name : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),

              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    nameTostring,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Category : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    categoryTostring,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'City : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    cityTostring,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Mobile : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    mobileTostring,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Status : ',
                    style: pw.TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    statusTostring,
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
    // doc.addPage(
    //   pw.Page(
    //     pageTheme: pw.PageTheme(
    //       pageFormat: format.copyWith(
    //         marginBottom: 0,
    //         marginLeft: 0,
    //         marginRight: 0,
    //         marginTop: 0,
    //       ),
    //       orientation: pw.PageOrientation.portrait,
    //       theme: pw.ThemeData.withFont(
    //         base: font1,
    //         bold: font2,
    //       ),
    //     ),
    //     build: (context) {
    //       return pw.Center(
    //           child: pw.Column(
    //         mainAxisAlignment: pw.MainAxisAlignment.center,
    //         children: [
    //           pw.Flexible(
    //             child: pw.SvgImage(
    //               svg: _logo,
    //               height: 560,
    //             ),
    //           ),
    //           pw.SizedBox(
    //             height: 20,
    //           ),
    //           pw.Center(
    //             child: pw.Text(
    //               'All Complaints Report',
    //               style: pw.TextStyle(
    //                 fontSize: 50,
    //               ),
    //             ),
    //           ),
    //           pw.SizedBox(
    //             height: 20,
    //           ),
    //           pw.Divider(),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Name : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 name.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Email : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 email.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 31,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Mobile : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 mobile.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Address : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 address.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'City : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 city.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Catgory : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 category.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //           pw.Row(
    //             mainAxisAlignment: pw.MainAxisAlignment.center,
    //             children: [
    //               pw.Text(
    //                 'Status : ',
    //                 style: pw.TextStyle(
    //                   fontSize: 40,
    //                 ),
    //               ),
    //               pw.Text(
    //                 status.join(),
    //                 style: pw.TextStyle(
    //                   fontSize: 35,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ));
    //     },
    //   ),
    // );

    return doc.save();
  }

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      canChangeOrientation: false,
      canDebug: false,
      build: (format) => generateDocument(format),
    );
  }
}
