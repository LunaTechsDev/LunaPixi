package pixi.spine;

import pixi.core.display.Container;

@:native("PIXI.Spine")
extern class Spine {

	/**
	 * A class that enables the you to import and run your spine animations in pixi.
	 * The Spine animation data needs to be loaded using either the Loader or a SpineLoader before it can be used by this class
	 * See example 12 (http://www.goodboydigital.com/pixijs/examples/12/) to see a working example and check out the source
	 *
	 * ```js
	 * 	var spineAnimation = new PIXI.Spine(spineData);
	 * ```
	 *
	 * @class
	 * @extends Container
	 * @memberof PIXI.spine
	 * @param spineData {object} The spine data loaded from a spine atlas.
	 */
	function new(spineData:Dynamic);

	/**
     * If this flag is set to true, the spine animation will be autoupdated every time
     * the object id drawn. The down side of this approach is that the delta time is
     * automatically calculated and you could miss out on cool effects like slow motion,
     * pause, skip ahead and the sorts. Most of these effects can be achieved even with
     * autoupdate enabled but are harder to achieve.
     *
     * @member {boolean}
     * @memberof Spine#
     * @default true
     */
	var autoUpdate:Bool;

	/**
     * The spineData object
     *
     * @member {object}
     */
	var spineData:Dynamic;

	/**
     * A spine Skeleton object
     *
     * @member {object}
     */
	var skeleton:Dynamic;

	/**
     * A spine AnimationStateData object created from the spine data passed in the constructor
     *
     * @member {object}
     */
	var stateData:Dynamic;

	/**
     * A spine AnimationState object created from the spine AnimationStateData object
     *
     * @member {object}
     */
	var state:Dynamic;

	/**
     * An array of containers
     *
     * @member {Array<Container>}
     */
	var slotContainers:Array<Container>;

	/**
	 * Update the spine skeleton and its animations by delta time (dt)
	 *
	 * @param dt {Float} Delta time. Time by which the animation should be updated
	 */
	function update(dt:Float):Void;
}