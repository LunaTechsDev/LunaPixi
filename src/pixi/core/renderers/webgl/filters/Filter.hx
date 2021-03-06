package pixi.core.renderers.webgl.filters;

import pixi.core.Pixi.BlendModes;
import pixi.core.display.DisplayObject;
import pixi.core.math.shapes.Rectangle;
import pixi.core.renderers.webgl.Program;
import pixi.core.renderers.webgl.State;
import pixi.core.renderers.webgl.utils.RenderTarget;
import pixi.core.textures.RenderTexture;
import pixi.core.renderers.systems.FilterSystem;

@:native("PIXI.Filter")
extern class Filter {
	/**
	 * The default vertex shader source
	 *
	 * @static
	 * @constant
	 */
	static var defaultVertexSrc:Dynamic;

	/**
	 * The default fragment shader source
	 *
	 * @static
	 * @constant
	 */
	static var defaultFragmentSrc:Dynamic;

	/**
	 * @class
	 * @memberof PIXI
	 * @param [vertexSrc] {String} The source of the vertex shader.
	 * @param [fragmentSrc] {String} The source of the fragment shader.
	 * @param [uniforms] {Dynamic} Custom uniforms to use to augment the built-in ones.
	 */
	function new(?vertexSrc:String, ?fragmentSrc:String, ?uniforms:Dynamic);

	/**
	 * Legacy filters use position and uvs from attributes
	 */
	var legacy(default, null):Bool;

	/**
	 * Sets the blendmode of the filter. Default: PIXI.BLEND_MODES.NORMAL
	 */
	var blendMode:BlendModes;

	/**
	 * Program that the shader uses
	 */
	var program:Program;

	/**
	 * The WebGL state the filter requires to render
	 */
	var state:State;

	/**
	 * The vertex shader.
	 *
	 * @member {String}
	 */
	var vertexSrc:String;

	/**
	 * The fragment shader.
	 *
	 * @member {String}
	 */
	var fragmentSrc:String;

	/**
	 * An object containing the current values of custom uniforms.
	 * @example <caption>Updating the value of a custom uniform</caption>
	 * filter.uniforms.time = performance.now();
	 *
	 * @member {Dynamic}
	 */
	var uniforms:Dynamic;

	/**
	 * The padding of the filter. Some filters require extra space to breath such as a blur.
	 * Increasing this will add extra width and height to the bounds of the object that the
	 * filter is applied to.
	 *
	 * @member {Float}
	 */
	var padding:Float;

	/**
	 * The resolution of the filter. Setting this to be lower will lower the quality but
	 * increase the performance of the filter.
	 *
	 * @member {Float}
	 */
	var resolution:Float;

	/**
	 * If enabled is true the filter is applied, if false it will not.
	 *
	 * @member {Bool}
	 */
	var enabled:Bool;

	/**
	 * If enabled, PixiJS will fit the filter area into boundaries for better performance. Switch it off if it does not work for specific shader.
	 * Workaround for http://jsfiddle.net/xbmhh207/1/
	 * @default true
	 * @member {Bool}
	 */
	var autoFit:Bool;

	/*
	 * Applies the filter
	 * @param filterManager {FilterSystem}
	 * @param input {RenderTexture}
	 * @param output {RenderTexture}
	 * @param clear {Bool} Whether or not we want to clear the outputTarget
	 * @param {object} [currentState] - It's current state of filter.
	 *        There are some useful properties in the currentState :
	 *        target, filters, sourceFrame, destinationFrame, renderTarget, resolution
	 */
	function apply(filterManager:FilterSystem, input:RenderTexture, output:RenderTexture, ?clear:Bool, ?currentState:CurrentState):Void;
}

extern interface CurrentState implements Dynamic {
	var destinationFrame:Rectangle;
	var filters:Array<Filter>;
	var renderTarget:RenderTarget;
	var resolution:Float;
	var sourceFrame:Rectangle;
	var target:DisplayObject;
}
