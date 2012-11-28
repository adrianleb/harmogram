window.JST = {};
JST['about'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('  <h1>Hello there</h1>\n  <h2>world</h2>\n  <a href="#" class="back" id="about-back">back</a>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
JST['colorCard'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var c;
    
      c = this.color.color.attributes;
    
      __out.push(' \n<section data-hex="#');
    
      __out.push(__sanitize(c.hex));
    
      __out.push('" data-r="');
    
      __out.push(__sanitize(c.rgb.r));
    
      __out.push('"  data-g="');
    
      __out.push(__sanitize(c.rgb.g));
    
      __out.push('"  data-b="');
    
      __out.push(__sanitize(c.rgb.b));
    
      __out.push('" data-brightness="');
    
      __out.push(__sanitize(c.brightness));
    
      __out.push('"style=" background-color:');
    
      __out.push(__sanitize(c.brightness < 0.5 ? "hsl(0,0%, 90%)" : "hsl(0,0%, 10%)"));
    
      __out.push('; color:#');
    
      __out.push(__sanitize(c.hex));
    
      __out.push(';">\n  <div class="row">\n    <div class="sample" style="background-color:#');
    
      __out.push(__sanitize(c.hex));
    
      __out.push(';" > </div\n      ><div class="details">\n        <h1 >#');
    
      __out.push(__sanitize(c.hex));
    
      __out.push('</h1>\n        <h2>');
    
      __out.push(__sanitize(c.name));
    
      __out.push('</h2>\n    </div>\n  </div>\n      <div class="others">\n        <p><span class="color_type">RAL</span><span class="color_val">');
    
      __out.push(__sanitize(c.ral));
    
      __out.push('</span></p>\n        <p><span class="color_type">RGB</span><span class="color_val">');
    
      __out.push(__sanitize(c.rgb.rgb));
    
      __out.push('</span></p>\n        <p><span class="color_type">CMYK</span><span class="color_val">');
    
      __out.push(__sanitize(c.cmyk.cmyk));
    
      __out.push('</span></p>\n        <p><span class="color_type">HSL</span><span class="color_val">');
    
      __out.push(__sanitize(c.hsl.hsl));
    
      __out.push('</span></p>\n      </div>\n\n</section>\n\n\n\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
JST['home'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
    
      __out.push('<section id="track-list" class="track__wrap">\n  <div class="track__model">  <div class="track__image" style="background-image:url()">\n  </div>\n  <audio id="sourcec1" data-track-index="0" src="http://www.tumblr.com/audio_file/jesuisperdu/30884768623/tumblr_m9ud5uvRIG1qzoxl6?plead=please-dont-download-this-or-our-lawyers-wont-let-us-host-audio"></audio>\n</div>\n</section>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
JST['track'] = function(__obj) {
  if (!__obj) __obj = {};
  var __out = [], __capture = function(callback) {
    var out = __out, result;
    __out = [];
    callback.call(this);
    result = __out.join('');
    __out = out;
    return __safe(result);
  }, __sanitize = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else if (typeof value !== 'undefined' && value != null) {
      return __escape(value);
    } else {
      return '';
    }
  }, __safe, __objSafe = __obj.safe, __escape = __obj.escape;
  __safe = __obj.safe = function(value) {
    if (value && value.ecoSafe) {
      return value;
    } else {
      if (!(typeof value !== 'undefined' && value != null)) value = '';
      var result = new String(value);
      result.ecoSafe = true;
      return result;
    }
  };
  if (!__escape) {
    __escape = __obj.escape = function(value) {
      return ('' + value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;');
    };
  }
  (function() {
    (function() {
      var _ref, _ref1;
    
      __out.push('  <div class="track__image" style="background-image:url(');
    
      __out.push(__sanitize((_ref = this.model.get('images')) != null ? (_ref1 = _ref.medium) != null ? _ref1.url : void 0 : void 0));
    
      __out.push(')">\n  </div>\n  <audio id="source');
    
      __out.push(__sanitize(this.model.cid));
    
      __out.push('" data-track-index="');
    
      __out.push(__sanitize(this.model.trackIndex));
    
      __out.push('" src="');
    
      __out.push(__sanitize(this.model.get('object').stream.url));
    
      if (this.model.get('object').stream.platform === 'soundcloud') {
        __out.push(__sanitize('?client_id=YOUR_CLIENT_ID'));
      }
    
      __out.push('" ></audio>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
