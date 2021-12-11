import 'package:stack_exchange_questions/core/network/i_network_client.dart';

abstract class IApiProvider {
  final INetworkClient client;

  IApiProvider(this.client);
}
