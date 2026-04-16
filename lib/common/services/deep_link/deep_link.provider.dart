import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'deep_link.service.dart';

part 'deep_link.provider.g.dart';

@Riverpod(keepAlive: true)
DeepLinkService deepLink(DeepLinkRef ref) {
  final service = DeepLinkService();
  ref.onDispose(service.dispose);
  return service;
}

@Riverpod(keepAlive: true)
Stream<DeepLinkTarget> deepLinkStream(DeepLinkStreamRef ref) {
  return ref.watch(deepLinkProvider).stream;
}
