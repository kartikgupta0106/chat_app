import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../view_model/routes/routes/app_pages.dart';

class CustomSendMessageUI extends StatelessWidget {
  final String? sendMsgTxt;
  final String? time;
  const CustomSendMessageUI({Key? key, @required this.sendMsgTxt,  this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sendMsgTxtGroup = Flexible(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      bottomLeft: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: ()=> Clipboard.setData(new ClipboardData(text: sendMsgTxt??"")),
                        // child: SelectableLinkify(
                        //   onOpen: (link) async {
                        //     if (await canLaunch(link.url)) {
                        //       await launch(link.url);
                        //     } else {
                        //       throw 'Could not launch $link';
                        //     }
                        //   },
                          child : Text(sendMsgTxt??""),
                        ),

                    ],
                  )
              ),
            ),
            CustomPaint(painter: CustomBubbleShape(Colors.lightBlueAccent)),
          ],
        ));
    return Padding(
      padding: const EdgeInsets.only(right: 15, left: 45, top: 15, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              sendMsgTxtGroup,
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            time??"",
            style: const TextStyle(fontSize: 12 , color: Colors.red),
          )
        ],
      ),
    );
  }
}

// class CustomReceivedMessageUI extends StatelessWidget {
//   final String? receivedName;
//   final String? receivedMsgTxt;
//   final String? time;
//   const CustomReceivedMessageUI(
//       {Key? key, required this.receivedMsgTxt, this.time, this.receivedName,this.sessionType,this.sessionId})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final receivedMsgTxtGroup = Flexible(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Transform(
//               alignment: Alignment.center,
//               transform: Matrix4.rotationY(math.pi),
//               child: CustomPaint(
//                 painter: CustomBubbleShape(Color(0xffF0F0F0)),
//               ),
//             ),
//             Flexible(
//               child: Container(
//                   padding: EdgeInsets.all(15),
//                   decoration: BoxDecoration(
//                     color: ColorResources.chatBackgroundColor,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(18),
//                       bottomLeft: Radius.circular(18),
//                       bottomRight: Radius.circular(18),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         receivedName??"Build It Home",
//                         style: robotoMedium(17, ColorResources.mainColor),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       InkWell(
//                         onTap: ()=> Clipboard.setData(new ClipboardData(text: receivedMsgTxt??"")),
//                         child: SelectableLinkify(
//
//                           onOpen: (link) async {
//                             if (await canLaunch(link.url)) {
//                               await launch(link.url);
//                             } else {
//                               throw 'Could not launch $link';
//                             }
//                           },
//                           options: LinkifyOptions(
//                               humanize: true
//                           ),
//                           text: receivedMsgTxt??"",
//                           style: robotoRegular(16, ColorResources.black),
//                           linkStyle: robotoSemiBold(16, ColorResources.mainColor),
//                         ),
//                       ),
//                       if(sessionType!=null)
//                         InkWell(
//                             onTap: (){
//                               switch (sessionType){
//                                 case "premade" :{Get.toNamed(Routes.PreMadeDetailsScreen,arguments:sessionId);}
//                                 break;
//                                 case "create_project_inquiry" :{Get.toNamed(Routes.CREATE_PROJECTS,arguments: {"create_type":"new"});}
//                                 break;
//                                 case "promotion" :{Get.toNamed(Routes.PromotionDetailsScreen,arguments: sessionId);}
//                                 break;
//                                 default: {
//                                   print("something want wrong");
//                                 }
//                                 break;
//                               }
//                             },child: Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: Text("Click Here",style: robotoBold(14, ColorResources.secondColor),),
//                         ))
//                     ],
//                   )
//               ),
//             ),
//           ],
//         ));
//
//     return Padding(
//       padding: EdgeInsets.only(right: 45, left: 15, top: 10, bottom: 5),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               receivedMsgTxtGroup,
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             time??"",
//             style: robotoRegular(12, ColorResources.black),
//           )
//         ],
//       ),
//     );
//   }
// }

/// bubble Shape
class CustomBubbleShape extends CustomPainter {
  final Color bgColor;

  CustomBubbleShape(this.bgColor);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = bgColor;
    var path = Path();
    path.lineTo(-5, 0);
    path.lineTo(0, 10);
    path.lineTo(5, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}





