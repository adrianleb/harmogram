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
JST['channel'] = function(__obj) {
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
      __out.push('  <div class="track__image" style="background-image:url(');
    
      __out.push(__sanitize(this.model.get('image')));
    
      __out.push(')">\n  </div>\n  <div class="track__info">\n    <h1 class="track__artist">');
    
      __out.push(__sanitize(this.model.get('name')));
    
      __out.push('</h1>\n\n  </div>\n');
    
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
JST['controls'] = function(__obj) {
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
      __out.push('\n<ul class="controls__wrap">\n  <li class="controls__button" > \n    <label for="control-smooth">Fullscreen</label>\n    <input type="checkbox" id="control-fullscreen">\n  </li>\n  <li class="controls__button" > \n    <label for="control-smooth">Centered</label>\n    <input type="checkbox" id="control-centered">\n  </li>\n  <li class="controls__button" > \n    <label for="control-smooth">Smooth</label>\n    <input type="checkbox" id="control-smooth" data-control-switch="smooth">\n  </li>\n  <li class="controls__range">\n    <label for="control-step">Layer</label>\n    <input type="range" data-control-method="gapper" class="" id="control-steps" min=\'1\' max=\'3\' value="1">\n  </li>\n    \n  <li class="controls__section ">\n    <label class="controls__sectitle" for="control-radius">Angle:</label>\n    <div class="controls__button controls--hideswitch" >\n      <label for="control-changeangle">Dynamic Angle</label>\n      <input data-control-switch="changeAngle" type="checkbox" id="control-changeangle">\n    </div>\n    <div class="controls__range controls--hided">\n      <label for="control-angle">Angle Mod Speed</label>\n      <input type="range" data-control-method-value="1" data-control-method="changeAngleSpeed" class="" id="control-anglespeed" min=\'-100\' max=\'100\' value="0">\n    </div>\n    <div class="controls__range controls--tohide">\n      <label for="control-angle">Angle</label>\n      <input type="range" data-control-method-value="1" data-control-method="baseAngle" class="" id="control-angle" min=\'-1000\' max=\'1000\' value="1">\n    </div>\n  </li>\n  <li class="controls__section controls__section--inliner">\n    <label class="controls__sectitle" for="control-radius">Radius:</label>\n    <div class="controls__button controls--hideswitch" >\n      <label for="control-radius-rand">Dynamic Radius</label>\n      <input data-control-switch="changeRadius" type="checkbox" id="control-radius-rand">\n    </div>\n    <div class="controls__range  controls--hided">\n      <label for="control-radius ">Min Amp</label>\n      <input type="range" data-control-method="radiusAmp" data-control-method-value="1" class="" id="control-radius" min=\'-100\' max=\'100\' value="1">\n    </div>\n    <div class="controls__range controls--tohide">\n      <label for="control-radius ">Min</label>\n      <input type="range" data-control-method-value="1" data-control-method="baseRadius" class="" id="control-radius" min=\'-300\' max=\'100\' value="50">\n    </div>\n    <div class="controls__range">\n      <label for="control-amp">Max</label>\n      <input type="range" data-control-method-value="1" data-control-method="ampVal" class="" id="control-amp" min=\'-30\' max=\'30\' value="5">\n    </div>\n  </li>\n\n  \n  <li class="controls__section ">\n    <label class="controls__sectitle" for="control-radius">Color:</label>\n    <div class="controls__button controls--hideswitch" >\n      <label for="control-color-active">Color Path</label>\n      <input data-control-switch="paintAmp" type="checkbox" id="control-color-active">\n    </div>\n    <div class="controls__button controls--hideswitch" >\n      <label for="control-colorbg">Color Background</label>\n      <input data-control-switch="paintBg" type="checkbox" id="control-colorbg">\n    </div>\n    <div class="controls__button controls--hided" >\n      <label for="control-colorbg">Invert</label>\n      <input data-control-switch="colorInvert" type="checkbox" id="control-colorbg">\n    </div>\n    <div class="controls__range controls--hided">\n      <label for="control-hue">Hue</label>\n      <input type="range" data-control-method-value="1" data-control-method="hue" class="" id="control-hue" min=\'0\' max=\'255\' value="42">\n    </div>\n    <div class="controls__range controls--hided">\n      <label for="control-hue">Saturation</label>\n      <input type="range" data-control-method-value="1" data-control-method="colorSat" id="control-hue" min=\'0\' max=\'255\' value="7">\n    </div>\n    <div class="controls__range controls--hided">\n      <label for="control-hue">lightness Amp</label>\n      <input type="range" data-control-method-value="1" data-control-method="colorAmp" id="control-hue" min=\'0\' max=\'300\' value="66">\n    </div>\n    <div class="controls__button controls--hided" >\n      <label for="control-huechanger">Hue Modulation</label>\n      <input data-control-switch="changeHue" type="checkbox" id="control-huechanger">\n    </div>\n  </li>\n\n  \n  <!-- <li class="controls__range"><label for="control-baseoffset">Freq</label><input type="range" data-control-method="baseOffset" class="" id="control-baseoffset" min=\'0\' max=\'300\' value="200"></li> -->\n\n</ul>');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
JST['customTrack'] = function(__obj) {
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
      console.log(this.url, this.index);
    
      __out.push('\n  <div class="track__image">\n  </div>\n  <div class="track__info">\n    <h1 class="track__artist">NN</h1>\n    <h2 class="track__title">NN</h2>\n  </div>\n  <audio id="source');
    
      __out.push(__sanitize(this.index));
    
      __out.push('"  data-track-index="');
    
      __out.push(__sanitize(this.index));
    
      __out.push('" src="');
    
      __out.push(__sanitize(this.url));
    
      __out.push('" ></audio>\n');
    
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
      var _ref, _ref1, _ref2, _ref3;
    
      __out.push('  <div class="track__image" style="background-image:url(');
    
      __out.push(__sanitize((_ref = this.model.get('object').images) != null ? (_ref1 = _ref.medium) != null ? _ref1.url : void 0 : void 0));
    
      __out.push(')">\n    <img id="img_');
    
      __out.push(__sanitize(this.model.trackIndex));
    
      __out.push('"src="');
    
      __out.push(__sanitize((_ref2 = this.model.get('object').images) != null ? (_ref3 = _ref2.medium) != null ? _ref3.url : void 0 : void 0));
    
      __out.push('" alt="">\n  </div>\n  <div class="track__info">\n    <h1 class="track__artist">');
    
      __out.push(__sanitize(this.model.get('object').metadata.artist.name));
    
      __out.push('</h1>\n    <h2 class="track__title">');
    
      __out.push(__sanitize(this.model.get('object').metadata.title));
    
      __out.push('</h2>\n  </div>\n  <audio id="source');
    
      __out.push(__sanitize(this.model.trackIndex));
    
      __out.push('" preload=\'none\' data-track-index="');
    
      __out.push(__sanitize(this.model.trackIndex));
    
      __out.push('" src="');
    
      __out.push(__sanitize(this.model.get('object').stream.url));
    
      __out.push(__sanitize(this.model.get('object').stream.platform === 'soundcloud' ? '?client_id=c280d0c248513cfc78d7ee05b52bf15e' : '?api-key=zlspn5imm91ak2z7nk3g'));
    
      __out.push('" ></audio>\n');
    
    }).call(this);
    
  }).call(__obj);
  __obj.safe = __objSafe, __obj.escape = __escape;
  return __out.join('');
};
