library angular2.core.compiler.pipe_lifecycle_reflector.template.dart;

import 'pipe_lifecycle_reflector.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/src/core/linker/interfaces.dart';
import 'package:angular2/src/core/linker/interfaces.template.dart' as i0;
export 'pipe_lifecycle_reflector.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
}


