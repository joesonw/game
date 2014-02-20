package network 
{
	import com.smartfoxserver.v2.core.SFSEvent;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.SmartFox;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class NetworkCore implements IEventDispatcher
	{
		private var sfs:SmartFox;
		private var _dispatcher:EventDispatcher;
		public function NetworkCore(sfs:SmartFox) 
		{
			this.sfs = sfs;
		}
		public function init():void {
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, _onResponse);
		}
		private function _onResponse(e:SFSEvent) {
			
			switch (e.params.cmd) {
				case ResponseCode.POS_UPDATE:
					_updatePosition(e);
			}
			
		}
		private function _updatePosition(e:SFSEvent) {
			var obj:SFSObject = e.params.params
			
		}
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			_dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			_dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return _dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return _dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean 
		{
			
		}
		
	}

}