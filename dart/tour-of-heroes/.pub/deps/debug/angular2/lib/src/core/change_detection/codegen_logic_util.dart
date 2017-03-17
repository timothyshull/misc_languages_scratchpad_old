library angular2.src.core.change_detection.codegen_logic_util;

import "package:angular2/src/facade/lang.dart"
    show IS_DART, Json, StringWrapper, isPresent, isBlank;
import "codegen_name_util.dart" show CodegenNameUtil;
import "codegen_facade.dart" show codify, combineGeneratedStrings, rawString;
import "proto_record.dart" show ProtoRecord, RecordType;
import "binding_record.dart" show BindingTarget;
import "directive_record.dart" show DirectiveRecord;
import "package:angular2/src/facade/exceptions.dart" show BaseException;

/**
 * Class responsible for providing change detection logic for change detector classes.
 */
class CodegenLogicUtil {
  CodegenNameUtil _names;
  String _utilName;
  String _changeDetectorStateName;
  CodegenLogicUtil(
      this._names, this._utilName, this._changeDetectorStateName) {}
  /**
   * Generates a statement which updates the local variable representing `protoRec` with the current
   * value of the record. Used by property bindings.
   */
  String genPropertyBindingEvalValue(ProtoRecord protoRec) {
    return this._genEvalValue(protoRec, (idx) => this._names.getLocalName(idx),
        this._names.getLocalsAccessorName());
  }

  /**
   * Generates a statement which updates the local variable representing `protoRec` with the current
   * value of the record. Used by event bindings.
   */
  String genEventBindingEvalValue(dynamic eventRecord, ProtoRecord protoRec) {
    return this._genEvalValue(protoRec,
        (idx) => this._names.getEventLocalName(eventRecord, idx), "locals");
  }

  String _genEvalValue(
      ProtoRecord protoRec, Function getLocalName, String localsAccessor) {
    var context = (protoRec.contextIndex == -1)
        ? this._names.getDirectiveName(protoRec.directiveIndex)
        : getLocalName(protoRec.contextIndex);
    var argString =
        protoRec.args.map((arg) => getLocalName(arg)).toList().join(", ");
    String rhs;
    switch (protoRec.mode) {
      case RecordType.Self:
        rhs = context;
        break;
      case RecordType.Const:
        rhs = codify(protoRec.funcOrValue);
        break;
      case RecordType.PropertyRead:
        rhs = '''${ context}.${ protoRec . name}''';
        break;
      case RecordType.SafeProperty:
        var read = '''${ context}.${ protoRec . name}''';
        rhs =
            '''${ this . _utilName}.isValueBlank(${ context}) ? null : ${ read}''';
        break;
      case RecordType.PropertyWrite:
        rhs =
            '''${ context}.${ protoRec . name} = ${ getLocalName ( protoRec . args [ 0 ] )}''';
        break;
      case RecordType.Local:
        rhs = '''${ localsAccessor}.get(${ rawString ( protoRec . name )})''';
        break;
      case RecordType.InvokeMethod:
        rhs = '''${ context}.${ protoRec . name}(${ argString})''';
        break;
      case RecordType.SafeMethodInvoke:
        var invoke = '''${ context}.${ protoRec . name}(${ argString})''';
        rhs =
            '''${ this . _utilName}.isValueBlank(${ context}) ? null : ${ invoke}''';
        break;
      case RecordType.InvokeClosure:
        rhs = '''${ context}(${ argString})''';
        break;
      case RecordType.PrimitiveOp:
        rhs = '''${ this . _utilName}.${ protoRec . name}(${ argString})''';
        break;
      case RecordType.CollectionLiteral:
        rhs = '''${ this . _utilName}.${ protoRec . name}(${ argString})''';
        break;
      case RecordType.Interpolate:
        rhs = this._genInterpolation(protoRec);
        break;
      case RecordType.KeyedRead:
        rhs = '''${ context}[${ getLocalName ( protoRec . args [ 0 ] )}]''';
        break;
      case RecordType.KeyedWrite:
        rhs =
            '''${ context}[${ getLocalName ( protoRec . args [ 0 ] )}] = ${ getLocalName ( protoRec . args [ 1 ] )}''';
        break;
      case RecordType.Chain:
        rhs =
            '''${ getLocalName ( protoRec . args [ protoRec . args . length - 1 ] )}''';
        break;
      default:
        throw new BaseException('''Unknown operation ${ protoRec . mode}''');
    }
    return '''${ getLocalName ( protoRec . selfIndex )} = ${ rhs};''';
  }

  String genPropertyBindingTargets(
      List<BindingTarget> propertyBindingTargets, bool genDebugInfo) {
    var bs = propertyBindingTargets.map((b) {
      if (isBlank(b)) return "null";
      var debug = genDebugInfo ? codify(b.debug) : "null";
      return '''${ this . _utilName}.bindingTarget(${ codify ( b . mode )}, ${ b . elementIndex}, ${ codify ( b . name )}, ${ codify ( b . unit )}, ${ debug})''';
    }).toList();
    return '''[${ bs . join ( ", " )}]''';
  }

  String genDirectiveIndices(List<DirectiveRecord> directiveRecords) {
    var bs = directiveRecords
        .map((b) =>
            '''${ this . _utilName}.directiveIndex(${ b . directiveIndex . elementIndex}, ${ b . directiveIndex . directiveIndex})''')
        .toList();
    return '''[${ bs . join ( ", " )}]''';
  }

  /** @internal */
  String _genInterpolation(ProtoRecord protoRec) {
    var iVals = [];
    for (var i = 0; i < protoRec.args.length; ++i) {
      iVals.add(codify(protoRec.fixedArgs[i]));
      iVals.add(
          '''${ this . _utilName}.s(${ this . _names . getLocalName ( protoRec . args [ i ] )})''');
    }
    iVals.add(codify(protoRec.fixedArgs[protoRec.args.length]));
    return combineGeneratedStrings(iVals);
  }

  String genHydrateDirectives(List<DirectiveRecord> directiveRecords) {
    var res = [];
    var outputCount = 0;
    for (var i = 0; i < directiveRecords.length; ++i) {
      var r = directiveRecords[i];
      var dirVarName = this._names.getDirectiveName(r.directiveIndex);
      res.add('''${ dirVarName} = ${ this . _genReadDirective ( i )};''');
      if (isPresent(r.outputs)) {
        r.outputs.forEach((output) {
          var eventHandlerExpr =
              this._genEventHandler(r.directiveIndex.elementIndex, output[1]);
          var statementStart =
              '''this.outputSubscriptions[${ outputCount ++}] = ${ dirVarName}.${ output [ 0 ]}''';
          if (IS_DART) {
            res.add('''${ statementStart}.listen(${ eventHandlerExpr});''');
          } else {
            res.add(
                '''${ statementStart}.subscribe({next: ${ eventHandlerExpr}});''');
          }
        });
      }
    }
    if (outputCount > 0) {
      var statementStart = "this.outputSubscriptions";
      if (IS_DART) {
        (res..insert(0, '''${ statementStart} = new List(${ outputCount});'''))
            .length;
      } else {
        (res..insert(0, '''${ statementStart} = new Array(${ outputCount});'''))
            .length;
      }
    }
    return res.join("\n");
  }

  String genDirectivesOnDestroy(List<DirectiveRecord> directiveRecords) {
    var res = [];
    for (var i = 0; i < directiveRecords.length; ++i) {
      var r = directiveRecords[i];
      if (r.callOnDestroy) {
        var dirVarName = this._names.getDirectiveName(r.directiveIndex);
        res.add('''${ dirVarName}.ngOnDestroy();''');
      }
    }
    return res.join("\n");
  }

  String _genEventHandler(num boundElementIndex, String eventName) {
    if (IS_DART) {
      return '''(event) => this.handleEvent(\'${ eventName}\', ${ boundElementIndex}, event)''';
    } else {
      return '''(function(event) { return this.handleEvent(\'${ eventName}\', ${ boundElementIndex}, event); }).bind(this)''';
    }
  }

  _genReadDirective(num index) {
    return '''this.getDirectiveFor(directives, ${ index})''';
  }

  String genHydrateDetectors(List<DirectiveRecord> directiveRecords) {
    var res = [];
    for (var i = 0; i < directiveRecords.length; ++i) {
      var r = directiveRecords[i];
      if (!r.isDefaultChangeDetection()) {
        res.add(
            '''${ this . _names . getDetectorName ( r . directiveIndex )} = this.getDetectorFor(directives, ${ i});''');
      }
    }
    return res.join("\n");
  }

  List<String> genContentLifecycleCallbacks(
      List<DirectiveRecord> directiveRecords) {
    var res = [];
    var eq = IS_DART ? "==" : "===";
    // NOTE(kegluneq): Order is important!
    for (var i = directiveRecords.length - 1; i >= 0; --i) {
      var dir = directiveRecords[i];
      if (dir.callAfterContentInit) {
        res.add(
            '''if(${ this . _names . getStateName ( )} ${ eq} ${ this . _changeDetectorStateName}.NeverChecked) ${ this . _names . getDirectiveName ( dir . directiveIndex )}.ngAfterContentInit();''');
      }
      if (dir.callAfterContentChecked) {
        res.add(
            '''${ this . _names . getDirectiveName ( dir . directiveIndex )}.ngAfterContentChecked();''');
      }
    }
    return res;
  }

  List<String> genViewLifecycleCallbacks(
      List<DirectiveRecord> directiveRecords) {
    var res = [];
    var eq = IS_DART ? "==" : "===";
    // NOTE(kegluneq): Order is important!
    for (var i = directiveRecords.length - 1; i >= 0; --i) {
      var dir = directiveRecords[i];
      if (dir.callAfterViewInit) {
        res.add(
            '''if(${ this . _names . getStateName ( )} ${ eq} ${ this . _changeDetectorStateName}.NeverChecked) ${ this . _names . getDirectiveName ( dir . directiveIndex )}.ngAfterViewInit();''');
      }
      if (dir.callAfterViewChecked) {
        res.add(
            '''${ this . _names . getDirectiveName ( dir . directiveIndex )}.ngAfterViewChecked();''');
      }
    }
    return res;
  }
}
