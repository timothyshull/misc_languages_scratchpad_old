library angular2.src.transform.common.logging;

import 'dart:async';

import 'package:barback/barback.dart';
import 'package:source_span/source_span.dart';

import 'zone.dart' as zone show log;

/// The [TransformLogger] for the current {@link Zone}.
TransformLogger get log {
  var log = zone.log;
  return log != null ? log : new PrintLogger();
}

/// Writes a log entry at `LogLevel.FINE` granularity with the time taken by
/// `asyncOperation`.
///
/// Returns the result of executing `asyncOperation`.
Future logElapsedAsync(Future asyncOperation(),
    {String operationName: 'unknown', AssetId assetId}) async {
  final timer = new Stopwatch()..start();
  final result = await asyncOperation();
  timer.stop();
  _logElapsed(timer, operationName, assetId);
  return result;
}

/// Writes a log entry at `LogLevel.FINE` granularity with the time taken by
/// `operation`.
///
/// Returns the result of executing `operation`.
dynamic logElapsedSync(dynamic operation(),
    {String operationName: 'unknown', AssetId assetId}) {
  final timer = new Stopwatch()..start();
  final result = operation();
  timer.stop();
  _logElapsed(timer, operationName, assetId);
  return result;
}

/// Logs the time since `timer` was started.
void _logElapsed(Stopwatch timer, String operationName, AssetId assetId) {
  final buf =
      new StringBuffer('[$operationName] took ${timer.elapsedMilliseconds} ms');
  if (assetId != null) {
    buf.write(' on $assetId');
  }
  log.fine(buf.toString(), asset: assetId);
}

/// Prints logged messages to the console.
///
/// A simple implementation of [TransformLogger] that prints messages to the
/// console and discards `asset` and `span` information.
class PrintLogger implements TransformLogger {
  void _printWithPrefix(prefix, msg) => print('$prefix: $msg');

  @override
  void info(msg, {AssetId asset, SourceSpan span}) =>
      _printWithPrefix('INFO', msg);

  @override
  void fine(msg, {AssetId asset, SourceSpan span}) =>
      _printWithPrefix('FINE', msg);

  @override
  void warning(msg, {AssetId asset, SourceSpan span}) =>
      _printWithPrefix('WARN', msg);

  @override
  void error(msg, {AssetId asset, SourceSpan span}) {
    throw new PrintLoggerError(msg, asset, span);
  }
}

class PrintLoggerError extends Error {
  final String message;
  final AssetId asset;
  final SourceSpan span;

  PrintLoggerError(this.message, this.asset, this.span);

  @override
  String toString() {
    return 'Message: ${Error.safeToString(message)}, '
        'Asset: ${Error.safeToString(asset)}, '
        'Span: ${Error.safeToString(span)}.';
  }
}
