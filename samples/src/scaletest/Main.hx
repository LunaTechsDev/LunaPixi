package scaletest;

import js.Browser;
import pixi.core.sprites.Sprite;
import pixi.core.text.DefaultStyle;
import pixi.core.text.Text;
import pixi.interaction.InteractionEvent;
import pixi.loaders.Loader;
import pixi.core.Application;

class Main extends Application {

	var _loader:Loader;
	var _bg:Sprite;
	var _reels:Sprite;
	var _label:Text;
	var _pr = Math.min(Math.floor(Browser.window.devicePixelRatio), 2);
	var _baseSize:Int = 320;
	var _ex:Int = 1;
	var _scale:Int;
	var _scale2:Int;
	var _switchedScale:Bool;

	public function new() {
		super({backgroundColor: 0xFFFFFF});
		_init();
	}

	function _init() {
		_scale = _getScale(_baseSize);
		_scale2 = _getScale2(_baseSize);
		_switchedScale = false;

		if (_scale > 8) _scale = 8;
		if (_scale2 > 8) _scale2 = 8;

		//onResize = _onResize;
		super.start();

		_preload();
	}

	function _preload() {
		var baseURL = "assets/scaletest/";
		_loader = new Loader();
		_loader.baseUrl = baseURL;

		_loader.add("ex1/scale-" + _scale + "/background/images/background.png");
		_loader.add("ex1/scale-" + _scale + "/symbols/images/symbols.png");
		_loader.add("ex2/scale-" + _scale + "/background/images/background.png");
		_loader.add("ex2/scale-" + _scale + "/symbols/images/symbols.png");
		_loader.add("ex3/scale-" + _scale + "/background/images/background.png");
		_loader.add("ex3/scale-" + _scale + "/symbols/images/symbols.png");
		_loader.add("ex4/scale-" + _scale + "/symbols/images/symbols.png");
		_loader.add("ex5/scale-" + _scale + "/symbols/images/symbols.png");


		if (_scale != _scale2) {
			_loader.add("ex1/scale-" + _scale2 + "/background/images/background.png");
			_loader.add("ex1/scale-" + _scale2 + "/symbols/images/symbols.png");
			_loader.add("ex2/scale-" + _scale2 + "/background/images/background.png");
			_loader.add("ex2/scale-" + _scale2 + "/symbols/images/symbols.png");
			_loader.add("ex3/scale-" + _scale2 + "/background/images/background.png");
			_loader.add("ex3/scale-" + _scale2 + "/symbols/images/symbols.png");
			_loader.add("ex4/scale-" + _scale2 + "/symbols/images/symbols.png");
			_loader.add("ex5/scale-" + _scale2 + "/symbols/images/symbols.png");
		}

		_loader.load(_onLoaded);
	}

	function _onLoaded() {
		var bgPath:String = "ex" + _ex + "/scale-" + _scale + "/background/images/background.png";
		var reelspath:String = "ex" + _ex + "/scale-" + _scale + "/symbols/images/symbols.png";
		_bg = new Sprite(_loader.resources[bgPath].texture);
		_bg.anchor.set(0.5);
		_bg.name = "bg";
		_bg.scale.set(1 / _pr);
		stage.addChild(_bg);

		_reels = new Sprite(_loader.resources[reelspath].texture);
		_reels.anchor.set(0.5);
		_reels.name = "reels";
		_reels.scale.set(1 / _pr);
		stage.addChild(_reels);

		var style:DefaultStyle = {};
		style.fill = 0xF78181;
		style.fontSize = 12;
		style.fontFamily = "Courier";

		_label = new Text(bgPath, style);
		_label.position.set(0, 0);
		stage.addChild(_label);
		_label.text = "Scale: " + _scale + " DPR: " + _pr;

		stage.interactive = true;
		stage.click = stage.tap = _changeTextures;

		//_onResize();
	}

	function _changeTextures(e:InteractionEvent) {
		_label.text = "Scale: " + _scale + " DPR: " + _pr;
		if (e.data.global.y < Browser.window.innerHeight / 2) {
			if (_ex < 5) _ex++;
			else _ex = 1;

			var bgPath:String = "ex" + _ex + "/scale-" + _scale + "/background/images/background.png";
			var reelspath:String = "ex" + _ex + "/scale-" + _scale + "/symbols/images/symbols.png";
			if (_ex < 4) _bg.texture = _loader.resources[bgPath].texture;
			_reels.texture = _loader.resources[reelspath].texture;
		}
		else {
			var bgPath:String = "";
			var reelspath:String = "";

			if (!_switchedScale) {
				_switchedScale = true;
				bgPath = "ex" + _ex + "/scale-" + _scale2 + "/background/images/background.png";
				reelspath = "ex" + _ex + "/scale-" + _scale2 + "/symbols/images/symbols.png";
				_label.text = "Scale: " + _scale2 + " DPR: " + _pr;
			}
			else {
				_switchedScale = false;
				bgPath = "ex" + _ex + "/scale-" + _scale + "/background/images/background.png";
				reelspath = "ex" + _ex + "/scale-" + _scale + "/symbols/images/symbols.png";
			}

			if (_ex < 4) _bg.texture = _loader.resources[bgPath].texture;
			_reels.texture = _loader.resources[reelspath].texture;
		}

		_bg.visible = (_ex < 4);

		//_onResize();
	}

	function _getScale(base:Int):Int {
		var px = Math.max(Browser.window.screen.width, Browser.window.screen.height);
		var pr = Math.min(Math.floor(Browser.window.devicePixelRatio), 2);
		return Math.ceil((px / base) * pr);
	}

	function _getScale2(base:Int):Int {
		var px = Math.max(Browser.window.screen.width, Browser.window.screen.height);
		var pr = Math.min(Math.floor(Browser.window.devicePixelRatio), 2);
		return Math.round((px / base) * pr);
	}

	/*
	function _onResize() {
		_bg.position.set(Browser.window.innerWidth / 2, Browser.window.innerHeight / 2);
		_reels.position.set(Browser.window.innerWidth / 2, Browser.window.innerHeight / 2);

		if (_ex < 4) {
			_reels.width = Browser.window.innerWidth - (24 * _scale);
			_reels.scale.y = _reels.scale.x;
			_bg.scale.set(_reels.scale.x);
		}
		else {
			_reels.height = Browser.window.innerHeight - (24 * _scale);
			_reels.scale.x = _reels.scale.y;
		}
	}
	*/

	static function main() {
		new Main();
	}
}