import 'package:flutter/material.dart';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/services.dart';

class RightViewChating extends StatelessWidget {
  String data;
  RightViewChating({this.data});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // MyCircleAvatar(
        //   imgUrl: messages[i]['contactImgUrl'],
        // ),

        Spacer(),

        // Text(
        //   "9:00 PM",
        // ),
        // SizedBox(width: 15),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Text(
           data,
            style: TextStyle(color: Colors.white),
          ),
        ),
        // SizedBox(width: 15),
        // Container(
        //   width: 50,
        //   height: 50,
        //   clipBehavior: Clip.antiAlias,
        //   decoration: BoxDecoration(
        //       color: Colors.grey,
        //       shape: BoxShape.circle,
        //       boxShadow: [
        //         BoxShadow(
        //           color: Colors.grey[300],
        //           blurRadius: 5.0,
        //           //    offset: Offset(0, 3)
        //         ),
        //       ]),
        //   child: Container(
        //     child: ImageLoadViewWithoutClip(
        //       imgURL:
        //           "https://www.google.com/images/branding/googleg/1x/googleg_standard_color_128dp.png",
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
