
import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityHelper{
  final Connectivity _connectivity = Connectivity();


  Stream<bool> getConnectivityStream() async*{
    bool isConnected = true;
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult>  event) {
      if(event.contains(ConnectivityResult.wifi) || event.contains(ConnectivityResult.mobile)){
        isConnected= true;
      }else{
        isConnected =  false;
      }
    },);
    yield isConnected;
  }
}