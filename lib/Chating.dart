
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/services.dart';

import 'Constant.dart';
import 'LeftViewChatiing.dart';
import 'RightViewChating.dart';


class MsgModel{
String msg;
String type;

MsgModel({this.msg,this.type});
factory MsgModel.jsonFrom(Map<String,dynamic> json){
  return  MsgModel(msg: json["msg"],type: json["type"]);
  }
}


class Chating extends StatefulWidget {
  String userID = "";
  String userName = "";

  Chating({this.userID = "", this.userName});
  @override
  _ChatingState createState() => _ChatingState();
}

class _ChatingState extends State<Chating> with WidgetsBindingObserver {
 
  var userToken = '';
  var soundPlay = false;
  TextEditingController msgTF = TextEditingController();
List<MsgModel> msgList = [
// MsgModel(msg: "Hello",type: "me"),
// MsgModel(msg: "Hi,I hope u doing well",type: "you")

];
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
 
  //  initSocket("default");
   Constant.manager = SocketIOManager();
    initSocket("default");
    WidgetsBinding.instance.addPostFrameCallback((_) {
     

      // Add Your Code here.
    });
   
    
  }

initSocket(String identifier) async {
    setState(() => Constant.isProbablyConnected[identifier] = true);
    Constant.socket = await Constant.manager.createInstance(SocketOptions(
      //Socket IO server URI
        Constant.URI,
        nameSpace: (identifier == "namespaced")?"/adhara":"/",
        //Query params - can be used for authentication
        query: {
          "auth": "--SOME AUTH STRING---",
          "info": "new connection from adhara-socketio",
          "timestamp": DateTime.now().toString()
        },
        //Enable or disable platform channel logging
        enableLogging: false,
        transports: [Transports.WEB_SOCKET/*, Transports.POLLING*/] //Enable required transport
    ));
      
    Constant.socket.onConnect((data) {
      pprint("connected...");
      pprint("0---0--"+data);
       Constant.socket.emit("setPseudo", [widget.userName]);
  
   /*    Constant.socket.on("message", (data) {

         
//  var data1 = json.decode(data.toString());
//   print("data1"+data1.toString());
         print("----"+data.toString());


//        MsgModel userMsg = MsgModel(msg: data1["message"].toString(),type: "you");
// msgList.add(userMsg);
//        setState(() {
         
//        });
      /// pprint("oo00"+data);

        });*/
          // socket.emit("message", ["hello"]);
          //  Constant.socket.on("message", (data) { 


          //    print("++++");
          //  });
     // sendMessage(identifier);
    });
          Constant.socket.on("message", (data) => pprint(data));
    Constant.socket.onConnectError(pprint);
     Constant.socket.onConnectTimeout(pprint);
     Constant.socket.onError(pprint);
     Constant.socket.onDisconnect(pprint);
    // socket.on("type:string", (data) => pprint("type:string | $data"));
    // socket.on("type:bool", (data) => pprint("type:bool | $data"));
    // socket.on("type:number", (data) => pprint("type:number | $data"));
    // socket.on("type:object", (data) => pprint("type:object | $data"));
    // socket.on("type:list", (data) => pprint("type:list | $data"));
//     Constant.socket.on("message", (data) { 
//       var data1 = json.decode(data);
//        MsgModel userMsg = MsgModel(msg: data1["message"].toString(),type: "you");
// msgList.add(userMsg);
//        setState(() {
         
//        });
//        pprint("oo00"+data);
//        });
     Constant.socket.connect();
     Constant.sockets[identifier] =  Constant.socket;
  } 
  
  pprint(data) {

    print("---?"+data.toString());



    
// msgList.add(userMsg);
//        setState(() {
         
//        });
    setState(() {
      if (data is Map) {
        print(data["message"]);
         MsgModel userMsg = MsgModel(msg: data["message"],type: "you");
 msgList.add(userMsg);
        data = json.encode(data);
        print("MAP");
         print("MAP");
      //     print( "rrrrr"+json.decode(data));
      // Map<String,dynamic> fff = json.decode(data);
      //   print("fff"+fff["message"]);
      }
     
      print("+"+data);
      //d   print("--"+json.decode(data));
     
    });
      // MsgModel userMsg = MsgModel(msg: data["message"].toString(),type: "you");
      //  msgList.add(userMsg);
  }

  
 
  

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
     
      body: SafeArea(
          child: Stack(
        children: <Widget>[
          bodyDesign(),
          Positioned(
              bottom: 0,
              child: SafeArea(
                child: Container(
                  height: 60,
                  color: Colors.grey[100],
                  padding: const EdgeInsets.only(right: 15),
                  width: MediaQuery.of(context).size.width,
                  child: Row(children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            //color: Colors.white,
                            child: TextField(
                              controller: msgTF,
                              style: TextStyle(
                                  fontSize: 14, 
                                ),
                              // minLines: 1,
                              // maxLines: 1,
                              autocorrect: false,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: 'Write reply here..',
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                   ),
                                // filled: true,
                                // fillColor: Color(0xFFDBEDFF),

                                // enabledBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10.0)),
                                //   borderSide: BorderSide(
                                //       width: 0.5,
                                //       color: AppColor.blueTextColor),
                                // ),
                                // focusedBorder: OutlineInputBorder(
                                //   borderRadius:
                                //       BorderRadius.all(Radius.circular(10.0)),
                                //   borderSide: BorderSide(
                                //       width: 0.5,
                                //       color: AppColor.blueTextColor),
                                // ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if(msgTF.text.isEmpty){
return;
                          }
                          Constant.socket.emit("message", [msgTF.text]);
                           //Constant.socket.emit("message", [msgTF.text]);
                          addMsgInModel(msgTF.text);
                        })
                    
                  ]),
                ),
              )),
        ],
      )),
    );
  }
addMsgInModel(text){

MsgModel userMsg = MsgModel(msg: text,type: "me");
msgList.add(userMsg);

setState(() {
  
});
msgTF.clear();
}
  bodyDesign() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        
        SizedBox(
          height: 20,
        ),
    Expanded(child:chating())

      ],
    );
  }

 

  Widget chating() {
    return ListView.separated(
       
       // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
         
          return (msgList[index].type == "me")
              ? RightViewChating(
                  data: msgList[index].msg,
                )
              : LeftViewChatiing(data:msgList[index].msg);
         
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 20,
          );
        },
        itemCount:msgList.length);
  }
}
