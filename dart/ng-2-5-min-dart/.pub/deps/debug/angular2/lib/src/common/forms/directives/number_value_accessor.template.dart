library angular2.src.common.forms.directives.number_value_accessor.template.dart;

import 'number_value_accessor.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/core.dart' show Directive, ElementRef, Renderer, Self, Provider;
import 'control_value_accessor.dart' show NG_VALUE_ACCESSOR, ControlValueAccessor;
import 'package:angular2/src/facade/lang.dart' show isBlank, NumberWrapper;
import 'package:angular2/core.template.dart' as i0;
import 'control_value_accessor.template.dart' as i1;
import 'package:angular2/src/facade/lang.template.dart' as i2;
export 'number_value_accessor.dart';
var _visited = false;
void initReflector() {
if (_visited) return; _visited = true;
_ngRef.reflector
..registerType(NumberValueAccessor, new _ngRef.ReflectionInfo(
const [const Directive(bindings: const [NUMBER_VALUE_ACCESSOR], host: const {"(change)" : "onChange(\$event.target.value)", "(input)" : "onChange(\$event.target.value)", "(blur)" : "onTouched()"}, selector: "input[type=number][ngControl],input[type=number][ngFormControl],input[type=number][ngModel]")],
const [const [Renderer], const [ElementRef]],
(Renderer _renderer, ElementRef _elementRef) => new NumberValueAccessor(_renderer, _elementRef),
const [ControlValueAccessor])
)
;
i0.initReflector();
i1.initReflector();
i2.initReflector();
}


