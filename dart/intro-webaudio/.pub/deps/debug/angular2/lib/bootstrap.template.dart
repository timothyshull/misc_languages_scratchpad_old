library angular2.bootstrap.template.dart;

import 'bootstrap.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/platform/browser.template.dart' as i0;
import 'package:angular2/src/core/angular_entrypoint.template.dart' as i1;
export 'bootstrap.dart';
export 'package:angular2/platform/browser.dart' show bootstrap;
export 'package:angular2/src/core/angular_entrypoint.dart' show AngularEntrypoint;
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
}


