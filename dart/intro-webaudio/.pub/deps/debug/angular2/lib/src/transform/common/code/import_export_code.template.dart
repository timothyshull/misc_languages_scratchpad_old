library angular2.transform.common.code.import_export_code.template.dart;

import 'import_export_code.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:analyzer/analyzer.dart';
import 'package:angular2/src/transform/common/mirror_matcher.dart';
import 'package:angular2/src/transform/common/names.dart';
import 'package:angular2/src/transform/common/model/import_export_model.pb.dart';
import 'package:angular2/src/transform/common/mirror_matcher.template.dart' as i0;
import 'package:angular2/src/transform/common/names.template.dart' as i1;
import 'package:angular2/src/transform/common/model/import_export_model.pb.template.dart' as i2;
export 'import_export_code.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
}


