package managers
{
	import as3isolib.display.IsoView;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class MouseManager implements IManager
	{
		private var view:IsoView;
		private var stage:Stage;
		private var _running:Boolean
		public function get running():Boolean { return _running;}
		public function MouseManager(view:IsoView) {
			this.view = view;
			_running = false;
		}
		public function start():void {
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, zoom);
			_running = true;
		}
		public function stop():void {
			stage.removeEventListener(MouseEvent.MOUSE_WHEEL, zoom);
			_running = false;
		}
		public function notifyChange(args:Array):void {
			this[args[0]] = args[1];
			if (running) {
				stop();
				start();
			}
		}
		
		//-------Event Listeners------------
		private function zoom(e:MouseEvent) {
			if (e.delta > 0)
				view.currentZoom += 0.1
			if (e.delta < 0)
				view.currentZoom-=0.1
		}
		
	}

}