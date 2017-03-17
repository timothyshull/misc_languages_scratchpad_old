library angular2.src.transform.inliner_for_test.transformer.template.dart;

import 'transformer.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'dart:async';
import 'dart:convert' show LineSplitter;
import 'package:analyzer/analyzer.dart';
import 'package:analyzer/src/generated/ast.dart';
import 'package:barback/barback.dart';
import 'package:dart_style/dart_style.dart';
import 'package:angular2/src/compiler/xhr.dart' show XHR;
import 'package:angular2/src/transform/common/annotation_matcher.dart';
import 'package:angular2/src/transform/common/asset_reader.dart';
import 'package:angular2/src/transform/common/naive_eval.dart';
import 'package:angular2/src/transform/common/async_string_writer.dart';
import 'package:angular2/src/transform/common/options.dart';
import 'package:angular2/src/transform/common/url_resolver.dart';
import 'package:angular2/src/transform/common/xhr_impl.dart';
import 'package:angular2/src/transform/common/zone.dart' as zone;
import 'package:angular2/src/transform/directive_processor/inliner.dart';
import 'package:angular2/src/compiler/xhr.template.dart' as i0;
import 'package:angular2/src/transform/common/annotation_matcher.template.dart' as i1;
import 'package:angular2/src/transform/common/asset_reader.template.dart' as i2;
import 'package:angular2/src/transform/common/naive_eval.template.dart' as i3;
import 'package:angular2/src/transform/common/async_string_writer.template.dart' as i4;
import 'package:angular2/src/transform/common/options.template.dart' as i5;
import 'package:angular2/src/transform/common/url_resolver.template.dart' as i6;
import 'package:angular2/src/transform/common/xhr_impl.template.dart' as i7;
import 'package:angular2/src/transform/common/zone.template.dart' as i8;
import 'package:angular2/src/transform/directive_processor/inliner.template.dart' as i9;
export 'transformer.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
i5.initReflector();
i6.initReflector();
i7.initReflector();
i8.initReflector();
i9.initReflector();
}

