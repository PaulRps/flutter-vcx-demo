import 'channel.enum.dart';

abstract class INativeChannel {
  abstract final ChannelEnum channel;

  Future<dynamic> callMethod(String name, {dynamic argument});
}
