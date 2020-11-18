
import 'package:adhara_socket_io/adhara_socket_io.dart';
class Constant{

   static SocketIO socket;
 static List<String> toPrint = ["trying to connect"];
 static  SocketIOManager manager;
  static Map<String, SocketIO> sockets = {};
 static  String URI = "http://localhost:16558/";
   static Map<String, bool> isProbablyConnected = {};
}