library angular2.transform.common.annotati_ON_matcher.template.dart;

import 'interface_matcher.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:analyzer/src/generated/ast.dart';
import 'package:barback/barback.dart' show AssetId;
import 'class_matcher_base.dart';
import 'class_matcher_base.template.dart' as i0;
export 'interface_matcher.dart';
export 'class_matcher_base.dart' show ClassDescriptor;
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
}


