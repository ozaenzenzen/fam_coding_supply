import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class AppWebSocketServiceCS {
  static Future<WebSocketChannel?> connect(String wsUrl) async {
    try {
      // final url = Uri.parse('ws://example.com');
      final url = Uri.parse(wsUrl);
      final channel = WebSocketChannel.connect(url);
      await channel.ready;

      // channel.stream.listen((message) {
      //   channel.sink.add('received!');
      //   channel.sink.close(status.goingAway);
      // });

      return channel;
    } catch (e) {
      return null;
    }
  }

  static Future<IOWebSocketChannel?> connect2(
    String wsUrl, {
    Iterable<String>? protocols,
    Map<String, dynamic>? headers,
    Duration? pingInterval,
    Duration? connectTimeout,
    // HttpClient? customClient,
  }) async {
    try {
      // final url = Uri.parse('ws://example.com');
      final url = Uri.parse(wsUrl);
      final channel = IOWebSocketChannel.connect(
        url,
        protocols: protocols,
        headers: headers,
        pingInterval: pingInterval,
        connectTimeout: connectTimeout,
      );
      await channel.ready;

      // channel.stream.listen((message) {
      //   channel.sink.add('received!');
      //   channel.sink.close(status.goingAway);
      // });

      return channel;
    } catch (e) {
      return null;
    }
  }
}
