import 'package:flutter/material.dart';

import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:flutter/services.dart';

import 'Chating.dart';
import './Constant.dart';


class UserNameVC extends StatefulWidget {
  UserNameVC({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UserNameVCState createState() => _UserNameVCState();
}

class _UserNameVCState extends State<UserNameVC> {
  // SocketIO socket;
  // List<String> toPrint = ["trying to connect"];
  // SocketIOManager manager;
  // Map<String, SocketIO> sockets = {};
  // String URI = "http://localhost:16558/";
  // Map<String, bool> _isProbablyConnected = {};




  TextEditingController _usernameController=TextEditingController();
   TextEditingController _msgTF=TextEditingController();
 
 @override
  void initState() {
    super.initState();
    Constant.manager = SocketIOManager();
    initSocket("default");
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
      pprint(data);
      
          // socket.emit("message", ["hello"]);
          // socket.on("message", (data) { })
     // sendMessage(identifier);
    });
    
    Constant.socket.onConnectError(pprint);
     Constant.socket.onConnectTimeout(pprint);
     Constant.socket.onError(pprint);
     Constant.socket.onDisconnect(pprint);
    // socket.on("type:string", (data) => pprint("type:string | $data"));
    // socket.on("type:bool", (data) => pprint("type:bool | $data"));
    // socket.on("type:number", (data) => pprint("type:number | $data"));
    // socket.on("type:object", (data) => pprint("type:object | $data"));
    // socket.on("type:list", (data) => pprint("type:list | $data"));
     Constant.socket.on("message", (data) => pprint(data));
     Constant.socket.connect();
     Constant.sockets[identifier] =  Constant.socket;
  } 
  
  pprint(data) {
    setState(() {
      if (data is Map) {
        //data = json.encode(data);
      }
      print(data);
       Constant.toPrint.add(data);
    });
  }
  
   @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Enter Name"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[


             TextField(
                controller: _usernameController,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.all(20.0),
                ),
              ),
              SizedBox(height: 50,),
               OutlineButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    if(_usernameController.text.isEmpty){

                          return;
                    }
              //  Constant.socket.emit("setPseudo", [_usernameController.text]);

                Navigator.push( 
    context, 
    MaterialPageRoute(builder: (context) =>Chating (userName:_usernameController.text ,)), 
  ); 
                  }),
              
                
             
            ],
          ),
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
