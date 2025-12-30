import 'dart:convert';

import 'package:fam_coding_supply/logic/app_logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class AppSocketioService {
  static late io.Socket socket;

  static bool isOn = false;

  static io.Socket connect({
    required String url,
    required String token,
  }) {
    try {
      socket = io.io(
        url,
        io.OptionBuilder()
            .setReconnectionDelayMax(10000)
            .setTransports(['websocket'])
            .setExtraHeaders(
              {
                'Authorization': token,
              },
            )
            .enableForceNew()
            .enableReconnection()
            .build(),
      );

      socket.onConnect((_) {
        // AppLoggerCS.debugLog("[AppSocketioService][onConnect] Connection established");
        // AppLoggerCS.debugLog('🔐 Session ID: ${socket.id}'); // ← this is the sid
        isOn = true;
        socket.id = socket.id;
      });

      socket.onDisconnect((_) {
        // AppLoggerCS.debugLog("[AppSocketioService][onDisconnect] Disconnect socket");
        isOn = false;
      });

      socket.onAnyOutgoing((event, data) {
        AppLoggerCS.debugLog("[AppSocketioService][onAny] event $event");
        AppLoggerCS.debugLog("[AppSocketioService][onAny] data $data");
        AppLoggerCS.debugLog("[AppSocketioService][onAny] data2 ${jsonEncode(data)}");
        // AppLoggerCS.debugLog("[AppSocketioService][onAny] data ${jsonEncode(data)}");
        // AppLoggerCS.debugLog("[AppSocketioService][onAny] data ${data}");
      });

      socket.onConnectError((error) {
        // AppLoggerCS.debugLog("[error] $error");
      });

      socket.onError((error) {
        // AppLoggerCS.debugLog("[error1] $error");
      });

      socket.connect();
      return socket;
    } catch (e) {
      AppLoggerCS.debugLog("[AppSocketioService] error here: $e");
      rethrow;
    }
  }

  void listenToMessages(String eventName, Function(dynamic) onMessage) {
    socket.on(
      // 'new_message',
      eventName,
      (data) {
        onMessage(data); // callback
      },
    );
  }

  void sendMessage(String eventName, Map<String, dynamic> message) {
    socket.emit(
      // 'send_message',
      eventName,
      message,
    );
  }
}
