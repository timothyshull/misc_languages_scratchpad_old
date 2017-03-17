library angular2.src.core.linker.pipe_resolver.template.dart;

import 'pipe_resolver.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/src/core/di.dart' show resolveForwardRef, Injectable;
import 'package:angular2/src/facade/lang.dart' show Type, isPresent, stringify;
import 'package:angular2/src/facade/exceptions.dart' show BaseException;
import 'package:angular2/src/core/metadata.dart' show PipeMetadata;
import 'package:angular2/src/core/reflection/reflection.dart' show reflector;
import 'package:angular2/src/core/di.template.dart' as i0;
import 'package:angular2/src/facade/lang.template.dart' as i1;
import 'package:angular2/src/facade/exceptions.template.dart' as i2;
import 'package:angular2/src/core/metadata.template.dart' as i3;
import 'package:angular2/src/core/reflection/reflection.template.dart' as i4;
export 'pipe_resolver.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
_ngRef.reflector
..registerType(PipeResolver, new _ngRef.ReflectionInfo(
const [const Injectable()],
const [],
() => new PipeResolver())
)
;
i0.initReflector();
i1.initReflector();
i2.initReflector();
i3.initReflector();
i4.initReflector();
}


