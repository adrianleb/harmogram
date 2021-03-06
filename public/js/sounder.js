// Generated by CoffeeScript 1.12.7
(function() {
  var SounderControl;

  SounderControl = (function() {
    SounderControl.prototype.init = function() {
      var AudioContext;
      this.initEvents();
      AudioContext = window.AudioContext || window.webkitAudioContext;
      this.context = new AudioContext();
      this.analyser = this.context.createAnalyser();
      this._plug(this.analyser, this.context.destination);
      return $('#first-gesture').click((function(_this) {
        return function() {
          _this.context.resume();
          return $('#first-gesture').hide();
        };
      })(this));
    };

    function SounderControl() {
      this.loaded = false;
      this.source = void 0;
      this.audio = void 0;
      this.init();
    }

    SounderControl.prototype.initEvents = function() {
      return $(this).on('newTrack', (function(_this) {
        return function(e, track) {
          return _this.plugOne(track);
        };
      })(this));
    };

    SounderControl.prototype.plugMany = function() {
      var i, len, plug, ref, results;
      ref = $('audio');
      results = [];
      for (i = 0, len = ref.length; i < len; i++) {
        plug = ref[i];
        results.push((function(_this) {
          return function(plug) {
            var source;
            source = _this.context.createMediaElementSource(plug);
            source.connect(_this.analyser);
            plug.crossOrigin = "anonymous";
            return $(Sounder.player).trigger('newAudio', plug);
          };
        })(this)(plug));
      }
      return results;
    };

    SounderControl.prototype.plugOne = function(el) {
      var source;
      source = this.context.createMediaElementSource(el);
      source.connect(this.analyser);
      el.crossOrigin = "anonymous";
      return $(Sounder.player).trigger('newAudio', el);
    };

    SounderControl.prototype._plug = function(input, output) {
      return input.connect(output);
    };

    return SounderControl;

  })();

  (function() {
    return Sounder.control = new SounderControl;
  })();

}).call(this);
