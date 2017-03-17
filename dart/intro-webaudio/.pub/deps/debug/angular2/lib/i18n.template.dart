library angular2.i18n.template.dart;

import 'i18n.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'src/i18n/message.template.dart' as i0;
import 'src/i18n/xmb_serializer.template.dart' as i1;
import 'src/i18n/message_extractor.template.dart' as i2;
export 'i18n.dart';
export 'src/i18n/message.dart';
export 'src/i18n/xmb_serializer.dart';
export 'src/i18n/message_extractor.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
i0.initReflector();
i1.initReflector();
i2.initReflector();
}


