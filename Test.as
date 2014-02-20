package  
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.utils.getDefinitionByName
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class Test extends MovieClip implements IResourceLib
	{
		
		public function Test() {}
		public function getResource(id:String):DisplayObject {
			var className:Class = getDefinitionByName(id) as Class;
			var result:DisplayObject = new className();
			return result;
		}
	}

}