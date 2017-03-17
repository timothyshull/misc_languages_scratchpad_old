import 'dart:html';
import 'dart:math';
import 'dart:web_audio';

class FilterSample {
  final _FREQ = 5000;
  final _FREQ_MUL = 7000;
  final _QUAL_MUL = 30;
  bool _playing = false;
  ApplicationContext appCtx;
  AudioBufferSourceNode _source;
  BiquadFilterNode _filter;

  FilterSample(this.appCtx) {
    querySelector("#play-pause-button").onClick.listen((Event e) {
      _toggle();
    });
    querySelector("#enable-filter-checkbox").onChange.listen((Event e) {
      bool checked = (e.currentTarget as InputElement).checked;
      _toggleFilter(checked);
    });
    querySelector("#frequency-range").onInput.listen((Event e) {
      num value = double.parse((e.currentTarget as InputElement).value);
      _changeFrequency(value);
    });
    querySelector("#quality-range").onInput.listen((Event e) {
      num value = double.parse((e.currentTarget as InputElement).value);
      _changeQuality(value);
    });
  }

  void _play() {
    // Create the source.
    _source = appCtx.audioCtx.createBufferSource();
    _source.buffer = appCtx.buffers['example'];

    // Create the filter.
    _filter = appCtx.audioCtx.createBiquadFilter();
    _filter.type = "lowpass";
    _filter.frequency.value = _FREQ;

    // Connect everything.
    _source.connectNode(_filter, 0, 0);
    _filter.connectNode(appCtx.audioCtx.destination, 0, 0);

    // Play!
    _source.start(0);
    _source.loop = true;
  }

  void _stop() {
    _source.stop(0);
  }

  void _toggle() {
    _playing ? _stop() : _play();
    _playing = !_playing;
  }

  void _toggleFilter(bool checked) {
    _source.disconnect(0);
    _filter.disconnect(0);

    // Check if we want to enable the filter.
    if (checked) {
      // Connect through the filter.
      _source.connectNode(_filter, 0, 0);
      _filter.connectNode(appCtx.audioCtx.destination, 0, 0);
    } else {
      // Otherwise, connect directly.
      _source.connectNode(appCtx.audioCtx.destination, 0, 0);
    }
  }

  void _changeFrequency(num value) {
    // Clamp the frequency between the minimum value (40 Hz) and half of the
    // sampling rate.
    var minValue = 40;
    var maxValue = appCtx.audioCtx.sampleRate / 2;

    // Logarithm (base 2) to compute how many octaves fall in the range.
    var numberOfOctaves = log(maxValue / minValue) / LN2;

    // Compute a multiplier from 0 to 1 based on an exponential scale.
    var multiplier = pow(2, numberOfOctaves * (value - 1.0));

    // Get back to the frequency value between min and max.
    _filter.frequency.value = maxValue * multiplier;
  }

  void _changeQuality(num value) {
    _filter.Q.value = value * _QUAL_MUL;
  }
}


//// #docplaster
//
//// #docregion
//import 'dart:async';
//
//import 'package:angular2/angular2.dart';
//import 'package:angular2/router.dart';
//
//import 'hero.dart';
//import 'hero_detail_component.dart';
//import 'hero_service.dart';
//
//// #docregion metadata
//// #docregion heroes-component-renaming
//@Component(
//    selector: 'my-heroes',
//// #enddocregion heroes-component-renaming
//    templateUrl: 'heroes_component.html',
//    styleUrls: const ['heroes_component.css'],
//    directives: const [HeroDetailComponent]
//// #docregion heroes-component-renaming
//) // #enddocregion heroes-component-renaming
//// #enddocregion metadata
//// #docregion class
//// #docregion heroes-component-renaming
//class HeroesComponent
//    implements OnInit {
//// #enddocregion heroes-component-renaming
//  final Router _router;
//  final HeroService _heroService;
//  List<Hero> heroes;
//  Hero selectedHero;
//
//  HeroesComponent(this._heroService, this._router);
//
//  Future getHeroes() async {
//    heroes = await _heroService.getHeroes();
//  }
//
//  void ngOnInit() {
//    getHeroes();
//  }
//
//  void onSelect(Hero hero) {
//    selectedHero = hero;
//  }
//
//  Future gotoDetail() =>
//      _router.navigate(['HeroDetail', {'id': selectedHero.id.toString()}]);
//// #docregion heroes-component-renaming
//}
//// #enddocregion heroes-component-renaming
//// #enddocregion class
//// #enddocregion