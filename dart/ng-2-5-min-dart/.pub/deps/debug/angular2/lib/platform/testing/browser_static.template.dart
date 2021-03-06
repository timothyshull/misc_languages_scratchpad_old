library angular2.platform.testing.browser_static.template.dart;

import 'browser_static.dart';
import 'package:angular2/src/core/reflection/reflection.dart' as _ngRef;
import 'package:angular2/core.dart' show APP_ID, DirectiveResolver, NgZone, Provider, ViewResolver, PLATFORM_COMMON_PROVIDERS, PLATFORM_INITIALIZER;
import 'package:angular2/src/platform/browser_common.dart' show BROWSER_APP_COMMON_PROVIDERS;
import 'package:angular2/src/platform/browser/browser_adapter.dart' show BrowserDomAdapter;
import 'package:angular2/src/animate/animation_builder.dart' show AnimationBuilder;
import 'package:angular2/src/mock/animation_builder_mock.dart' show MockAnimationBuilder;
import 'package:angular2/src/mock/directive_resolver_mock.dart' show MockDirectiveResolver;
import 'package:angular2/src/mock/view_resolver_mock.dart' show MockViewResolver;
import 'package:angular2/src/mock/mock_location_strategy.dart' show MockLocationStrategy;
import 'package:angular2/src/router/location/location_strategy.dart' show LocationStrategy;
import 'package:angular2/src/mock/ng_zone_mock.dart' show MockNgZone;
import 'package:angular2/src/platform/browser/xhr_impl.dart' show XHRImpl;
import 'package:angular2/compiler.dart' show XHR;
import 'package:angular2/src/testing/test_component_builder.dart' show TestComponentBuilder;
import 'package:angular2/src/testing/utils.dart' show BrowserDetection;
import 'package:angular2/platform/common_dom.dart' show ELEMENT_PROBE_PROVIDERS;
import 'package:angular2/src/testing/utils.dart' show Log;
import 'package:angular2/core.template.dart' as i0;
import 'package:angular2/src/platform/browser_common.template.dart' as i1;
import 'package:angular2/src/platform/browser/browser_adapter.template.dart' as i2;
import 'package:angular2/src/animate/animation_builder.template.dart' as i3;
import 'package:angular2/src/mock/animation_builder_mock.template.dart' as i4;
import 'package:angular2/src/mock/directive_resolver_mock.template.dart' as i5;
import 'package:angular2/src/mock/view_resolver_mock.template.dart' as i6;
import 'package:angular2/src/mock/mock_location_strategy.template.dart' as i7;
import 'package:angular2/src/router/location/location_strategy.template.dart' as i8;
import 'package:angular2/src/mock/ng_zone_mock.template.dart' as i9;
import 'package:angular2/src/platform/browser/xhr_impl.template.dart' as i10;
import 'package:angular2/compiler.template.dart' as i11;
import 'package:angular2/src/testing/test_component_builder.template.dart' as i12;
import 'package:angular2/src/testing/utils.template.dart' as i13;
import 'package:angular2/platform/common_dom.template.dart' as i14;
export 'browser_static.dart';
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
}


