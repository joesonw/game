package 
{
	import as3isolib.display.IsoView;
	import flash.display.Stage;
	import managers.IManager;
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class EngineManager 
	{
		private var _managers:Vector.<IManager>
		private var view:IsoView;
		private var stage:Stage;
		public function EngineManager(stage:Stage) {
			_managers = new Vector.<IManager>();
			this.stage = stage;
		}
		public function addManager(item:IManager):void { 
			item.notifyChange(new Array("stage", stage));
			_managers.push(item);
		}
		public function startAll():void {
			for each (var i:IManager in _managers) {
				if (!i.running)
					i.start();
			}
		}
		public function stopAll():void {
			for each (var i:IManager in _managers) {
				if (i.running)
					i.stop();
			}
		}
		public function notifyChange(args:Array) {
			for each (var i:IManager in _managers) {
				i.notifyChange(args);
			}
		}
	}

}