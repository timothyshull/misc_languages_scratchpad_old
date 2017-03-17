library reflection.reflection_capabilities.template.dart;

import 'reflection_capabilities.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/src/facade/lang.dart';
import 'types.dart';
import 'dart:mirrors';
import 'platform_reflection_capabilities.dart';
import 'package:angular2/src/facade/lang.template.dart' as i0;
import 'types.template.dart' as i1;
import 'platform_reflection_capabilities.template.dart' as i2;
export 'reflection_capabilities.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
}


