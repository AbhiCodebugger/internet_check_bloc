import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/bloc/internet_bloc/internet_event.dart';
import 'package:flutter_bloc_app/bloc/internet_bloc/internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  final Connectivity _connectivity = Connectivity();
  StreamSubscription? _connectivityStream;

  InternetBloc() : super(InititalState()) {
    on<InternetGainedEvent>((event, emit) => emit(InternetConnected()));
    on<InternetLostEvent>((event, emit) => emit(InternetDisconnected()));

    _connectivityStream = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        add(InternetGainedEvent());
      } else {
        add(InternetLostEvent());
      }
    });
  }
  @override
  Future<void> close() {
    _connectivityStream?.cancel();
    return super.close();
  }
}
