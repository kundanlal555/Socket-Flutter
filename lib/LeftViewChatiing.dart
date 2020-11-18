import 'package:flutter/material.dart';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/services.dart';

class LeftViewChatiing extends StatelessWidget {
  String  data;

  LeftViewChatiing({this.data});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        // SizedBox(
        //   width: 20,
        // ),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .7),
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
          child: Text(
            data,
          ),
        ),
      ],
    );
  }
}
