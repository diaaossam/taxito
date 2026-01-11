import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  final Connectivity _connectivity = Connectivity();

  NetworkCubit() : super(NetworkInitial()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> event) {
        if (event.contains(ConnectivityResult.none)) {
          emit(ConnectionFailure());
        } else {
          emit(ConnectionSuccess());
        }
      },
    );
  }
}
