library angular2.src.core.change_detection.change_detection.template.dart;

import 'change_detection.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'differs/iterable_differs.dart' show IterableDiffers, IterableDifferFactory;
import 'differs/default_iterable_differ.dart' show DefaultIterableDifferFactory;
import 'differs/keyvalue_differs.dart' show KeyValueDiffers, KeyValueDifferFactory;
import 'differs/default_keyvalue_differ.dart' show DefaultKeyValueDifferFactory, KeyValueChangeRecord;
import 'differs/iterable_differs.template.dart' as i0;
import 'differs/default_iterable_differ.template.dart' as i1;
import 'differs/keyvalue_differs.template.dart' as i2;
import 'differs/default_keyvalue_differ.template.dart' as i3;
import 'parser/ast.template.dart' as i4;
import 'parser/lexer.template.dart' as i5;
import 'parser/parser.template.dart' as i6;
import 'parser/locals.template.dart' as i7;
import 'exceptions.template.dart' as i8;
import 'interfaces.template.dart' as i9;
import 'constants.template.dart' as i10;
import 'proto_change_detector.template.dart' as i11;
import 'jit_proto_change_detector.template.dart' as i12;
import 'binding_record.template.dart' as i13;
import 'directive_record.template.dart' as i14;
import 'dynamic_change_detector.template.dart' as i15;
import 'change_detector_ref.template.dart' as i16;
import 'pipe_transform.template.dart' as i17;
import 'change_detection_util.template.dart' as i18;
export 'change_detection.dart';
export 'differs/default_keyvalue_differ.dart' show DefaultKeyValueDifferFactory, KeyValueChangeRecord;
export 'differs/default_iterable_differ.dart' show DefaultIterableDifferFactory, CollectionChangeRecord;
export 'parser/ast.dart' show ASTWithSource, AST, AstTransformer, PropertyRead, LiteralArray, ImplicitReceiver;
export 'parser/lexer.dart' show Lexer;
export 'parser/parser.dart' show Parser;
export 'parser/locals.dart' show Locals;
export 'exceptions.dart' show DehydratedException, ExpressionChangedAfterItHasBeenCheckedException, ChangeDetectionError;
export 'interfaces.dart' show ProtoChangeDetector, ChangeDetector, ChangeDispatcher, ChangeDetectorDefinition, DebugContext, ChangeDetectorGenConfig;
export 'constants.dart' show ChangeDetectionStrategy, CHANGE_DETECTION_STRATEGY_VALUES;
export 'proto_change_detector.dart' show DynamicProtoChangeDetector;
export 'jit_proto_change_detector.dart' show JitProtoChangeDetector;
export 'binding_record.dart' show BindingRecord, BindingTarget;
export 'directive_record.dart' show DirectiveIndex, DirectiveRecord;
export 'dynamic_change_detector.dart' show DynamicChangeDetector;
export 'change_detector_ref.dart' show ChangeDetectorRef;
export 'differs/iterable_differs.dart' show IterableDiffers, IterableDiffer, IterableDifferFactory, TrackByFn;
export 'differs/keyvalue_differs.dart' show KeyValueDiffers, KeyValueDiffer, KeyValueDifferFactory;
export 'pipe_transform.dart' show PipeTransform;
export 'change_detection_util.dart' show WrappedValue, SimpleChange;
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
i10.initReflector();
i11.initReflector();
i12.initReflector();
i13.initReflector();
i14.initReflector();
i15.initReflector();
i16.initReflector();
i17.initReflector();
i18.initReflector();
}


