
var hsf = {
// Language strings
lang : {
	cssDirection: 'ltr',
	loadingText : 'Loading...',
	loadingTitle : 'Click to cancel',
	focusTitle : 'Click to bring to front',
	fullExpandTitle : 'Expand to actual size (f)',
	creditsText : '',
	creditsTitle : '',
	previousText : 'Previous',
	nextText : 'Next',
	moveText : 'Move',
	closeText : 'Close',
	closeTitle : 'Close (esc)',
	resizeTitle : 'Resize',
	playText : 'Play',
	playTitle : 'Play slideshow (spacebar)',
	pauseText : 'Pause',
	pauseTitle : 'Pause slideshow (spacebar)',
	previousTitle : 'Previous (arrow left)',
	nextTitle : 'Next (arrow right)',
	moveTitle : 'Move',
	fullExpandText : '1:1',
	number: 'Image %1 of %2',
	restoreTitle : 'Click to close image, click and drag to move. Use arrow keys for next and previous.'
},

graphicsDir : 'highslide/graphics/',
expandCursor : 'zoomin.cur',
restoreCursor : 'zoomout.cur',
expandDuration : 250,
restoreDuration : 250,
marginLeft : 15,
marginRight : 15,
marginTop : 15,
marginBottom : 15,
zIndexCounter : 1001,
loadingOpacity : 0.75,
allowMultipleInstances: true,
numberOfImagesToPreload : 5,
outlineWhileAnimating : 2,
outlineStartOffset : 3,
padToMinWidth : false,
fullExpandPosition : 'bottom right',
fullExpandOpacity : 1,
showCredits : true,
creditsHref : '',
creditsTarget : '_self',
enableKeyListener : true,
openerTagNames : ['a', 'area'],
transitions : [],
transitionDuration: 250,
dimmingOpacity: 0,
dimmingDuration: 50,

allowWidthReduction : false,
allowHeightReduction : true,
preserveContent : true,
objectLoadTime : 'before',
cacheAjax : true,
anchor : 'auto',
align : 'auto',
targetX: null,
targetY: null,
dragByHeading: true,
minWidth: 200,
minHeight: 200,
allowSizeReduction: true,
outlineType : 'drop-shadow',
skin : {
	controls:
		'<div class="highslide-controls"><ul>'+
			'<li class="highslide-previous">'+
				'<a href="#" title="{hsf.lang.previousTitle}">'+
				'<span>{hsf.lang.previousText}</span></a>'+
			'</li>'+
			'<li class="highslide-play">'+
				'<a href="#" title="{hsf.lang.playTitle}">'+
				'<span>{hsf.lang.playText}</span></a>'+
			'</li>'+
			'<li class="highslide-pause">'+
				'<a href="#" title="{hsf.lang.pauseTitle}">'+
				'<span>{hsf.lang.pauseText}</span></a>'+
			'</li>'+
			'<li class="highslide-next">'+
				'<a href="#" title="{hsf.lang.nextTitle}">'+
				'<span>{hsf.lang.nextText}</span></a>'+
			'</li>'+
			'<li class="highslide-move">'+
				'<a href="#" title="{hsf.lang.moveTitle}">'+
				'<span>{hsf.lang.moveText}</span></a>'+
			'</li>'+
			'<li class="highslide-full-expand">'+
				'<a href="#" title="{hsf.lang.fullExpandTitle}">'+
				'<span>{hsf.lang.fullExpandText}</span></a>'+
			'</li>'+
			'<li class="highslide-close">'+
				'<a href="#" title="{hsf.lang.closeTitle}" >'+
				'<span>{hsf.lang.closeText}</span></a>'+
			'</li>'+
		'</ul></div>'
	,
	contentWrapper:
		'<div class="highslide-header"><ul>'+
			'<li class="highslide-previous">'+
				'<a href="#" title="{hsf.lang.previousTitle}" onclick="return hsf.previous(this)">'+
				'<span>{hsf.lang.previousText}</span></a>'+
			'</li>'+
			'<li class="highslide-next">'+
				'<a href="#" title="{hsf.lang.nextTitle}" onclick="return hsf.next(this)">'+
				'<span>{hsf.lang.nextText}</span></a>'+
			'</li>'+
			'<li class="highslide-move">'+
				'<a href="#" title="{hsf.lang.moveTitle}" onclick="return false">'+
				'<span>{hsf.lang.moveText}</span></a>'+
			'</li>'+
			'<li class="highslide-close">'+
				'<a href="#" title="{hsf.lang.closeTitle}" onclick="return hsf.close(this)">'+
				'<span>{hsf.lang.closeText}</span></a>'+
			'</li>'+
		'</ul></div>'+
		'<div class="highslide-body"></div>'+
		'<div class="highslide-footer"><div>'+
			'<span class="highslide-resize" title="{hsf.lang.resizeTitle}"><span></span></span>'+
		'</div></div>'
},
// END OF YOUR SETTINGS


// declare internal properties
preloadTheseImages : [],
continuePreloading: true,
expanders : [],
overrides : [
	'allowSizeReduction',
	'useBox',
	'anchor',
	'align',
	'targetX',
	'targetY',
	'outlineType',
	'outlineWhileAnimating',
	'captionId',
	'captionText',
	'captionEval',
	'captionOverlay',
	'headingId',
	'headingText',
	'headingEval',
	'headingOverlay',
	'creditsPosition',
	'dragByHeading',
	'autoplay',
	'numberPosition',
	'transitions',
	'dimmingOpacity',

	'width',
	'height',

	'contentId',
	'allowWidthReduction',
	'allowHeightReduction',
	'preserveContent',
	'maincontentId',
	'maincontentText',
	'maincontentEval',
	'objectType',
	'cacheAjax',
	'objectWidth',
	'objectHeight',
	'objectLoadTime',
	'swfOptions',
	'wrapperClassName',
	'minWidth',
	'minHeight',
	'maxWidth',
	'maxHeight',
	'slideshowGroup',
	'easing',
	'easingClose',
	'fadeInOut',
	'src'
],
overlays : [],
idCounter : 0,
oPos : {
	x: ['leftpanel', 'left', 'center', 'right', 'rightpanel'],
	y: ['above', 'top', 'middle', 'bottom', 'below']
},
mouse: {},
headingOverlay: {},
captionOverlay: {},
swfOptions: { flashvars: {}, params: {}, attributes: {} },
timers : [],

slideshows : [],

pendingOutlines : {},
sleeping : [],
preloadTheseAjax : [],
cacheBindings : [],
cachedGets : {},
clones : {},
onReady: [],
uaVersion: parseFloat((navigator.userAgent.toLowerCase().match( /.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/ ) || [0,'0'])[1]),
ie : (document.all && !window.opera),
safari : /Safari/.test(navigator.userAgent),
geckoMac : /Macintosh.+rv:1\.[0-8].+Gecko/.test(navigator.userAgent),

$ : function (id) {
	if (id) return document.getElementById(id);
},

push : function (arr, val) {
	arr[arr.length] = val;
},

createElement : function (tag, attribs, styles, parent, nopad) {
	var el = document.createElement(tag);
	if (attribs) hsf.extend(el, attribs);
	if (nopad) hsf.setStyles(el, {padding: 0, border: 'none', margin: 0});
	if (styles) hsf.setStyles(el, styles);
	if (parent) parent.appendChild(el);
	return el;
},

extend : function (el, attribs) {
	for (var x in attribs) el[x] = attribs[x];
	return el;
},

setStyles : function (el, styles) {
	for (var x in styles) {
		if (hsf.ie && x == 'opacity') {
			if (styles[x] > 0.99) el.style.removeAttribute('filter');
			else el.style.filter = 'alpha(opacity='+ (styles[x] * 100) +')';
		}
		else el.style[x] = styles[x];
	}
},
animate: function(el, prop, opt) {
	var start,
		end,
		unit;
	if (typeof opt != 'object' || opt === null) {
		var args = arguments;
		opt = {
			duration: args[2],
			easing: args[3],
			complete: args[4]
		};
	}
	if (typeof opt.duration != 'number') opt.duration = 250;
	opt.easing = Math[opt.easing] || Math.easeInQuad;
	opt.curAnim = hsf.extend({}, prop);
	for (var name in prop) {
		var e = new hsf.fx(el, opt , name );

		start = parseFloat(hsf.css(el, name)) || 0;
		end = parseFloat(prop[name]);
		unit = name != 'opacity' ? 'px' : '';

		e.custom( start, end, unit );
	}
},
css: function(el, prop) {
	if (document.defaultView) {
		return document.defaultView.getComputedStyle(el, null).getPropertyValue(prop);

	} else {
		if (prop == 'opacity') prop = 'filter';
		var val = el.currentStyle[prop.replace(/\-(\w)/g, function (a, b){ return b.toUpperCase(); })];
		if (prop == 'filter')
			val = val.replace(/alpha\(opacity=([0-9]+)\)/,
				function (a, b) { return b / 100 });
		return val === '' ? 1 : val;
	}
},

getPageSize : function () {
	var d = document, w = window, iebody = d.compatMode && d.compatMode != 'BackCompat'
		? d.documentElement : d.body;


	var b = d.body;
	var xScroll = (w.innerWidth && w.scrollMaxX)
			? w.innerWidth + w.scrollMaxX : Math.max(b.scrollWidth, b.offsetWidth),
		yScroll = (w.innerHeight && window.scrollMaxY)
			? w.innerHeight + w.scrollMaxY : Math.max(b.scrollHeight, b.offsetHeight),
		pageWidth = hsf.ie ? iebody.scrollWidth :
			(d.documentElement.clientWidth || self.innerWidth),
      	pageHeight = hsf.ie ? Math.max(iebody.scrollHeight, iebody.clientHeight) :
			(d.documentElement.clientHeight || self.innerHeight);

	var width = hsf.ie ? iebody.clientWidth :
			(d.documentElement.clientWidth || self.innerWidth),
		height = hsf.ie ? iebody.clientHeight : self.innerHeight;

	hsf.page = {
		pageWidth: Math.max(pageWidth, xScroll),
		pageHeight: Math.max(pageHeight, yScroll),
		width: width,
		height: height,
		scrollLeft: hsf.ie ? iebody.scrollLeft : pageXOffset,
		scrollTop: hsf.ie ? iebody.scrollTop : pageYOffset
	}
},

getPosition : function(el)	{
	if (/area/i.test(el.tagName)) {
		var imgs = document.getElementsByTagName('img');
		for (var i = 0; i < imgs.length; i++) {
			var u = imgs[i].useMap;
			if (u && u.replace(/^.*?#/, '') == el.parentNode.name) {
				el = imgs[i];
				break;
			}
		}
	}
	var p = { x: el.offsetLeft, y: el.offsetTop };
	while (el.offsetParent)	{
		el = el.offsetParent;
		p.x += el.offsetLeft;
		p.y += el.offsetTop;
		if (el != document.body && el != document.documentElement) {
			p.x -= el.scrollLeft;
			p.y -= el.scrollTop;
		}
	}
	return p;
},

expand : function(a, params, custom, type) {
	if (!a) a = hsf.createElement('a', null, { display: 'none' }, hsf.container);
	if (typeof a.getParams == 'function') return params;
	if (type == 'html') {
		for (var i = 0; i < hsf.sleeping.length; i++) {
			if (hsf.sleeping[i] && hsf.sleeping[i].a == a) {
				hsf.sleeping[i].awake();
				hsf.sleeping[i] = null;
				return false;
			}
		}
		hsf.hasHtmlExpanders = true;
	}
	try {
		new hsf.Expander(a, params, custom, type);
		return false;
	} catch (e) { return true; }
},

htmlExpand : function(a, params, custom) {
	return hsf.expand(a, params, custom, 'html');
},

getSelfRendered : function() {
	return hsf.createElement('div', {
		className: 'highslide-html-content',
		innerHTML: hsf.replaceLang(hsf.skin.contentWrapper)
	});
},
getElementByClass : function (el, tagName, className) {
	var els = el.getElementsByTagName(tagName);
	for (var i = 0; i < els.length; i++) {
    	if ((new RegExp(className)).test(els[i].className)) {
			return els[i];
		}
	}
	return null;
},
replaceLang : function(s) {
	s = s.replace(/\s/g, ' ');
	var re = /{hs\.lang\.([^}]+)\}/g,
		matches = s.match(re),
		lang;
	if (matches) for (var i = 0; i < matches.length; i++) {
		lang = matches[i].replace(re, "$1");
		if (typeof hsf.lang[lang] != 'undefined') s = s.replace(matches[i], hsf.lang[lang]);
	}
	return s;
},


setClickEvents : function () {
	var els = document.getElementsByTagName('a');
	for (var i = 0; i < els.length; i++) {
		var type = hsf.isUnobtrusiveAnchor(els[i]);
		if (type && !els[i].hsHasSetClick) {
			(function(){
				var t = type;
				if (hsf.fireEvent(hs, 'onSetClickEvent', { element: els[i], type: t })) {
					els[i].onclick =(type == 'image') ?function() { return hsf.expand(this) }:
						function() { return hsf.htmlExpand(this, { objectType: t } );};
				}
			})();
			els[i].hsHasSetClick = true;
		}
	}
	hsf.getAnchors();
},
isUnobtrusiveAnchor: function(el) {
	if (el.rel == 'highslide') return 'image';
	else if (el.rel == 'highslide-ajax') return 'ajax';
	else if (el.rel == 'highslide-iframe') return 'iframe';
	else if (el.rel == 'highslide-swf') return 'swf';
},

getCacheBinding : function (a) {
	for (var i = 0; i < hsf.cacheBindings.length; i++) {
		if (hsf.cacheBindings[i][0] == a) {
			var c = hsf.cacheBindings[i][1];
			hsf.cacheBindings[i][1] = c.cloneNode(1);
			return c;
		}
	}
	return null;
},

preloadAjax : function (e) {
	var arr = hsf.getAnchors();
	for (var i = 0; i < arr.htmls.length; i++) {
		var a = arr.htmls[i];
		if (hsf.getParam(a, 'objectType') == 'ajax' && hsf.getParam(a, 'cacheAjax'))
			hsf.push(hsf.preloadTheseAjax, a);
	}

	hsf.preloadAjaxElement(0);
},

preloadAjaxElement : function (i) {
	if (!hsf.preloadTheseAjax[i]) return;
	var a = hsf.preloadTheseAjax[i];
	var cache = hsf.getNode(hsf.getParam(a, 'contentId'));
	if (!cache) cache = hsf.getSelfRendered();
	var ajax = new hsf.Ajax(a, cache, 1);
   	ajax.onError = function () { };
   	ajax.onLoad = function () {
   		hsf.push(hsf.cacheBindings, [a, cache]);
   		hsf.preloadAjaxElement(i + 1);
   	};
   	ajax.run();
},

focusTopmost : function() {
	var topZ = 0,
		topmostKey = -1,
		expanders = hsf.expanders,
		exp,
		zIndex;
	for (var i = 0; i < expanders.length; i++) {
		exp = expanders[i];
		if (exp) {
			zIndex = exp.wrapper.style.zIndex;
			if (zIndex && zIndex > topZ) {
				topZ = zIndex;
				topmostKey = i;
			}
		}
	}
	if (topmostKey == -1) hsf.focusKey = -1;
	else expanders[topmostKey].focus();
},

getParam : function (a, param) {
	a.getParams = a.onclick;
	var p = a.getParams ? a.getParams() : null;
	a.getParams = null;

	return (p && typeof p[param] != 'undefined') ? p[param] :
		(typeof hsf[param] != 'undefined' ? hsf[param] : null);
},

getSrc : function (a) {
	var src = hsf.getParam(a, 'src');
	if (src) return src;
	return a.href;
},

getNode : function (id) {
	var node = hsf.$(id), clone = hsf.clones[id], a = {};
	if (!node && !clone) return null;
	if (!clone) {
		clone = node.cloneNode(true);
		clone.id = '';
		hsf.clones[id] = clone;
		return node;
	} else {
		return clone.cloneNode(true);
	}
},

discardElement : function(d) {
	if (d) hsf.garbageBin.appendChild(d);
	hsf.garbageBin.innerHTML = '';
},
dim : function(exp) {
	if (!hsf.dimmer) {
		hsf.dimmer = hsf.createElement ('div',
			{
				className: 'highslide-dimming',
				owner: '',
				onclick: function() {
					if (hsf.fireEvent(hs, 'onDimmerClick'))

						hsf.close();
				}
			}, {
				position: 'absolute',
				visibility: 'visible',
				left: 0,
				opacity: 0
			}, hsf.container, true);
		hsf.addEventListener(window, 'resize', hsf.setDimmerSize);
	}
	hsf.dimmer.style.display = '';
	hsf.setDimmerSize();
	hsf.dimmer.owner += '|'+ exp.key;
	if (hsf.geckoMac && hsf.dimmingGeckoFix)
		hsf.setStyles(hsf.dimmer, {
			background: 'url('+ hsf.graphicsDir + 'geckodimmer.png)',
			opacity: 1
		});
	else
		hsf.animate(hsf.dimmer, { opacity: exp.dimmingOpacity }, hsf.dimmingDuration);
},
undim : function(key) {
	if (!hsf.dimmer) return;
	if (typeof key != 'undefined') hsf.dimmer.owner = hsf.dimmer.owner.replace('|'+ key, '');

	if (
		(typeof key != 'undefined' && hsf.dimmer.owner != '')
		|| (hsf.upcoming && hsf.getParam(hsf.upcoming, 'dimmingOpacity'))
	) return;
	if (hsf.geckoMac && hsf.dimmingGeckoFix)
		hsf.setStyles(hsf.dimmer, { background: 'none', width: 0, height: 0 });
	else hsf.animate(hsf.dimmer, { opacity: 0 }, hsf.dimmingDuration, null, function() {
		hsf.setStyles(hsf.dimmer, { display: 'none', width: 0, height: 0 });
	});
},
setDimmerSize : function(exp) {
	hsf.getPageSize();
	if (!hsf.dimmer) return;
	var h = (hsf.ie && exp && exp.wrapper) ?
		parseInt(exp.wrapper.style.top) + parseInt(exp.wrapper.style.height)+ (exp.outline ? exp.outline.offset : 0) : 0;
	hsf.setStyles(hsf.dimmer, {
		width: hsf.page.pageWidth +'px',
		height: Math.max(hsf.page.pageHeight, h) +'px'
	});
},
transit : function (adj, exp) {
	var last = exp = exp || hsf.getExpander();
	if (hsf.upcoming) return false;
	else hsf.last = last;
	try {
		hsf.upcoming = adj;
		adj.onclick();
	} catch (e){
		hsf.last = hsf.upcoming = null;
	}
	try {
		if (!adj || exp.transitions[1] != 'crossfade')
		exp.close();
	} catch (e) {}
	return false;
},

previousOrNext : function (el, op) {
	var exp = hsf.getExpander(el);
	if (exp) {
		adj = exp.getAdjacentAnchor(op);
		return hsf.transit(adj, exp);
	} else return false;
},

previous : function (el) {
	return hsf.previousOrNext(el, -1);
},

next : function (el) {
	return hsf.previousOrNext(el, 1);
},

keyHandler : function(e) {
	if (!e) e = window.event;
	if (!e.target) e.target = e.srcElement; // ie
	if (typeof e.target.form != 'undefined') return true; // form element has focus
	if (!hsf.fireEvent(hs, 'onKeyDown', e)) return true;
	var exp = hsf.getExpander();

	var op = null;
	switch (e.keyCode) {
		case 70: // f
			if (exp) exp.doFullExpand();
			return true;
		case 32: // Space
			op = 2;
			break;
		case 34: // Page Down
		case 39: // Arrow right
		case 40: // Arrow down
			op = 1;
			break;
		case 8:  // Backspace
		case 33: // Page Up
		case 37: // Arrow left
		case 38: // Arrow up
			op = -1;
			break;
		case 27: // Escape
		case 13: // Enter
			op = 0;
	}
	if (op !== null) {if (op != 2)hsf.removeEventListener(document, window.opera ? 'keypress' : 'keydown', hsf.keyHandler);
		if (!hsf.enableKeyListener) return true;

		if (e.preventDefault) e.preventDefault();
    	else e.returnValue = false;
    	if (exp) {
			if (op == 0) {
				exp.close();
			} else if (op == 2) {
				if (exp.slideshow) exp.slideshow.hitSpace();
			} else {
				if (exp.slideshow) exp.slideshow.pause();
				hsf.previousOrNext(exp.key, op);
			}
			return false;
		}
	}
	return true;
},


registerOverlay : function (overlay) {
	hsf.push(hsf.overlays, hsf.extend(overlay, { hsId: 'hsId'+ hsf.idCounter++ } ));
},


addSlideshow : function (options) {
	var sg = options.slideshowGroup;
	if (typeof sg == 'object') {
		for (var i = 0; i < sg.length; i++) {
			var o = {};
			for (var x in options) o[x] = options[x];
			o.slideshowGroup = sg[i];
			hsf.push(hsf.slideshows, o);
		}
	} else {
		hsf.push(hsf.slideshows, options);
	}
},

getWrapperKey : function (element, expOnly) {
	var el, re = /^highslide-wrapper-([0-9]+)$/;
	// 1. look in open expanders
	el = element;
	while (el.parentNode)	{
		if (el.hsKey !== undefined) return el.hsKey;
		if (el.id && re.test(el.id)) return el.id.replace(re, "$1");
		el = el.parentNode;
	}
	// 2. look in thumbnail
	if (!expOnly) {
		el = element;
		while (el.parentNode)	{
			if (el.tagName && hsf.isHsAnchor(el)) {
				for (var key = 0; key < hsf.expanders.length; key++) {
					var exp = hsf.expanders[key];
					if (exp && exp.a == el) return key;
				}
			}
			el = el.parentNode;
		}
	}
	return null;
},

getExpander : function (el, expOnly) {
	if (typeof el == 'undefined') return hsf.expanders[hsf.focusKey] || null;
	if (typeof el == 'number') return hsf.expanders[el] || null;
	if (typeof el == 'string') el = hsf.$(el);
	return hsf.expanders[hsf.getWrapperKey(el, expOnly)] || null;
},

isHsAnchor : function (a) {
	return (a.onclick && a.onclick.toString().replace(/\s/g, ' ').match(/hsf.(htmlE|e)xpand/));
},

reOrder : function () {
	for (var i = 0; i < hsf.expanders.length; i++)
		if (hsf.expanders[i] && hsf.expanders[i].isExpanded) hsf.focusTopmost();
},
fireEvent : function (obj, evt, args) {
	return obj && obj[evt] ? (obj[evt](obj, args) !== false) : true;
},

mouseClickHandler : function(e)
{
	if (!e) e = window.event;
	if (e.button > 1) return true;
	if (!e.target) e.target = e.srcElement;

	var el = e.target;
	while (el.parentNode
		&& !(/highslide-(image|move|html|resize)/.test(el.className)))
	{
		el = el.parentNode;
	}
	var exp = hsf.getExpander(el);
	if (exp && (exp.isClosing || !exp.isExpanded)) return true;

	if (exp && e.type == 'mousedown') {
		if (e.target.form) return true;
		var match = el.className.match(/highslide-(image|move|resize)/);
		if (match) {
			hsf.dragArgs = { exp: exp , type: match[1], left: exp.x.pos, width: exp.x.size, top: exp.y.pos,
				height: exp.y.size, clickX: e.clientX, clickY: e.clientY };


			hsf.addEventListener(document, 'mousemove', hsf.dragHandler);
			if (e.preventDefault) e.preventDefault(); // FF

			if (/highslide-(image|html)-blur/.test(exp.content.className)) {
				exp.focus();
				hsf.hasFocused = true;
			}
			return false;
		}
		else if (/highslide-html/.test(el.className) && hsf.focusKey != exp.key) {
			exp.focus();
			exp.doShowHide('hidden');
		}
	} else if (e.type == 'mouseup') {

		hsf.removeEventListener(document, 'mousemove', hsf.dragHandler);

		if (hsf.dragArgs) {
			if (hsf.styleRestoreCursor && hsf.dragArgs.type == 'image')
				hsf.dragArgs.exp.content.style.cursor = hsf.styleRestoreCursor;
			var hasDragged = hsf.dragArgs.hasDragged;

			if (!hasDragged &&!hsf.hasFocused && !/(move|resize)/.test(hsf.dragArgs.type)) {
				if (hsf.fireEvent(exp, 'onImageClick'))
				exp.close();
			}
			else if (hasDragged || (!hasDragged && hsf.hasHtmlExpanders)) {
				hsf.dragArgs.exp.doShowHide('hidden');
			}

			if (hsf.dragArgs.exp.releaseMask)
				hsf.dragArgs.exp.releaseMask.style.display = 'none';

			if (hasDragged) hsf.fireEvent(hsf.dragArgs.exp, 'onDrop', hsf.dragArgs);
			if (hasDragged) hsf.setDimmerSize(exp);

			hsf.hasFocused = false;
			hsf.dragArgs = null;

		} else if (/highslide-image-blur/.test(el.className)) {
			el.style.cursor = hsf.styleRestoreCursor;
		}
	}
	return false;
},

dragHandler : function(e)
{
	if (!hsf.dragArgs) return true;
	if (!e) e = window.event;
	var a = hsf.dragArgs, exp = a.exp;
	if (exp.iframe) {
		if (!exp.releaseMask) exp.releaseMask = hsf.createElement('div', null,
			{ position: 'absolute', width: exp.x.size+'px', height: exp.y.size+'px',
				left: exp.x.cb+'px', top: exp.y.cb+'px', zIndex: 4,	background: (hsf.ie ? 'white' : 'none'),
				opacity: .01 },
			exp.wrapper, true);
		if (exp.releaseMask.style.display == 'none')
			exp.releaseMask.style.display = '';
	}

	a.dX = e.clientX - a.clickX;
	a.dY = e.clientY - a.clickY;

	var distance = Math.sqrt(Math.pow(a.dX, 2) + Math.pow(a.dY, 2));
	if (!a.hasDragged) a.hasDragged = (a.type != 'image' && distance > 0)
		|| (distance > (hsf.dragSensitivity || 5));

	if (a.hasDragged && e.clientX > 5 && e.clientY > 5) {
		if (!hsf.fireEvent(exp, 'onDrag', a)) return false;

		if (a.type == 'resize') exp.resize(a);
		else {
			exp.moveTo(a.left + a.dX, a.top + a.dY);
			if (a.type == 'image') exp.content.style.cursor = 'move';
		}
	}
	return false;
},

wrapperMouseHandler : function (e) {
	try {
		if (!e) e = window.event;
		var over = /mouseover/i.test(e.type);
		if (!e.target) e.target = e.srcElement; // ie
		if (hsf.ie) e.relatedTarget =
			over ? e.fromElement : e.toElement; // ie
		var exp = hsf.getExpander(e.target);
		if (!exp.isExpanded) return;
		if (!exp || !e.relatedTarget || hsf.getExpander(e.relatedTarget, true) == exp
			|| hsf.dragArgs) return;
		hsf.fireEvent(exp, over ? 'onMouseOver' : 'onMouseOut', e);
		for (var i = 0; i < exp.overlays.length; i++) (function() {
			var o = hsf.$('hsId'+ exp.overlays[i]);
			if (o && o.hideOnMouseOut) {
				if (over) hsf.setStyles(o, { visibility: 'visible', display: '' });
				hsf.animate(o, { opacity: over ? o.opacity : 0 }, o.dur);
			}
		})();
	} catch (e) {}
},
addEventListener : function (el, event, func) {
	if (el == document && event == 'ready') hsf.push(hsf.onReady, func);
	try {
		el.addEventListener(event, func, false);
	} catch (e) {
		try {
			el.detachEvent('on'+ event, func);
			el.attachEvent('on'+ event, func);
		} catch (e) {
			el['on'+ event] = func;
		}
	}
},

removeEventListener : function (el, event, func) {
	try {
		el.removeEventListener(event, func, false);
	} catch (e) {
		try {
			el.detachEvent('on'+ event, func);
		} catch (e) {
			el['on'+ event] = null;
		}
	}
},

preloadFullImage : function (i) {
	if (hsf.continuePreloading && hsf.preloadTheseImages[i] && hsf.preloadTheseImages[i] != 'undefined') {
		var img = document.createElement('img');
		img.onload = function() {
			img = null;
			hsf.preloadFullImage(i + 1);
		};
		img.src = hsf.preloadTheseImages[i];
	}
},
preloadImages : function (number) {
	if (number && typeof number != 'object') hsf.numberOfImagesToPreload = number;

	var arr = hsf.getAnchors();
	for (var i = 0; i < arr.images.length && i < hsf.numberOfImagesToPreload; i++) {
		hsf.push(hsf.preloadTheseImages, hsf.getSrc(arr.images[i]));
	}

	// preload outlines
	if (hsf.outlineType)	new hsf.Outline(hsf.outlineType, function () { hsf.preloadFullImage(0)} );
	else

	hsf.preloadFullImage(0);

	// preload cursor
	if (hsf.restoreCursor) var cur = hsf.createElement('img', { src: hsf.graphicsDir + hsf.restoreCursor });
},


init : function () {
	if (!hsf.container) {

		hsf.getPageSize();
		hsf.ieLt7 = hsf.ie && hsf.uaVersion < 7;
		hsf.ie6SSL = hsf.ieLt7 && location.protocol == 'https:';
		for (var x in hsf.langDefaults) {
			if (typeof hsf[x] != 'undefined') hsf.lang[x] = hsf[x];
			else if (typeof hsf.lang[x] == 'undefined' && typeof hsf.langDefaults[x] != 'undefined')
				hsf.lang[x] = hsf.langDefaults[x];
		}

		hsf.container = hsf.createElement('div', {
				className: 'highslide-container'
			}, {
				position: 'absolute',
				left: 0,
				top: 0,
				width: '100%',
				zIndex: hsf.zIndexCounter,
				direction: 'ltr'
			},
			document.body,
			true
		);
		hsf.loading = hsf.createElement('a', {
				className: 'highslide-loading',
				title: hsf.lang.loadingTitle,
				innerHTML: hsf.lang.loadingText,
				href: 'javascript:;'
			}, {
				position: 'absolute',
				top: '-9999px',
				opacity: hsf.loadingOpacity,
				zIndex: 1
			}, hsf.container
		);
		hsf.garbageBin = hsf.createElement('div', null, { display: 'none' }, hsf.container);
		hsf.viewport = hsf.createElement('div', {
				className: 'highslide-viewport'
			}, {
				visibility: (hsf.safari && hsf.uaVersion < 525) ? 'visible' : 'hidden'
			}, hsf.container, 1
		);
		hsf.clearing = hsf.createElement('div', null,
			{ clear: 'both', paddingTop: '1px' }, null, true);

		// http://www.robertpenner.com/easing/
		Math.linearTween = function (t, b, c, d) {
			return c*t/d + b;
		};
		Math.easeInQuad = function (t, b, c, d) {
			return c*(t/=d)*t + b;
		};
		Math.easeOutQuad = function (t, b, c, d) {
			return -c *(t/=d)*(t-2) + b;
		};

		hsf.hideSelects = hsf.ieLt7;
		hsf.hideIframes = ((window.opera && hsf.uaVersion < 9) || navigator.vendor == 'KDE'
			|| (hsf.ie && hsf.uaVersion < 5.5));
		hsf.fireEvent(this, 'onActivate');
	}
},
ready : function() {
	if (hsf.isReady) return;
	hsf.isReady = true;

	for (var i = 0; i < hsf.onReady.length; i++) hsf.onReady[i]();
},

updateAnchors : function() {
	var el, els, all = [], images = [], htmls = [],groups = {}, re;

	for (var i = 0; i < hsf.openerTagNames.length; i++) {
		els = document.getElementsByTagName(hsf.openerTagNames[i]);
		for (var j = 0; j < els.length; j++) {
			el = els[j];
			re = hsf.isHsAnchor(el);
			if (re) {
				hsf.push(all, el);
				if (re[0] == 'hsf.expand') hsf.push(images, el);
				else if (re[0] == 'hsf.htmlExpand') hsf.push(htmls, el);
				var g = hsf.getParam(el, 'slideshowGroup') || 'none';
				if (!groups[g]) groups[g] = [];
				hsf.push(groups[g], el);
			}
		}
	}
	hsf.anchors = { all: all, groups: groups, images: images, htmls: htmls };
	return hsf.anchors;

},

getAnchors : function() {
	return hsf.anchors || hsf.updateAnchors();
},


close : function(el) {
	var exp = hsf.getExpander(el);
	if (exp) exp.close();
	return false;
}
}; // end hs object
hsf.fx = function( elem, options, prop ){
	this.options = options;
	this.elem = elem;
	this.prop = prop;

	if (!options.orig) options.orig = {};
};
hsf.fx.prototype = {
	update: function(){
		(hsf.fx.step[this.prop] || hsf.fx.step._default)(this);

		if (this.options.step)
			this.options.step.call(this.elem, this.now, this);

	},
	custom: function(from, to, unit){
		this.startTime = (new Date()).getTime();
		this.start = from;
		this.end = to;
		this.unit = unit;// || this.unit || "px";
		this.now = this.start;
		this.pos = this.state = 0;

		var self = this;
		function t(gotoEnd){
			return self.step(gotoEnd);
		}

		t.elem = this.elem;

		if ( t() && hsf.timers.push(t) == 1 ) {
			hsf.timerId = setInterval(function(){
				var timers = hsf.timers;

				for ( var i = 0; i < timers.length; i++ )
					if ( !timers[i]() )
						timers.splice(i--, 1);

				if ( !timers.length ) {
					clearInterval(hsf.timerId);
				}
			}, 13);
		}
	},
	step: function(gotoEnd){
		var t = (new Date()).getTime();
		if ( gotoEnd || t >= this.options.duration + this.startTime ) {
			this.now = this.end;
			this.pos = this.state = 1;
			this.update();

			this.options.curAnim[ this.prop ] = true;

			var done = true;
			for ( var i in this.options.curAnim )
				if ( this.options.curAnim[i] !== true )
					done = false;

			if ( done ) {
				if (this.options.complete) this.options.complete.call(this.elem);
			}
			return false;
		} else {
			var n = t - this.startTime;
			this.state = n / this.options.duration;
			this.pos = this.options.easing(n, 0, 1, this.options.duration);
			this.now = this.start + ((this.end - this.start) * this.pos);
			this.update();
		}
		return true;
	}

};

hsf.extend( hsf.fx, {
	step: {

		opacity: function(fx){
			hsf.setStyles(fx.elem, { opacity: fx.now });
		},

		_default: function(fx){
			if ( fx.elem.style && fx.elem.style[ fx.prop ] != null )
				fx.elem.style[ fx.prop ] = fx.now + fx.unit;
			else
				fx.elem[ fx.prop ] = fx.now;
		}
	}
});

hsf.Outline =  function (outlineType, onLoad) {
	this.onLoad = onLoad;
	this.outlineType = outlineType;
	var v = hsf.uaVersion, tr;

	this.hasAlphaImageLoader = hsf.ie && v >= 5.5 && v < 7;
	if (!outlineType) {
		if (onLoad) onLoad();
		return;
	}

	hsf.init();
	this.table = hsf.createElement(
		'table', {
			cellSpacing: 0
		}, {
			visibility: 'hidden',
			position: 'absolute',
			borderCollapse: 'collapse',
			width: 0
		},
		hsf.container,
		true
	);
	var tbody = hsf.createElement('tbody', null, null, this.table, 1);

	this.td = [];
	for (var i = 0; i <= 8; i++) {
		if (i % 3 == 0) tr = hsf.createElement('tr', null, { height: 'auto' }, tbody, true);
		this.td[i] = hsf.createElement('td', null, null, tr, true);
		var style = i != 4 ? { lineHeight: 0, fontSize: 0} : { position : 'relative' };
		hsf.setStyles(this.td[i], style);
	}
	this.td[4].className = outlineType +' highslide-outline';

	this.preloadGraphic();
};

hsf.Outline.prototype = {
preloadGraphic : function () {
	var src = hsf.graphicsDir + (hsf.outlinesDir || "outlines/")+ this.outlineType +".png";

	var appendTo = hsf.safari ? hsf.container : null;
	this.graphic = hsf.createElement('img', null, { position: 'absolute',
		top: '-9999px' }, appendTo, true); // for onload trigger

	var pThis = this;
	this.graphic.onload = function() { pThis.onGraphicLoad(); };

	this.graphic.src = src;
},

onGraphicLoad : function () {
	var o = this.offset = this.graphic.width / 4,
		pos = [[0,0],[0,-4],[-2,0],[0,-8],0,[-2,-8],[0,-2],[0,-6],[-2,-2]],
		dim = { height: (2*o) +'px', width: (2*o) +'px' };
	for (var i = 0; i <= 8; i++) {
		if (pos[i]) {
			if (this.hasAlphaImageLoader) {
				var w = (i == 1 || i == 7) ? '100%' : this.graphic.width +'px';
				var div = hsf.createElement('div', null, { width: '100%', height: '100%', position: 'relative', overflow: 'hidden'}, this.td[i], true);
				hsf.createElement ('div', null, {
						filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale, src='"+ this.graphic.src + "')",
						position: 'absolute',
						width: w,
						height: this.graphic.height +'px',
						left: (pos[i][0]*o)+'px',
						top: (pos[i][1]*o)+'px'
					},
				div,
				true);
			} else {
				hsf.setStyles(this.td[i], { background: 'url('+ this.graphic.src +') '+ (pos[i][0]*o)+'px '+(pos[i][1]*o)+'px'});
			}

			if (window.opera && (i == 3 || i ==5))
				hsf.createElement('div', null, dim, this.td[i], true);

			hsf.setStyles (this.td[i], dim);
		}
	}
	this.graphic = null;
	if (hsf.pendingOutlines[this.outlineType]) hsf.pendingOutlines[this.outlineType].destroy();
	hsf.pendingOutlines[this.outlineType] = this;
	if (this.onLoad) this.onLoad();
},

setPosition : function (pos, offset, vis, dur, easing) {
	var exp = this.exp,
		stl = exp.wrapper.style,
		offset = offset || 0,
		pos = pos || {
			x: exp.x.pos + offset,
			y: exp.y.pos + offset,
			w: exp.x.get('wsize') - 2 * offset,
			h: exp.y.get('wsize') - 2 * offset
		};
	if (vis) this.table.style.visibility = (pos.h >= 4 * this.offset)
		? 'visible' : 'hidden';
	hsf.setStyles(this.table, {
		left: (pos.x - this.offset) +'px',
		top: (pos.y - this.offset) +'px',
		width: (pos.w + 2 * this.offset) +'px'
	});

	pos.w -= 2 * this.offset;
	pos.h -= 2 * this.offset;
	hsf.setStyles (this.td[4], {
		width: pos.w >= 0 ? pos.w +'px' : 0,
		height: pos.h >= 0 ? pos.h +'px' : 0
	});
	if (this.hasAlphaImageLoader) this.td[3].style.height
		= this.td[5].style.height = this.td[4].style.height;

},

destroy : function(hide) {
	if (hide) this.table.style.visibility = 'hidden';
	else hsf.discardElement(this.table);
}
};

hsf.Dimension = function(exp, dim) {
	this.exp = exp;
	this.dim = dim;
	this.ucwh = dim == 'x' ? 'Width' : 'Height';
	this.wh = this.ucwh.toLowerCase();
	this.uclt = dim == 'x' ? 'Left' : 'Top';
	this.lt = this.uclt.toLowerCase();
	this.ucrb = dim == 'x' ? 'Right' : 'Bottom';
	this.rb = this.ucrb.toLowerCase();
	this.p1 = this.p2 = 0;
};
hsf.Dimension.prototype = {
get : function(key) {
	switch (key) {
		case 'loadingPos':
			return this.tpos + this.tb + (this.t - hsf.loading['offset'+ this.ucwh]) / 2;
		case 'loadingPosXfade':
			return this.pos + this.cb+ this.p1 + (this.size - hsf.loading['offset'+ this.ucwh]) / 2;
		case 'wsize':
			return this.size + 2 * this.cb + this.p1 + this.p2;
		case 'fitsize':
			return this.clientSize - this.marginMin - this.marginMax;
		case 'maxsize':
			return this.get('fitsize') - 2 * this.cb - this.p1 - this.p2 ;
		case 'opos':
			return this.pos - (this.exp.outline ? this.exp.outline.offset : 0);
		case 'osize':
			return this.get('wsize') + (this.exp.outline ? 2*this.exp.outline.offset : 0);
		case 'imgPad':
			return this.imgSize ? Math.round((this.size - this.imgSize) / 2) : 0;

	}
},
calcBorders: function() {
	// correct for borders
	this.cb = (this.exp.content['offset'+ this.ucwh] - this.t) / 2;
	this.marginMax = hsf['margin'+ this.ucrb];
},
calcThumb: function() {
	this.t = this.exp.el[this.wh] ? parseInt(this.exp.el[this.wh]) :
		this.exp.el['offset'+ this.ucwh];
	this.tpos = this.exp.tpos[this.dim];
	this.tb = (this.exp.el['offset'+ this.ucwh] - this.t) / 2;
	if (this.tpos < 1) {
		this.tpos = (hsf.page[this.wh] / 2) + hsf.page['scroll'+ this.uclt];
	};
},
calcExpanded: function() {
	var exp = this.exp;
	this.justify = 'auto';

	// get alignment
	if (exp.align == 'center') this.justify = 'center';
	else if (new RegExp(this.lt).test(exp.anchor)) this.justify = null;
	else if (new RegExp(this.rb).test(exp.anchor)) this.justify = 'max';


	// size and position
	this.pos = this.tpos - this.cb + this.tb;
	this.size = Math.min(this.full, exp['max'+ this.ucwh] || this.full);
	this.minSize = exp.allowSizeReduction ?
		Math.min(exp['min'+ this.ucwh], this.full) :this.full;
	if (exp.isImage && exp.useBox)	{
		this.size = exp[this.wh];
		this.imgSize = this.full;
	}
	if (this.dim == 'x' && hsf.padToMinWidth) this.minSize = exp.minWidth;
	this.target = exp['target'+ this.dim.toUpperCase()];
	this.marginMin = hsf['margin'+ this.uclt];
	this.scroll = hsf.page['scroll'+ this.uclt];
	this.clientSize = hsf.page[this.wh];
},
setSize: function(i) {
	var exp = this.exp;
	if (exp.isImage && (exp.useBox || hsf.padToMinWidth)) {
		this.imgSize = i;
		this.size = Math.max(this.size, this.imgSize);
		exp.content.style[this.lt] = this.get('imgPad')+'px';
	} else
	this.size = i;

	exp.content.style[this.wh] = i +'px';
	exp.wrapper.style[this.wh] = this.get('wsize') +'px';
	if (exp.outline) exp.outline.setPosition();
	if (exp.releaseMask) exp.releaseMask.style[this.wh] = i +'px';
	if (exp.isHtml) {
		var d = exp.scrollerDiv;
		if (this.sizeDiff === undefined)
			this.sizeDiff = exp.innerContent['offset'+ this.ucwh] - d['offset'+ this.ucwh];
		d.style[this.wh] = (this.size - this.sizeDiff) +'px';

		if (this.dim == 'x') exp.mediumContent.style.width = 'auto';
		if (exp.body) exp.body.style[this.wh] = 'auto';
	}
	if (this.dim == 'x' && exp.overlayBox) exp.sizeOverlayBox(true);
	if (this.dim == 'x' && exp.slideshow && exp.isImage) {
		if (i == this.full) exp.slideshow.disable('full-expand');
		else exp.slideshow.enable('full-expand');
	}
},
setPos: function(i) {
	this.pos = i;
	this.exp.wrapper.style[this.lt] = i +'px';

	if (this.exp.outline) this.exp.outline.setPosition();

}
};

hsf.Expander = function(a, params, custom, contentType) {
	if (document.readyState && hsf.ie && !hsf.isReady) {
		hsf.addEventListener(document, 'ready', function() {
			new hsf.Expander(a, params, custom, contentType);
		});
		return;
	}
	this.a = a;
	this.custom = custom;
	this.contentType = contentType || 'image';
	this.isHtml = (contentType == 'html');
	this.isImage = !this.isHtml;

	hsf.continuePreloading = false;
	this.overlays = [];
	this.last = hsf.last;
	hsf.last = null;
	hsf.init();
	var key = this.key = hsf.expanders.length;
	// override inline parameters
	for (var i = 0; i < hsf.overrides.length; i++) {
		var name = hsf.overrides[i];
		this[name] = params && typeof params[name] != 'undefined' ?
			params[name] : hsf[name];
	}
	if (!this.src) this.src = a.href;

	// get thumb
	var el = (params && params.thumbnailId) ? hsf.$(params.thumbnailId) : a;
	el = this.thumb = el.getElementsByTagName('img')[0] || el;
	this.thumbsUserSetId = el.id || a.id;
	if (!hsf.fireEvent(this, 'onInit')) return true;

	// check if already open
	for (var i = 0; i < hsf.expanders.length; i++) {
		if (hsf.expanders[i] && hsf.expanders[i].a == a
			&& !(this.last && this.transitions[1] == 'crossfade')) {
			hsf.expanders[i].focus();
			return false;
		}
	}

	// cancel other
	if (!hsf.allowSimultaneousLoading) for (var i = 0; i < hsf.expanders.length; i++) {
		if (hsf.expanders[i] && hsf.expanders[i].thumb != el && !hsf.expanders[i].onLoadStarted) {
			hsf.expanders[i].cancelLoading();
		}
	}
	hsf.expanders[key] = this;
	if (!hsf.allowMultipleInstances && !hsf.upcoming) {
		if (hsf.expanders[key-1]) hsf.expanders[key-1].close();
		if (typeof hsf.focusKey != 'undefined' && hsf.expanders[hsf.focusKey])
			hsf.expanders[hsf.focusKey].close();
	}

	// initiate metrics
	this.el = el;
	this.tpos = hsf.getPosition(el);
	hsf.getPageSize();
	var x = this.x = new hsf.Dimension(this, 'x');
	x.calcThumb();
	var y = this.y = new hsf.Dimension(this, 'y');
	y.calcThumb();
	if (/area/i.test(el.tagName)) this.getImageMapAreaCorrection(el);
	this.wrapper = hsf.createElement(
		'div', {
			id: 'highslide-wrapper-'+ this.key,
			className: 'highslide-wrapper '+ this.wrapperClassName
		}, {
			visibility: 'hidden',
			position: 'absolute',
			zIndex: hsf.zIndexCounter += 2
		}, null, true );

	this.wrapper.onmouseover = this.wrapper.onmouseout = hsf.wrapperMouseHandler;
	if (this.contentType == 'image' && this.outlineWhileAnimating == 2)
		this.outlineWhileAnimating = 0;

	// get the outline
	if (!this.outlineType
		|| (this.last && this.isImage && this.transitions[1] == 'crossfade')) {
		this[this.contentType +'Create']();

	} else if (hsf.pendingOutlines[this.outlineType]) {
		this.connectOutline();
		this[this.contentType +'Create']();

	} else {
		this.showLoading();
		var exp = this;
		new hsf.Outline(this.outlineType,
			function () {
				exp.connectOutline();
				exp[exp.contentType +'Create']();
			}
		);
	}
	return true;
};

hsf.Expander.prototype = {
error : function(e) {
	//alert ('Line '+ e.lineNumber +': '+ e.message);
	window.location.href = this.src;
},

connectOutline : function() {
	var outline = this.outline = hsf.pendingOutlines[this.outlineType];
	outline.exp = this;
	outline.table.style.zIndex = this.wrapper.style.zIndex - 1;
	hsf.pendingOutlines[this.outlineType] = null;
},

showLoading : function() {
	if (this.onLoadStarted || this.loading) return;

	this.loading = hsf.loading;
	var exp = this;
	this.loading.onclick = function() {
		exp.cancelLoading();
	};


	if (!hsf.fireEvent(this, 'onShowLoading')) return;
	var exp = this,
		l = this.x.get('loadingPos') +'px',
		t = this.y.get('loadingPos') +'px';
	if (!tgt && this.last && this.transitions[1] == 'crossfade')
		var tgt = this.last;
	if (tgt) {
		l = tgt.x.get('loadingPosXfade') +'px';
		t = tgt.y.get('loadingPosXfade') +'px';
		this.loading.style.zIndex = hsf.zIndexCounter++;
	}
	setTimeout(function () {
		if (exp.loading) hsf.setStyles(exp.loading, { left: l, top: t, zIndex: hsf.zIndexCounter++ })}
	, 100);
},

imageCreate : function() {
	var exp = this;

	var img = document.createElement('img');
    this.content = img;
    img.onload = function () {
    	if (hsf.expanders[exp.key]) exp.contentLoaded();
	};
    if (hsf.blockRightClick) img.oncontextmenu = function() { return false; };
    img.className = 'highslide-image';
    hsf.setStyles(img, {
    	visibility: 'hidden',
    	display: 'block',
    	position: 'absolute',
		maxWidth: '9999px',
		zIndex: 3
	});
    img.title = hsf.lang.restoreTitle;
    if (hsf.safari) hsf.container.appendChild(img);
    if (hsf.ie && hsf.flushImgSize) img.src = null;
	img.src = this.src;

	this.showLoading();
},

htmlCreate : function () {
	if (!hsf.fireEvent(this, 'onBeforeGetContent')) return;

	this.content = hsf.getCacheBinding(this.a);
	if (!this.content)
		this.content = hsf.getNode(this.contentId);
	if (!this.content)
		this.content = hsf.getSelfRendered();
	this.getInline(['maincontent']);
	if (this.maincontent) {
		var body = hsf.getElementByClass(this.content, 'div', 'highslide-body');
		if (body) body.appendChild(this.maincontent);
		this.maincontent.style.display = 'block';
	}
	hsf.fireEvent(this, 'onAfterGetContent');

	var innerContent = this.innerContent = this.content;

	if (/(swf|iframe)/.test(this.objectType)) this.setObjContainerSize(innerContent);

	// the content tree
	hsf.container.appendChild(this.wrapper);
	hsf.setStyles( this.wrapper, {
		position: 'static',
		padding: '0 '+ hsf.marginRight +'px 0 '+ hsf.marginLeft +'px'
	});
	this.content = hsf.createElement(
    	'div', {
    		className: 'highslide-html'
    	}, {
			position: 'relative',
			zIndex: 3,
			overflow: 'hidden'
		},
		this.wrapper
	);
	this.mediumContent = hsf.createElement('div', null, null, this.content, 1);
	this.mediumContent.appendChild(innerContent);

	hsf.setStyles (innerContent, {
		position: 'relative',
		display: 'block',
		direction: hsf.lang.cssDirection || ''
	});
	if (this.width) innerContent.style.width = this.width +'px';
	if (this.height) hsf.setStyles(innerContent, {
		height: this.height +'px',
		overflow: 'hidden'
	});
	if (innerContent.offsetWidth < this.minWidth)
		innerContent.style.width = this.minWidth +'px';



	if (this.objectType == 'ajax' && !hsf.getCacheBinding(this.a)) {
		this.showLoading();
    	var ajax = new hsf.Ajax(this.a, innerContent);
    	var exp = this;
    	ajax.onLoad = function () {	if (hsf.expanders[exp.key]) exp.contentLoaded(); };
    	ajax.onError = function () { location.href = exp.src; };
    	ajax.run();
	}
    else

    if (this.objectType == 'iframe' && this.objectLoadTime == 'before') {
		this.writeExtendedContent();
	}
    else
    	this.contentLoaded();
},

contentLoaded : function() {
	try {
		if (!this.content) return;
		this.content.onload = null;
		if (this.onLoadStarted) return;
		else this.onLoadStarted = true;

		var x = this.x, y = this.y;

		if (this.loading) {
			hsf.setStyles(this.loading, { top: '-9999px' });
			this.loading = null;
			hsf.fireEvent(this, 'onHideLoading');
		}
		if (this.isImage) {
			x.full = this.content.width;
			y.full = this.content.height;

			hsf.setStyles(this.content, {
				width: x.t +'px',
				height: y.t +'px'
			});
			this.wrapper.appendChild(this.content);
			hsf.container.appendChild(this.wrapper);
		} else if (this.htmlGetSize) this.htmlGetSize();

		x.calcBorders();
		y.calcBorders();

		hsf.setStyles (this.wrapper, {
			left: (x.tpos + x.tb - x.cb) +'px',
			top: (y.tpos + x.tb - y.cb) +'px'
		});


		this.initSlideshow();
		this.getOverlays();

		var ratio = x.full / y.full;

		x.calcExpanded();
		this.justify(x);

		y.calcExpanded();
		this.justify(y);
		if (this.isHtml) this.htmlSizeOperations();
		if (this.overlayBox) this.sizeOverlayBox(0, 1);

		if (this.allowSizeReduction) {
			if (this.isImage)
				this.correctRatio(ratio);
			else this.fitOverlayBox();
			var ss = this.slideshow;
			if (ss && this.last && ss.controls && ss.fixedControls) {
				var pos = ss.overlayOptions.position || '', p;
				for (var dim in hsf.oPos) for (var i = 0; i < 5; i++) {
					p = this[dim];
					if (pos.match(hsf.oPos[dim][i])) {
						p.pos = this.last[dim].pos
							+ (this.last[dim].p1 - p.p1)
							+ (this.last[dim].size - p.size) * [0, 0, .5, 1, 1][i];
						if (ss.fixedControls == 'fit') {
							if (p.pos + p.size + p.p1 + p.p2 > p.scroll + p.clientSize - p.marginMax)
								p.pos = p.scroll + p.clientSize - p.size - p.marginMin - p.marginMax - p.p1 - p.p2;
							if (p.pos < p.scroll + p.marginMin) p.pos = p.scroll + p.marginMin;
						}
					}
				}
			}
			if (this.isImage && this.x.full > (this.x.imgSize || this.x.size)) {
				this.createFullExpand();
				if (this.overlays.length == 1) this.sizeOverlayBox();
			}
		}
		this.show();

	} catch (e) {
		this.error(e);
	}
},


setObjContainerSize : function(parent, auto) {
	var c = hsf.getElementByClass(parent, 'DIV', 'highslide-body');
	if (/(iframe|swf)/.test(this.objectType)) {
		if (this.objectWidth) c.style.width = this.objectWidth +'px';
		if (this.objectHeight) c.style.height = this.objectHeight +'px';
	}
},

writeExtendedContent : function () {
	if (this.hasExtendedContent) return;
	var exp = this;
	this.body = hsf.getElementByClass(this.innerContent, 'DIV', 'highslide-body');
	if (this.objectType == 'iframe') {
		this.showLoading();
		var ruler = hsf.clearing.cloneNode(1);
		this.body.appendChild(ruler);
		this.newWidth = this.innerContent.offsetWidth;
		if (!this.objectWidth) this.objectWidth = ruler.offsetWidth;
		var hDiff = this.innerContent.offsetHeight - this.body.offsetHeight,
			h = this.objectHeight || hsf.page.height - hDiff - hsf.marginTop - hsf.marginBottom,
			onload = this.objectLoadTime == 'before' ?
				' onload="if (hsf.expanders['+ this.key +']) hsf.expanders['+ this.key +'].contentLoaded()" ' : '';

		this.body.innerHTML += '<iframe name="hs'+ (new Date()).getTime() +'" frameborder="0" key="'+ this.key +'" '
			+' allowtransparency="true" style="width:'+ this.objectWidth +'px; height:'+ h +'px" '
			+ onload +' src="'+ this.src +'"></iframe>';
		this.ruler = this.body.getElementsByTagName('div')[0];
		this.iframe = this.body.getElementsByTagName('iframe')[0];

		if (this.objectLoadTime == 'after') this.correctIframeSize();

	}
	if (this.objectType == 'swf') {
		this.body.id = this.body.id || 'hs-flash-id-' + this.key;
		var a = this.swfOptions;
		if (!a.params) a.params = {};
		if (typeof a.params.wmode == 'undefined') a.params.wmode = 'transparent';
		if (swfobject) swfobject.embedSWF(this.src, this.body.id, this.objectWidth, this.objectHeight,
			a.version || '7', a.expressInstallSwfurl, a.flashvars, a.params, a.attributes);
	}
	this.hasExtendedContent = true;
},
htmlGetSize : function() {
	if (this.iframe && !this.objectHeight) { // loadtime before
		this.iframe.style.height = this.body.style.height = this.getIframePageHeight() +'px';
	}
	this.innerContent.appendChild(hsf.clearing);
	if (!this.x.full) this.x.full = this.innerContent.offsetWidth;
    this.y.full = this.innerContent.offsetHeight;
    this.innerContent.removeChild(hsf.clearing);
    if (hsf.ie && this.newHeight > parseInt(this.innerContent.currentStyle.height)) { // ie css bug
		this.newHeight = parseInt(this.innerContent.currentStyle.height);
	}
	hsf.setStyles( this.wrapper, { position: 'absolute',	padding: '0'});
	hsf.setStyles( this.content, { width: this.x.t +'px', height: this.y.t +'px'});
},

getIframePageHeight : function() {
	var h;
	try {
		var doc = this.iframe.contentDocument || this.iframe.contentWindow.document;
		var clearing = doc.createElement('div');
		clearing.style.clear = 'both';
		doc.body.appendChild(clearing);
		h = clearing.offsetTop;
		if (hsf.ie) h += parseInt(doc.body.currentStyle.marginTop)
			+ parseInt(doc.body.currentStyle.marginBottom) - 1;
	} catch (e) { // other domain
		h = 300;
	}
	return h;
},
correctIframeSize : function () {
	var wDiff = this.innerContent.offsetWidth - this.ruler.offsetWidth;
	hsf.discardElement(this.ruler);
	if (wDiff < 0) wDiff = 0;

	var hDiff = this.innerContent.offsetHeight - this.iframe.offsetHeight;
	hsf.setStyles(this.iframe, {
		width: Math.abs(this.x.size - wDiff) +'px',
		height: Math.abs(this.y.size - hDiff) +'px'
	});
    hsf.setStyles(this.body, {
		width: this.iframe.style.width,
    	height: this.iframe.style.height
	});

    this.scrollingContent = this.iframe;
    this.scrollerDiv = this.scrollingContent;
},
htmlSizeOperations : function () {

	this.setObjContainerSize(this.innerContent);


	if (this.objectType == 'swf' && this.objectLoadTime == 'before') this.writeExtendedContent();

    // handle minimum size
    if (this.x.size < this.x.full && !this.allowWidthReduction) this.x.size = this.x.full;
    if (this.y.size < this.y.full && !this.allowHeightReduction) this.y.size = this.y.full;
	this.scrollerDiv = this.innerContent;
    hsf.setStyles(this.mediumContent, {
		position: 'relative',
		width: this.x.size +'px'
	});
    hsf.setStyles(this.innerContent, {
    	border: 'none',
    	width: 'auto',
    	height: 'auto'
    });
	var node = hsf.getElementByClass(this.innerContent, 'DIV', 'highslide-body');
    if (node && !/(iframe|swf)/.test(this.objectType)) {
    	var cNode = node; // wrap to get true size
    	node = hsf.createElement(cNode.nodeName, null, {overflow: 'hidden'}, null, true);
    	cNode.parentNode.insertBefore(node, cNode);
    	node.appendChild(hsf.clearing); // IE6
    	node.appendChild(cNode);

    	var wDiff = this.innerContent.offsetWidth - node.offsetWidth;
    	var hDiff = this.innerContent.offsetHeight - node.offsetHeight;
		node.removeChild(hsf.clearing);

    	var kdeBugCorr = hsf.safari || navigator.vendor == 'KDE' ? 1 : 0; // KDE repainting bug
    	hsf.setStyles(node, {
    			width: (this.x.size - wDiff - kdeBugCorr) +'px',
    			height: (this.y.size - hDiff) +'px',
    			overflow: 'auto',
    			position: 'relative'
    		}
    	);
		if (kdeBugCorr && cNode.offsetHeight > node.offsetHeight)	{
    		node.style.width = (parseInt(node.style.width) + kdeBugCorr) + 'px';
		}
    	this.scrollingContent = node;
    	this.scrollerDiv = this.scrollingContent;
	}
    if (this.iframe && this.objectLoadTime == 'before') this.correctIframeSize();
    if (!this.scrollingContent && this.y.size < this.mediumContent.offsetHeight) this.scrollerDiv = this.content;

	if (this.scrollerDiv == this.content && !this.allowWidthReduction && !/(iframe|swf)/.test(this.objectType)) {
		this.x.size += 17; // room for scrollbars
	}
	if (this.scrollerDiv && this.scrollerDiv.offsetHeight > this.scrollerDiv.parentNode.offsetHeight) {
		setTimeout("try { hsf.expanders["+ this.key +"].scrollerDiv.style.overflow = 'auto'; } catch(e) {}",
			 hsf.expandDuration);
	}
},

getImageMapAreaCorrection : function(area) {
	var c = area.coords.split(',');
	for (var i = 0; i < c.length; i++) c[i] = parseInt(c[i]);

	if (area.shape.toLowerCase() == 'circle') {
		this.x.tpos += c[0] - c[2];
		this.y.tpos += c[1] - c[2];
		this.x.t = this.y.t = 2 * c[2];
	} else {
		var maxX, maxY, minX = maxX = c[0], minY = maxY = c[1];
		for (var i = 0; i < c.length; i++) {
			if (i % 2 == 0) {
				minX = Math.min(minX, c[i]);
				maxX = Math.max(maxX, c[i]);
			} else {
				minY = Math.min(minY, c[i]);
				maxY = Math.max(maxY, c[i]);
			}
		}
		this.x.tpos += minX;
		this.x.t = maxX - minX;
		this.y.tpos += minY;
		this.y.t = maxY - minY;
	}
},
justify : function (p, moveOnly) {
	var tgtArr, tgt = p.target, dim = p == this.x ? 'x' : 'y';

	if (tgt && tgt.match(/ /)) {
		tgtArr = tgt.split(' ');
		tgt = tgtArr[0];
	}
	if (tgt && hsf.$(tgt)) {
		p.pos = hsf.getPosition(hsf.$(tgt))[dim];
		if (tgtArr && tgtArr[1] && tgtArr[1].match(/^[-]?[0-9]+px$/))
			p.pos += parseInt(tgtArr[1]);
		if (p.size < p.minSize) p.size = p.minSize;

	} else if (p.justify == 'auto' || p.justify == 'center') {

		var hasMovedMin = false;

		var allowReduce = p.exp.allowSizeReduction;
		if (p.justify == 'center')
			p.pos = Math.round(p.scroll + (p.clientSize + p.marginMin - p.marginMax - p.get('wsize')) / 2);
		else
			p.pos = Math.round(p.pos - ((p.get('wsize') - p.t) / 2));
		if (p.pos < p.scroll + p.marginMin) {
			p.pos = p.scroll + p.marginMin;
			hasMovedMin = true;
		}
		if (!moveOnly && p.size < p.minSize) {
			p.size = p.minSize;
			allowReduce = false;
		}
		if (p.pos + p.get('wsize') > p.scroll + p.clientSize - p.marginMax) {
			if (!moveOnly && hasMovedMin && allowReduce) {
				p.size = p.get(dim == 'y' ? 'fitsize' : 'maxsize');
			} else if (p.get('wsize') < p.get('fitsize')) {
				p.pos = p.scroll + p.clientSize - p.marginMax - p.get('wsize');
			} else { // image larger than viewport
				p.pos = p.scroll + p.marginMin;
				if (!moveOnly && allowReduce) p.size = p.get(dim == 'y' ? 'fitsize' : 'maxsize');
			}
		}

		if (!moveOnly && p.size < p.minSize) {
			p.size = p.minSize;
			allowReduce = false;
		}


	} else if (p.justify == 'max') {
		p.pos = Math.floor(p.pos - p.size + p.t);
	}


	if (p.pos < p.marginMin) {
		var tmpMin = p.pos;
		p.pos = p.marginMin;

		if (allowReduce && !moveOnly) p.size = p.size - (p.pos - tmpMin);

	}
},

correctRatio : function(ratio) {
	var x = this.x,
		y = this.y,
		changed = false,
		xSize = Math.min(x.full, x.size),
		ySize = Math.min(y.full, y.size),
		useBox = (this.useBox || hsf.padToMinWidth);

	if (xSize / ySize > ratio) { // width greater
		xSize = ySize * ratio;
		if (xSize < x.minSize) { // below minWidth
			xSize = x.minSize;
			ySize = xSize / ratio;
		}
		changed = true;

	} else if (xSize / ySize < ratio) { // height greater
		ySize = xSize / ratio;
		changed = true;
	}

	if (hsf.padToMinWidth && x.full < x.minSize) {
		x.imgSize = x.full;
		y.size = y.imgSize = y.full;
	} else if (this.useBox) {
		x.imgSize = xSize;
		y.imgSize = ySize;
	} else {
		x.size = xSize;
		y.size = ySize;
	}
	this.fitOverlayBox(useBox ? null : ratio);
	if (useBox && y.size < y.imgSize) {
		y.imgSize = y.size;
		x.imgSize = y.size * ratio;
	}
	if (changed || useBox) {
		x.pos = x.tpos - x.cb + x.tb;
		x.minSize = x.size;
		this.justify(x, true);

		y.pos = y.tpos - y.cb + y.tb;
		y.minSize = y.size;
		this.justify(y, true);
		if (this.overlayBox) this.sizeOverlayBox();
	}
},
fitOverlayBox : function(ratio) {
	var x = this.x, y = this.y;
	if (this.overlayBox) {
		while (y.size > this.minHeight && x.size > this.minWidth
				&&  y.get('wsize') > y.get('fitsize')) {
			y.size -= 10;
			if (ratio) x.size = y.size * ratio;
			this.sizeOverlayBox(0, 1);
		}
	}
},

reflow : function () {
	if (this.scrollerDiv) {
		var h = /iframe/i.test(this.scrollerDiv.tagName) ? this.getIframePageHeight() + 1 +'px' : 'auto';
		if (this.body) this.body.style.height = h;
		this.scrollerDiv.style.height = h;
		this.y.setSize(this.innerContent.offsetHeight);
		hsf.setDimmerSize(this);
	}
},

show : function () {
	var x = this.x, y = this.y;
	this.doShowHide('hidden');
	hsf.fireEvent(this, 'onBeforeExpand');
	if (this.slideshow && this.slideshow.thumbstrip) this.slideshow.thumbstrip.selectThumb();

	// Apply size change
	this.changeSize(
		1, {
			wrapper: {
				width : x.get('wsize'),
				height : y.get('wsize'),
				left: x.pos,
				top: y.pos
			},
			content: {
				left: x.p1 + x.get('imgPad'),
				top: y.p1 + y.get('imgPad'),
				width:x.imgSize ||x.size,
				height:y.imgSize ||y.size
			}
		},
		hsf.expandDuration
	);
},

changeSize : function(up, to, dur) {
	// transition
	var trans = this.transitions,
	other = up ? (this.last ? this.last.a : null) : hsf.upcoming,
	t = (trans[1] && other
			&& hsf.getParam(other, 'transitions')[1] == trans[1]) ?
		trans[1] : trans[0];

	if (this[t] && t != 'expand') {
		this[t](up, to);
		return;
	}

	if (this.outline && !this.outlineWhileAnimating) {
		if (up) this.outline.setPosition();
		else this.outline.destroy(
				(this.isHtml && this.preserveContent));
	}


	if (!up) this.destroyOverlays();

	var exp = this,
		x = exp.x,
		y = exp.y,
		easing = this.easing;
	if (!up) easing = this.easingClose || easing;
	var after = up ?
		function() {

			if (exp.outline) exp.outline.table.style.visibility = "visible";
			setTimeout(function() {
				exp.afterExpand();
			}, 50);
		} :
		function() {
			exp.afterClose();
		};
	if (up) hsf.setStyles( this.wrapper, {
		width: x.t +'px',
		height: y.t +'px'
	});
	if (up && this.isHtml) {
		hsf.setStyles(this.wrapper, {
			left: (x.tpos - x.cb + x.tb) +'px',
			top: (y.tpos - y.cb + y.tb) +'px'
		});
	}
	if (this.fadeInOut) {
		hsf.setStyles(this.wrapper, { opacity: up ? 0 : 1 });
		hsf.extend(to.wrapper, { opacity: up });
	}
	hsf.animate( this.wrapper, to.wrapper, {
		duration: dur,
		easing: easing,
		step: function(val, args) {
			if (exp.outline && exp.outlineWhileAnimating && args.prop == 'top') {
				var fac = up ? args.pos : 1 - args.pos;
				var pos = {
					w: x.t + (x.get('wsize') - x.t) * fac,
					h: y.t + (y.get('wsize') - y.t) * fac,
					x: x.tpos + (x.pos - x.tpos) * fac,
					y: y.tpos + (y.pos - y.tpos) * fac
				};
				exp.outline.setPosition(pos, 0, 1);
			}
			if (exp.isHtml) {
				if (args.prop == 'left')
					exp.mediumContent.style.left = (x.pos - val) +'px';
				if (args.prop == 'top')
					exp.mediumContent.style.top = (y.pos - val) +'px';
			}
		}
	});
	hsf.animate( this.content, to.content, dur, easing, after);
	if (up) {
		this.wrapper.style.visibility = 'visible';
		this.content.style.visibility = 'visible';
		if (this.isHtml) this.innerContent.style.visibility = 'visible';
		this.a.className += ' highslide-active-anchor';
	}
},



fade : function(up, to) {
	this.outlineWhileAnimating = false;
	var exp = this,	t = up ? hsf.expandDuration : 0;

	if (up) {
		hsf.animate(this.wrapper, to.wrapper, 0);
		hsf.setStyles(this.wrapper, { opacity: 0, visibility: 'visible' });
		hsf.animate(this.content, to.content, 0);
		this.content.style.visibility = 'visible';

		hsf.animate(this.wrapper, { opacity: 1 }, t, null,
			function() { exp.afterExpand(); });
	}

	if (this.outline) {
		this.outline.table.style.zIndex = this.wrapper.style.zIndex;
		var dir = up || -1,
			offset = this.outline.offset,
			startOff = up ? 3 : offset,
			endOff = up? offset : 3;
		for (var i = startOff; dir * i <= dir * endOff; i += dir, t += 25) {
			(function() {
				var o = up ? endOff - i : startOff - i;
				setTimeout(function() {
					exp.outline.setPosition(0, o, 1);
				}, t);
			})();
		}
	}


	if (up) {}//setTimeout(function() { exp.afterExpand(); }, t+50);
	else {
		setTimeout( function() {
			if (exp.outline) exp.outline.destroy(exp.preserveContent);

			exp.destroyOverlays();

			hsf.animate( exp.wrapper, { opacity: 0 }, hsf.restoreDuration, null, function(){
				exp.afterClose();
			});
		}, t);
	}
},

crossfade : function (up, to) {
	if (!up) return;
	var exp = this,
		dur = hsf.transitionDuration,
		last = exp.last,
		x = exp.x,
		y = exp.y,
		lastX = last.x,
		lastY = last.y,
		overlayBox = exp.overlayBox,
		wrapper = this.wrapper,
		content = this.content;
	hsf.removeEventListener(document, 'mousemove', hsf.dragHandler);
	this.outline = last.outline;
	if (this.outline) this.outline.exp = exp;
	last.outline = null;
	last.wrapper.style.overflow = 'hidden';
	hsf.setStyles(wrapper, {
		left: lastX.pos +'px',
		top: lastY.pos +'px',
		width: lastX.get('wsize') +'px',
		height: lastY.get('wsize') +'px'
	});
	hsf.setStyles(content, {
		display: 'none',
		width: (x.imgSize || x.size) +'px',
		height: (y.imgSize || y.size) +'px',
		left: (x.p1 + x.get('imgPad')) +'px',
		top: (y.p1 + y.get('imgPad')) + 'px'
	});
	var fadeBox = hsf.createElement('div', {
		className: 'highslide-image'
	}, {
		position: 'absolute',
		zIndex: 4,
		overflow: 'hidden',
		display: 'none',
		left: (lastX.p1 + lastX.get('imgPad')) +'px',
		top: (lastY.p1 + lastY.get('imgPad')) +'px',
		width: (lastX.imgSize || lastX.size) +'px',
		height: (lastY.imgSize || lastY.size) +'px'
	});
	if (this.isHtml) hsf.setStyles(this.mediumContent, {
		left: 0,
		top: 0
	});
	for (var i = 0; i < this.overlays.length; i++) {
		var o = hsf.$('hsId'+ this.overlays[i]);
		if (o.style.visibility == 'hidden') o.style.display = 'none';
	}
	if (overlayBox) hsf.setStyles(overlayBox, {
		overflow: 'visible',
		left: (lastX.p1 + lastX.cb) +'px',
		top: (lastY.p1 + lastY.cb) +'px',
		width: lastX.size +'px',
		height: lastY.size +'px'
	});
	var names = { oldImg: last, newImg: this };
	for (var n in names) {
		this[n] = names[n].content.cloneNode(1);
		hsf.setStyles(this[n], {
			position: 'absolute',
			border: 0,
			visibility: 'visible'
		});
		fadeBox.appendChild(this[n]);
	}
	hsf.setStyles(this.oldImg, {
		left: 0,
		top: 0
	});
	hsf.setStyles(this.newImg, {
		display: 'block',
		opacity: 0,
		left: (x.pos - lastX.pos + x.p1 - lastX.p1 + x.get('imgPad') - lastX.get('imgPad')) +'px',
		top: (y.pos - lastY.pos + y.p1 - lastY.p1 + y.get('imgPad') - lastY.get('imgPad')) +'px'
	});
	wrapper.appendChild(fadeBox);
	if (overlayBox) {
		overlayBox.className = '';
		wrapper.appendChild(overlayBox);
	}
	fadeBox.style.display = '';
	last.content.style.display = 'none';

	if (hsf.safari) {
		var match = navigator.userAgent.match(/Safari\/([0-9]{3})/);
		if (match && parseInt(match[1]) < 525) wrapper.style.visibility = 'visible';
	}
	function end() {
		wrapper.style.visibility = content.style.visibility = 'visible';
		content.style.display = 'block';
		fadeBox.style.display = 'none';
		exp.a.className += ' highslide-active-anchor';
		exp.afterExpand();
		last.afterClose();
		exp.last = null;
	}
	hsf.animate(last.wrapper, {
		left: x.pos,
		top: y.pos,
		width: x.get('wsize'),
		height: y.get('wsize')
	}, dur);

	hsf.animate(fadeBox, {
		width: x.imgSize || x.size,
		height: y.imgSize || y.size,
		left: x.p1 + x.get('imgPad'),
		top: y.p1 + y.get('imgPad')
	}, dur);

	hsf.animate(this.oldImg, {
		left: (lastX.pos - x.pos + lastX.p1 - x.p1 + lastX.get('imgPad') - x.get('imgPad')),
		top: (lastY.pos - y.pos + lastY.p1 - y.p1 + lastY.get('imgPad') - y.get('imgPad'))
	}, dur);

	hsf.animate(this.newImg, {
		opacity: 1,
		left: 0,
		top: 0
	}, dur);
	if (overlayBox) hsf.animate(overlayBox, {
		left: x.p1 + x.cb,
		top: y.p1 + y.cb,
		width: x.size,
		height: y.size
	}, dur);
	if (this.outline) var wrapStep =  function(val, args) {
		if (args.prop == 'top') {
			var stl = exp.wrapper.style;
			var pos = {
				w: parseInt(stl.width),
				h: parseInt(stl.height),
				x: parseInt(stl.left),
				y: parseInt(stl.top)
			};
			exp.outline.setPosition(pos);
		}
	};
	hsf.animate(wrapper, to.wrapper, {
		duration: dur,
		complete: end,
		step: wrapStep
	});

	fadeBox.style.visibility = 'visible';
},
reuseOverlay : function(o, el) {
	if (!this.last) return false;
	for (var i = 0; i < this.last.overlays.length; i++) {
		var oDiv = hsf.$('hsId'+ this.last.overlays[i]);
		if (oDiv && oDiv.hsId == o.hsId) {
			this.genOverlayBox();
			oDiv.reuse = this.key;
			hsf.push(this.overlays, this.last.overlays[i]);
			return true;
		}
	}
	return false;
},


afterExpand : function() {
	this.isExpanded = true;
	this.focus();

	if (this.isHtml && this.objectLoadTime == 'after') this.writeExtendedContent();
	if (this.iframe) {
		try {
			var exp = this,
				doc = this.iframe.contentDocument || this.iframe.contentWindow.document;
			hsf.addEventListener(doc, 'mousedown', function () {
				if (hsf.focusKey != exp.key) exp.focus();
			});
		} catch(e) {}
		if (hsf.ie && typeof this.isClosing != 'boolean') // first open
			this.iframe.style.width = (this.objectWidth - 1) +'px'; // hasLayout
	}
	if (this.dimmingOpacity) hsf.dim(this);
	if (hsf.upcoming && hsf.upcoming == this.a) hsf.upcoming = null;
	this.prepareNextOutline();
	var p = hsf.page, mX = hsf.mouse.x + p.scrollLeft, mY = hsf.mouse.y + p.scrollTop;
	this.mouseIsOver = this.x.pos < mX && mX < this.x.pos + this.x.get('wsize')
		&& this.y.pos < mY && mY < this.y.pos + this.y.get('wsize');
	if (this.overlayBox) this.showOverlays();
	hsf.fireEvent(this, 'onAfterExpand');

},


prepareNextOutline : function() {
	var key = this.key;
	var outlineType = this.outlineType;
	new hsf.Outline(outlineType,
		function () { try { hsf.expanders[key].preloadNext(); } catch (e) {} });
},


preloadNext : function() {
	var next = this.getAdjacentAnchor(1);
	if (next && next.onclick.toString().match(/hs\.expand/))
		var img = hsf.createElement('img', { src: hsf.getSrc(next) });
},


getAdjacentAnchor : function(op) {
	var current = this.getAnchorIndex(), as = hsf.anchors.groups[this.slideshowGroup || 'none'];

	/*< ? if ($cfg->slideshow) : ?>s*/
	if (!as[current + op] && this.slideshow && this.slideshow.repeat) {
		if (op == 1) return as[0];
		else if (op == -1) return as[as.length-1];
	}
	/*< ? endif ?>s*/
	return as[current + op] || null;
},

getAnchorIndex : function() {
	var arr = hsf.getAnchors().groups[this.slideshowGroup || 'none'];
	if (arr) for (var i = 0; i < arr.length; i++) {
		if (arr[i] == this.a) return i;
	}
	return null;
},


getNumber : function() {
	if (this[this.numberPosition]) {
		var arr = hsf.anchors.groups[this.slideshowGroup || 'none'];
		if (arr) {
			var s = hsf.lang.number.replace('%1', this.getAnchorIndex() + 1).replace('%2', arr.length);
			this[this.numberPosition].innerHTML =
				'<div class="highslide-number">'+ s +'</div>'+ this[this.numberPosition].innerHTML;
		}
	}
},
initSlideshow : function() {
	if (!this.last) {
		for (var i = 0; i < hsf.slideshows.length; i++) {
			var ss = hsf.slideshows[i], sg = ss.slideshowGroup;
			if (typeof sg == 'undefined' || sg === null || sg === this.slideshowGroup)
				this.slideshow = new hsf.Slideshow(this.key, ss);
		}
	} else {
		this.slideshow = this.last.slideshow;
	}
	var ss = this.slideshow;
	if (!ss) return;
	var key = ss.expKey = this.key;

	ss.checkFirstAndLast();
	ss.disable('full-expand');
	if (ss.controls) {
		var o = ss.overlayOptions || {};
		o.overlayId = ss.controls;
		o.hsId = 'controls';
		this.createOverlay(o);
	}
	if (ss.thumbstrip) ss.thumbstrip.add(this);
	if (!this.last && this.autoplay) ss.play(true);
	if (ss.autoplay) {
		ss.autoplay = setTimeout(function() {
			hsf.next(key);
		}, (ss.interval || 500));
	}
},

cancelLoading : function() {
	hsf.discardElement (this.wrapper);
	hsf.expanders[this.key] = null;
	if (hsf.upcoming == this.a) hsf.upcoming = null;
	hsf.undim(this.key);
	if (this.loading) hsf.loading.style.left = '-9999px';
	hsf.fireEvent(this, 'onHideLoading');
},

writeCredits : function () {
	if (this.credits) return;
	this.credits = hsf.createElement('a', {
		href: hsf.creditsHref,
		target: hsf.creditsTarget,
		className: 'highslide-credits',
		innerHTML: hsf.lang.creditsText,
		title: hsf.lang.creditsTitle
	});
	this.createOverlay({
		overlayId: this.credits,
		position: this.creditsPosition || 'top left',
		hsId: 'credits'
	});
},

getInline : function(types, addOverlay) {
	for (var i = 0; i < types.length; i++) {
		var type = types[i], s = null;
		if (type == 'caption' && !hsf.fireEvent(this, 'onBeforeGetCaption')) return;
		else if (type == 'heading' && !hsf.fireEvent(this, 'onBeforeGetHeading')) return;
		if (!this[type +'Id'] && this.thumbsUserSetId)
			this[type +'Id'] = type +'-for-'+ this.thumbsUserSetId;
		if (this[type +'Id']) this[type] = hsf.getNode(this[type +'Id']);
		if (!this[type] && !this[type +'Text'] && this[type +'Eval']) try {
			s = eval(this[type +'Eval']);
		} catch (e) {}
		if (!this[type] && this[type +'Text']) {
			s = this[type +'Text'];
		}
		if (!this[type] && !s) {
			var next = this.a.nextSibling;
			while (next && !hsf.isHsAnchor(next)) {
				if ((new RegExp('highslide-'+ type)).test(next.className || null)) {
					this[type] = next.cloneNode(1);
					break;
				}
				next = next.nextSibling;
			}
		}
		if (!this[type] && !s && this.numberPosition == type) s = '\n';

		if (!this[type] && s) this[type] = hsf.createElement('div',
				{ className: 'highslide-'+ type, innerHTML: s } );

		if (addOverlay && this[type]) {
			var o = { position: (type == 'heading') ? 'above' : 'below' };
			for (var x in this[type+'Overlay']) o[x] = this[type+'Overlay'][x];
			o.overlayId = this[type];
			this.createOverlay(o);
		}
	}
},


// on end move and resize
doShowHide : function(visibility) {
	if (hsf.hideSelects) this.showHideElements('SELECT', visibility);
	if (hsf.hideIframes) this.showHideElements('IFRAME', visibility);
	if (hsf.geckoMac) this.showHideElements('*', visibility);
},
showHideElements : function (tagName, visibility) {
	var els = document.getElementsByTagName(tagName);
	var prop = tagName == '*' ? 'overflow' : 'visibility';
	for (var i = 0; i < els.length; i++) {
		if (prop == 'visibility' || (document.defaultView.getComputedStyle(
				els[i], "").getPropertyValue('overflow') == 'auto'
				|| els[i].getAttribute('hidden-by') != null)) {
			var hiddenBy = els[i].getAttribute('hidden-by');
			if (visibility == 'visible' && hiddenBy) {
				hiddenBy = hiddenBy.replace('['+ this.key +']', '');
				els[i].setAttribute('hidden-by', hiddenBy);
				if (!hiddenBy) els[i].style[prop] = els[i].origProp;
			} else if (visibility == 'hidden') { // hide if behind
				var elPos = hsf.getPosition(els[i]);
				elPos.w = els[i].offsetWidth;
				elPos.h = els[i].offsetHeight;
				if (!this.dimmingOpacity) { // hide all if dimming

					var clearsX = (elPos.x + elPos.w < this.x.get('opos')
						|| elPos.x > this.x.get('opos') + this.x.get('osize'));
					var clearsY = (elPos.y + elPos.h < this.y.get('opos')
						|| elPos.y > this.y.get('opos') + this.y.get('osize'));
				}
				var wrapperKey = hsf.getWrapperKey(els[i]);
				if (!clearsX && !clearsY && wrapperKey != this.key) { // element falls behind image
					if (!hiddenBy) {
						els[i].setAttribute('hidden-by', '['+ this.key +']');
						els[i].origProp = els[i].style[prop];
						els[i].style[prop] = 'hidden';

					} else if (hiddenBy.indexOf('['+ this.key +']') == -1) {
						els[i].setAttribute('hidden-by', hiddenBy + '['+ this.key +']');
					}
				} else if ((hiddenBy == '['+ this.key +']' || hsf.focusKey == wrapperKey)
						&& wrapperKey != this.key) { // on move
					els[i].setAttribute('hidden-by', '');
					els[i].style[prop] = els[i].origProp || '';
				} else if (hiddenBy && hiddenBy.indexOf('['+ this.key +']') > -1) {
					els[i].setAttribute('hidden-by', hiddenBy.replace('['+ this.key +']', ''));
				}

			}
		}
	}
},

focus : function() {
	this.wrapper.style.zIndex = hsf.zIndexCounter += 2;
	// blur others
	for (var i = 0; i < hsf.expanders.length; i++) {
		if (hsf.expanders[i] && i == hsf.focusKey) {
			var blurExp = hsf.expanders[i];
			blurExp.content.className += ' highslide-'+ blurExp.contentType +'-blur';
			if (blurExp.isImage) {
				blurExp.content.style.cursor = hsf.ie ? 'hand' : 'pointer';
				blurExp.content.title = hsf.lang.focusTitle;
			}
			hsf.fireEvent(blurExp, 'onBlur');
		}
	}

	// focus this
	if (this.outline) this.outline.table.style.zIndex
		= this.wrapper.style.zIndex - 1;
	this.content.className = 'highslide-'+ this.contentType;
	if (this.isImage) {
		this.content.title = hsf.lang.restoreTitle;

		if (hsf.restoreCursor) {
			hsf.styleRestoreCursor = window.opera ? 'pointer' : 'url('+ hsf.graphicsDir + hsf.restoreCursor +'), pointer';
			if (hsf.ie && hsf.uaVersion < 6) hsf.styleRestoreCursor = 'hand';
			this.content.style.cursor = hsf.styleRestoreCursor;
		}
	}
	hsf.focusKey = this.key;
	hsf.addEventListener(document, window.opera ? 'keypress' : 'keydown', hsf.keyHandler);
	hsf.fireEvent(this, 'onFocus');
},
moveTo: function(x, y) {
	this.x.setPos(x);
	this.y.setPos(y);
},
resize : function (e) {
	var w, h, r = e.width / e.height;
	w = Math.max(e.width + e.dX, Math.min(this.minWidth, this.x.full));
	if (this.isImage && Math.abs(w - this.x.full) < 12) w = this.x.full;
	h = this.isHtml ? e.height + e.dY : w / r;
	if (h < Math.min(this.minHeight, this.y.full)) {
		h = Math.min(this.minHeight, this.y.full);
		if (this.isImage) w = h * r;
	}
	this.resizeTo(w, h);
},
resizeTo: function(w, h) {
	this.y.setSize(h);
	this.x.setSize(w);
},

close : function() {
	if (this.isClosing || !this.isExpanded) return;
	if (this.transitions[1] == 'crossfade' && hsf.upcoming) {
		hsf.getExpander(hsf.upcoming).cancelLoading();
		hsf.upcoming = null;
	}
	if (!hsf.fireEvent(this, 'onBeforeClose')) return;
	this.isClosing = true;
	if (this.slideshow && !hsf.upcoming) this.slideshow.pause();

	hsf.removeEventListener(document, window.opera ? 'keypress' : 'keydown', hsf.keyHandler);

	try {
		if (this.isHtml) this.htmlPrepareClose();
		this.content.style.cursor = 'default';
		this.changeSize(
			0, {
				wrapper: {
					width : this.x.t,
					height : this.y.t,
					left: this.x.tpos - this.x.cb + this.x.tb,
					top: this.y.tpos - this.y.cb + this.y.tb
				},
				content: {
					left: 0,
					top: 0,
					width: this.x.t,
					height: this.y.t
				}
			}, hsf.restoreDuration
		);
	} catch (e) { this.afterClose(); }
},

htmlPrepareClose : function() {
	if (hsf.geckoMac) { // bad redraws
		if (!hsf.mask) hsf.mask = hsf.createElement('div', null,
			{ position: 'absolute' }, hsf.container);
		hsf.setStyles(hsf.mask, { width: this.x.size +'px', height: this.y.size +'px',
			left: this.x.pos +'px', top: this.y.pos +'px', display: 'block' });
	}
	if (this.objectType == 'swf') try { hsf.$(this.body.id).StopPlay(); } catch (e) {}

	if (this.objectLoadTime == 'after' && !this.preserveContent) this.destroyObject();
	if (this.scrollerDiv && this.scrollerDiv != this.scrollingContent)
		this.scrollerDiv.style.overflow = 'hidden';
},

destroyObject : function () {
	if (hsf.ie && this.iframe)
		try { this.iframe.contentWindow.document.body.innerHTML = ''; } catch (e) {}
	if (this.objectType == 'swf') swfobject.removeSWF(this.body.id);
	this.body.innerHTML = '';
},

sleep : function() {
	if (this.outline) this.outline.table.style.display = 'none';
	this.releaseMask = null;
	this.wrapper.style.display = 'none';
	hsf.push(hsf.sleeping, this);
},

awake : function() {try {

	hsf.expanders[this.key] = this;

	if (!hsf.allowMultipleInstances &&hsf.focusKey != this.key) {
		try { hsf.expanders[hsf.focusKey].close(); } catch (e){}
	}

	var z = hsf.zIndexCounter++, stl = { display: '', zIndex: z };
	hsf.setStyles (this.wrapper, stl);
	this.isClosing = false;

	var o = this.outline || 0;
	if (o) {
		if (!this.outlineWhileAnimating) stl.visibility = 'hidden';
		hsf.setStyles (o.table, stl);
	}
	if (this.slideshow) {
		this.initSlideshow();
	}

	this.show();
} catch (e) {}


},

createOverlay : function (o) {
	var el = o.overlayId,
		relToVP = (o.relativeTo == 'viewport' && !/panel$/.test(o.position));
	if (typeof el == 'string') el = hsf.getNode(el);
	if (o.html) el = hsf.createElement('div', { innerHTML: o.html });
	if (!el || typeof el == 'string') return;
	if (!hsf.fireEvent(this, 'onCreateOverlay', { overlay: el })) return;
	el.style.display = 'block';
	o.hsId = o.hsId || o.overlayId;
	if (this.transitions[1] == 'crossfade' && this.reuseOverlay(o, el)) return;
	this.genOverlayBox();
	var width = o.width && /^[0-9]+(px|%)$/.test(o.width) ? o.width : 'auto';
	if (/^(left|right)panel$/.test(o.position) && !/^[0-9]+px$/.test(o.width)) width = '200px';
	var overlay = hsf.createElement(
		'div', {
			id: 'hsId'+ hsf.idCounter++,
			hsId: o.hsId
		}, {
			position: 'absolute',
			visibility: 'hidden',
			width: width,
			direction: hsf.lang.cssDirection || '',
			opacity: 0
		},
		relToVP ? hsf.viewport :this.overlayBox,
		true
	);
	if (relToVP) overlay.hsKey = this.key;

	overlay.appendChild(el);
	hsf.extend(overlay, {
		opacity: 1,
		offsetX: 0,
		offsetY: 0,
		dur: (o.fade === 0 || o.fade === false || (o.fade == 2 && hsf.ie)) ? 0 : 250
	});
	hsf.extend(overlay, o);

	if (this.gotOverlays) {
		this.positionOverlay(overlay);
		if (!overlay.hideOnMouseOut || this.mouseIsOver)
			hsf.animate(overlay, { opacity: overlay.opacity }, overlay.dur);
	}
	hsf.push(this.overlays, hsf.idCounter - 1);
},
positionOverlay : function(overlay) {
	var p = overlay.position || 'middle center',
		relToVP = (overlay.relativeTo == 'viewport'),
		offX = overlay.offsetX,
		offY = overlay.offsetY;
	if (relToVP) {
		hsf.viewport.style.display = 'block';
		overlay.hsKey = this.key;
		if (overlay.offsetWidth > overlay.parentNode.offsetWidth)
			overlay.style.width = '100%';
	} else
	if (overlay.parentNode != this.overlayBox) this.overlayBox.appendChild(overlay);
	if (/left$/.test(p)) overlay.style.left = offX +'px';

	if (/center$/.test(p))	hsf.setStyles (overlay, {
		left: '50%',
		marginLeft: (offX - Math.round(overlay.offsetWidth / 2)) +'px'
	});

	if (/right$/.test(p)) overlay.style.right = - offX +'px';

	if (/^leftpanel$/.test(p)) {
		hsf.setStyles(overlay, {
			right: '100%',
			marginRight: this.x.cb +'px',
			top: - this.y.cb +'px',
			bottom: - this.y.cb +'px',
			overflow: 'auto'
		});
		this.x.p1 = overlay.offsetWidth;

	} else if (/^rightpanel$/.test(p)) {
		hsf.setStyles(overlay, {
			left: '100%',
			marginLeft: this.x.cb +'px',
			top: - this.y.cb +'px',
			bottom: - this.y.cb +'px',
			overflow: 'auto'
		});
		this.x.p2 = overlay.offsetWidth;
	}
	var parOff = overlay.parentNode.offsetHeight;
	overlay.style.height = 'auto';
	if (relToVP && overlay.offsetHeight > parOff)
		overlay.style.height = hsf.ieLt7 ? parOff +'px' : '100%';

	if (/^top/.test(p)) overlay.style.top = offY +'px';
	if (/^middle/.test(p))	hsf.setStyles (overlay, {
		top: '50%',
		marginTop: (offY - Math.round(overlay.offsetHeight / 2)) +'px'
	});
	if (/^bottom/.test(p)) overlay.style.bottom = - offY +'px';
	if (/^above$/.test(p)) {
		hsf.setStyles(overlay, {
			left: (- this.x.p1 - this.x.cb) +'px',
			right: (- this.x.p2 - this.x.cb) +'px',
			bottom: '100%',
			marginBottom: this.y.cb +'px',
			width: 'auto'
		});
		this.y.p1 = overlay.offsetHeight;

	} else if (/^below$/.test(p)) {
		hsf.setStyles(overlay, {
			position: 'relative',
			left: (- this.x.p1 - this.x.cb) +'px',
			right: (- this.x.p2 - this.x.cb) +'px',
			top: '100%',
			marginTop: this.y.cb +'px',
			width: 'auto'
		});
		this.y.p2 = overlay.offsetHeight;
		overlay.style.position = 'absolute';
	}
},

getOverlays : function() {
	this.getInline(['heading', 'caption'], true);
	this.getNumber();
	if (this.caption) hsf.fireEvent(this, 'onAfterGetCaption');
	if (this.heading) hsf.fireEvent(this, 'onAfterGetHeading');
	if (this.heading && this.dragByHeading) this.heading.className += ' highslide-move';
	if (hsf.showCredits) this.writeCredits();
	for (var i = 0; i < hsf.overlays.length; i++) {
		var o = hsf.overlays[i], tId = o.thumbnailId, sg = o.slideshowGroup;
		if ((!tId && !sg) || (tId && tId == this.thumbsUserSetId)
				|| (sg && sg === this.slideshowGroup)) {
			if (this.isImage || (this.isHtml && o.useOnHtml))
			this.createOverlay(o);
		}
	}
	var os = [];
	for (var i = 0; i < this.overlays.length; i++) {
		var o = hsf.$('hsId'+ this.overlays[i]);
		if (/panel$/.test(o.position)) this.positionOverlay(o);
		else hsf.push(os, o);
	}
	for (var i = 0; i < os.length; i++) this.positionOverlay(os[i]);
	this.gotOverlays = true;
},
genOverlayBox : function() {
	if (!this.overlayBox) this.overlayBox = hsf.createElement (
		'div', {
			className: this.wrapperClassName
		}, {
			position : 'absolute',
			width: (this.x.size || (this.useBox ? this.width : null)
				|| this.x.full) +'px',
			height: (this.y.size || this.y.full) +'px',
			visibility : 'hidden',
			overflow : 'hidden',
			zIndex : hsf.ie ? 4 : null
		},
		hsf.container,
		true
	);
},
sizeOverlayBox : function(doWrapper, doPanels) {
	var overlayBox = this.overlayBox,
		x = this.x,
		y = this.y;
	hsf.setStyles( overlayBox, {
		width: x.size +'px',
		height: y.size +'px'
	});
	if (doWrapper || doPanels) {
		for (var i = 0; i < this.overlays.length; i++) {
			var o = hsf.$('hsId'+ this.overlays[i]);
			var ie6 = (hsf.ieLt7 || document.compatMode == 'BackCompat');
			if (o && /^(above|below)$/.test(o.position)) {
				if (ie6) {
					o.style.width = (overlayBox.offsetWidth + 2 * x.cb
						+ x.p1 + x.p2) +'px';
				}
				y[o.position == 'above' ? 'p1' : 'p2'] = o.offsetHeight;
			}
			if (o && ie6 && /^(left|right)panel$/.test(o.position)) {
				o.style.height = (overlayBox.offsetHeight + 2* y.cb) +'px';
			}
		}
	}
	if (doWrapper) {
		hsf.setStyles(this.content, {
			top: y.p1 +'px'
		});
		hsf.setStyles(overlayBox, {
			top: (y.p1 + y.cb) +'px'
		});
	}
},

showOverlays : function() {
	var b = this.overlayBox;
	b.className = '';
	hsf.setStyles(b, {
		top: (this.y.p1 + this.y.cb) +'px',
		left: (this.x.p1 + this.x.cb) +'px',
		overflow : 'visible'
	});
	if (hsf.safari) b.style.visibility = 'visible';
	this.wrapper.appendChild (b);
	for (var i = 0; i < this.overlays.length; i++) {
		var o = hsf.$('hsId'+ this.overlays[i]);
		o.style.zIndex = o.hsId == 'controls' ? 5 : 4;
		if (!o.hideOnMouseOut || this.mouseIsOver) {
			o.style.visibility = 'visible';
			hsf.setStyles(o, { visibility: 'visible', display: '' });
			hsf.animate(o, { opacity: o.opacity }, o.dur);
		}
	}
},

destroyOverlays : function() {
	if (!this.overlays.length) return;
	for (var i = 0; i < this.overlays.length; i++) {
		var o = hsf.$('hsId'+ this.overlays[i]);
		if (o.parentNode == hsf.viewport) hsf.discardElement(o);
	}
	if (this.slideshow) {
		var c = this.slideshow.controls;
		if (c && hsf.getExpander(c) == this) c.parentNode.removeChild(c);
	}
	if (this.isHtml && this.preserveContent) {
		this.overlayBox.style.top = '-9999px';
		hsf.container.appendChild(this.overlayBox);
	} else
	hsf.discardElement(this.overlayBox);
},



createFullExpand : function () {
	if (this.slideshow && this.slideshow.controls) {
		this.slideshow.enable('full-expand');
		return;
	}
	this.fullExpandLabel = hsf.createElement(
		'a', {
			href: 'javascript:hsf.expanders['+ this.key +'].doFullExpand();',
			title: hsf.lang.fullExpandTitle,
			className: 'highslide-full-expand'
		}
	);
	if (!hsf.fireEvent(this, 'onCreateFullExpand')) return;

	this.createOverlay({
		overlayId: this.fullExpandLabel,
		position: hsf.fullExpandPosition,
		hideOnMouseOut: true,
		opacity: hsf.fullExpandOpacity
	});
},

doFullExpand : function () {
	try {
		if (!hsf.fireEvent(this, 'onDoFullExpand')) return;
		if (this.fullExpandLabel) hsf.discardElement(this.fullExpandLabel);

		this.focus();
		var xSize = this.x.size;
		this.resizeTo(this.x.full, this.y.full);

		var xpos = this.x.pos - (this.x.size - xSize) / 2;
		if (xpos < hsf.marginLeft) xpos = hsf.marginLeft;

		this.moveTo(xpos, this.y.pos);
		this.doShowHide('hidden');
		hsf.setDimmerSize(this);

	} catch (e) {
		this.error(e);
	}
},


afterClose : function () {
	this.a.className = this.a.className.replace('highslide-active-anchor', '');

	this.doShowHide('visible');

	if (this.isHtml && this.preserveContent
			 && this.transitions[1] != 'crossfade') {
		this.sleep();
	} else {
		if (this.outline && this.outlineWhileAnimating) this.outline.destroy();

		hsf.discardElement(this.wrapper);
	}
	if (hsf.mask) hsf.mask.style.display = 'none';
	if (!hsf.viewport.childNodes.length) hsf.viewport.style.display = 'none';

	if (this.dimmingOpacity) hsf.undim(this.key);
	hsf.fireEvent(this, 'onAfterClose');
	hsf.expanders[this.key] = null;
	hsf.reOrder();
}

};


// hsf.Ajax object prototype
hsf.Ajax = function (a, content, pre) {
	this.a = a;
	this.content = content;
	this.pre = pre;
};

hsf.Ajax.prototype = {
run : function () {
	if (!this.src) this.src = hsf.getSrc(this.a);
	if (this.src.match('#')) {
		var arr = this.src.split('#');
		this.src = arr[0];
		this.id = arr[1];
	}
	if (hsf.cachedGets[this.src]) {
		this.cachedGet = hsf.cachedGets[this.src];
		if (this.id) this.getElementContent();
		else this.loadHTML();
		return;
	}
	try { this.xmlHttp = new XMLHttpRequest(); }
	catch (e) {
		try { this.xmlHttp = new ActiveXObject("Msxml2.XMLHTTP"); }
		catch (e) {
			try { this.xmlHttp = new ActiveXObject("Microsoft.XMLHTTP"); }
			catch (e) { this.onError(); }
		}
	}
	var pThis = this;
	this.xmlHttp.onreadystatechange = function() {
		if(pThis.xmlHttp.readyState == 4) {
			if (pThis.id) pThis.getElementContent();
			else pThis.loadHTML();
		}
	};
	var src = this.src;
	if (hsf.forceAjaxReload)
		src = src.replace(/$/, (/\?/.test(src) ? '&' : '?') +'dummy='+ (new Date()).getTime());
	this.xmlHttp.open('GET', src, true);
	this.xmlHttp.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
	this.xmlHttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	this.xmlHttp.send(null);
},

getElementContent : function() {
	hsf.init();
	var attribs = window.opera || hsf.ie6SSL ? { src: 'about:blank' } : null;

	this.iframe = hsf.createElement('iframe', attribs,
		{ position: 'absolute', top: '-9999px' }, hsf.container);

	this.loadHTML();
},

loadHTML : function() {
	var s = this.cachedGet || this.xmlHttp.responseText;
	if (this.pre) hsf.cachedGets[this.src] = s;
	if (!hsf.ie || hsf.uaVersion >= 5.5) {
		s = s.replace(/\s/g, ' ').replace(
			new RegExp('<link[^>]*>', 'gi'), '').replace(
			new RegExp('<script[^>]*>.*?</script>', 'gi'), '');

		if (this.iframe) {
			var doc = this.iframe.contentDocument;
			if (!doc && this.iframe.contentWindow) doc = this.iframe.contentWindow.document;
			if (!doc) { // Opera
				var pThis = this;
				setTimeout(function() {	pThis.loadHTML(); }, 25);
				return;
			}
			doc.open();
			doc.write(s);
			doc.close();
			try { s = doc.getElementById(this.id).innerHTML; } catch (e) {
				try { s = this.iframe.document.getElementById(this.id).innerHTML; } catch (e) {} // opera
			}
			hsf.discardElement(this.iframe);
		} else {
			s = s.replace(new RegExp('^.*?<body[^>]*>(.*?)</body>.*?$', 'i'), '$1');
		}
	}
	hsf.getElementByClass(this.content, 'DIV', 'highslide-body').innerHTML = s;
	this.onLoad();
	for (var x in this) this[x] = null;
}
};


hsf.Slideshow = function (expKey, options) {
	if (hsf.dynamicallyUpdateAnchors !== false) hsf.updateAnchors();
	this.expKey = expKey;
	for (var x in options) this[x] = options[x];
	if (this.useControls) this.getControls();
	if (this.thumbstrip) this.thumbstrip = hsf.Thumbstrip(this);
};
hsf.Slideshow.prototype = {
getControls: function() {
	this.controls = hsf.createElement('div', { innerHTML: hsf.replaceLang(hsf.skin.controls) },
		null, hsf.container);

	var buttons = ['play', 'pause', 'previous', 'next', 'move', 'full-expand', 'close'];
	this.btn = {};
	var pThis = this;
	for (var i = 0; i < buttons.length; i++) {
		this.btn[buttons[i]] = hsf.getElementByClass(this.controls, 'li', 'highslide-'+ buttons[i]);
		this.enable(buttons[i]);
	}
	this.btn.pause.style.display = 'none';
	//this.disable('full-expand');
},
checkFirstAndLast: function() {
	if (this.repeat || !this.controls) return;
	var exp = hsf.expanders[this.expKey],
		cur = exp.getAnchorIndex(),
		re = /disabled$/;
	if (cur == 0)
		this.disable('previous');
	else if (re.test(this.btn.previous.getElementsByTagName('a')[0].className))
		this.enable('previous');
	if (cur + 1 == hsf.anchors.groups[exp.slideshowGroup || 'none'].length) {
		this.disable('next');
		this.disable('play');
	} else if (re.test(this.btn.next.getElementsByTagName('a')[0].className)) {
		this.enable('next');
		this.enable('play');
	}
},
enable: function(btn) {
	if (!this.btn) return;
	var sls = this, a = this.btn[btn].getElementsByTagName('a')[0], re = /disabled$/;
	a.onclick = function() {
		sls[btn]();
		return false;
	};
	if (re.test(a.className)) a.className = a.className.replace(re, '');
},
disable: function(btn) {
	if (!this.btn) return;
	var a = this.btn[btn].getElementsByTagName('a')[0];
	a.onclick = function() { return false; };
	if (!/disabled$/.test(a.className)) a.className += ' disabled';
},
hitSpace: function() {
	if (this.autoplay) this.pause();
	else this.play();
},
play: function(wait) {
	if (this.btn) {
		this.btn.play.style.display = 'none';
		this.btn.pause.style.display = '';
	}

	this.autoplay = true;
	if (!wait) hsf.next(this.expKey);
},
pause: function() {
	if (this.btn) {
		this.btn.pause.style.display = 'none';
		this.btn.play.style.display = '';
	}

	clearTimeout(this.autoplay);
	this.autoplay = null;
},
previous: function() {
	this.pause();
	hsf.previous(this.btn.previous);
},
next: function() {
	this.pause();
	hsf.next(this.btn.next);
},
move: function() {},
'full-expand': function() {
	hsf.getExpander().doFullExpand();
},
close: function() {
	hsf.close(this.btn.close);
}
};
hsf.Thumbstrip = function(slideshow) {
	function add (exp) {
		hsf.extend(options || {}, {
			overlayId: dom,
			hsId: 'thumbstrip'
		});
		if (hsf.ieLt7) options.fade = 0;
		exp.createOverlay(options);
		hsf.setStyles(dom.parentNode, { overflow: 'hidden' });
	};

	function scroll (delta) {
		selectThumb(undefined, Math.round(delta * dom[isX ? 'offsetWidth' : 'offsetHeight'] * 0.7));
	};

	function selectThumb (i, scrollBy) {
		if (i === undefined) for (var j = 0; j < group.length; j++) {
			if (group[j] == hsf.expanders[slideshow.expKey].a) {
				i = j;
				break;
			}
		}
		if (i === undefined) return;
		var as = dom.getElementsByTagName('a'),
			active = as[i],
			cell = active.parentNode,
			left = isX ? 'Left' : 'Top',
			right = isX ? 'Right' : 'Bottom',
			width = isX ? 'Width' : 'Height',
			offsetLeft = 'offset' + left,
			offsetWidth = 'offset' + width,
			overlayWidth = div.parentNode.parentNode[offsetWidth],
			minTblPos = overlayWidth - table[offsetWidth],
			curTblPos = parseInt(table.style[isX ? 'left' : 'top']) || 0,
			tblPos = curTblPos,
			mgnRight = 20;
		if (scrollBy !== undefined) {
			tblPos = curTblPos - scrollBy;
			if (tblPos > 0) tblPos = 0;
			if (tblPos < minTblPos) tblPos = minTblPos;

		} else {
			for (var j = 0; j < as.length; j++) as[j].className = '';
			active.className = 'highslide-active-anchor';
			var activeLeft = i > 0 ? as[i - 1].parentNode[offsetLeft] : cell[offsetLeft],
				activeRight = cell[offsetLeft] + cell[offsetWidth] +
					(as[i + 1] ? as[i + 1].parentNode[offsetWidth] : 0);
			if (activeRight > overlayWidth - curTblPos) tblPos = overlayWidth - activeRight;
			else if (activeLeft < -curTblPos) tblPos = -activeLeft;
		}
		var markerPos = cell[offsetLeft] + (cell[offsetWidth] - marker[offsetWidth]) / 2 + tblPos;
		hsf.animate(table, isX ? { left: tblPos } : { top: tblPos }, null, 'easeOutQuad');
		hsf.animate(marker, isX ? { left: markerPos } : { top: markerPos }, null, 'easeOutQuad');
		scrollUp.style.display = tblPos < 0 ? 'block' : 'none';
		scrollDown.style.display = (tblPos > minTblPos)  ? 'block' : 'none';
	};


	// initialize
	var group = hsf.anchors.groups[hsf.expanders[slideshow.expKey].slideshowGroup || 'none'],
		options = slideshow.thumbstrip,
		mode = options.mode || 'horizontal',
		floatMode = (mode == 'float'),
		tree = floatMode ? ['div', 'ul', 'li', 'span'] : ['table', 'tbody', 'tr', 'td'],
		isX = (mode == 'horizontal'),
		dom = hsf.createElement('div', {
				className: 'highslide-thumbstrip highslide-thumbstrip-'+ mode,
				innerHTML:
					'<div class="highslide-thumbstrip-inner">'+
					'<'+ tree[0] +'><'+ tree[1] +'></'+ tree[1] +'></'+ tree[0] +'></div>'+
					'<div class="highslide-scroll-up"><div></div></div>'+
					'<div class="highslide-scroll-down"><div></div></div>'+
					'<div class="highslide-marker"><div></div></div>'
			}, {
				display: 'none'
			}, hsf.container),
		domCh = dom.childNodes,
		div = domCh[0],
		scrollUp = domCh[1],
		scrollDown = domCh[2],
		marker = domCh[3],
		table = div.firstChild,
		tbody = dom.getElementsByTagName(tree[1])[0],
		tr;
	for (var i = 0; i < group.length; i++) {
		if (i == 0 || !isX) tr = hsf.createElement(tree[2], null, null, tbody);
		(function(){
			var a = group[i],
				cell = hsf.createElement(tree[3], null, null, tr),
				pI = i;
			hsf.createElement('a', {
				href: a.href,
				onclick: function() {
					hsf.getExpander(this).focus();
					return hsf.transit(a);
				},
				innerHTML: hsf.stripItemFormatter ? hsf.stripItemFormatter(a) : a.innerHTML
			}, null, cell);
		})();
	}

	if (!floatMode) {
		scrollUp.onclick = function () { scroll(-1); };
		scrollDown.onclick = function() { scroll(1); };
		hsf.addEventListener(tbody, document.onmousewheel !== undefined ?
				'mousewheel' : 'DOMMouseScroll', function(e) {
			var delta = 0;
	        e = e || window.event;
	        if (e.wheelDelta) {
				delta = e.wheelDelta/120;
				if (hsf.opera) delta = -delta;
	        } else if (e.detail) {
				delta = -e.detail/3;
	        }
	        if (delta) scroll(-delta * 0.2);
	        if (e.preventDefault) e.preventDefault();
			e.returnValue = false;
		});
	}

	return {
		add: add,
		selectThumb: selectThumb
	}
};
if (hsf.ie) {
	(function () {
		try {
			document.documentElement.doScroll('left');
		} catch (e) {
			setTimeout(arguments.callee, 50);
			return;
		}
		hsf.ready();
	})();
}
hsf.addEventListener(document, 'DOMContentLoaded', hsf.ready);
hsf.addEventListener(window, 'load', hsf.ready);
hsf.langDefaults = hsf.lang;
// history
var HsExpander = hsf.Expander;

// set handlers
hsf.addEventListener(window, 'load', function() {
	if (hsf.expandCursor) {
		var sel = '.highslide img',
			dec = 'cursor: url('+ hsf.graphicsDir + hsf.expandCursor +'), pointer !important;';

		var style = hsf.createElement('style', { type: 'text/css' }, null,
			document.getElementsByTagName('HEAD')[0]);

		if (!hsf.ie) {
			style.appendChild(document.createTextNode(sel + " {" + dec + "}"));
		} else {
			var last = document.styleSheets[document.styleSheets.length - 1];
			if (typeof(last.addRule) == "object") last.addRule(sel, dec);
		}
	}
});
hsf.addEventListener(window, 'resize', function() {
	hsf.getPageSize();
	if (hsf.viewport) for (var i = 0; i < hsf.viewport.childNodes.length; i++) {
		var node = hsf.viewport.childNodes[i],
			exp = hsf.getExpander(node);
		exp.positionOverlay(node);
		if (node.hsId == 'thumbstrip') exp.slideshow.thumbstrip.selectThumb();
	}
});
hsf.addEventListener(document, 'mousemove', function(e) {
	hsf.mouse = { x: e.clientX, y: e.clientY	};
});
hsf.addEventListener(document, 'mousedown', hsf.mouseClickHandler);
hsf.addEventListener(document, 'mouseup', hsf.mouseClickHandler);
hsf.addEventListener(document, 'ready', hsf.setClickEvents);
hsf.addEventListener(window, 'load', hsf.preloadImages);
hsf.addEventListener(window, 'load', hsf.preloadAjax);