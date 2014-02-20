package map
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoScene;
	import flash.display.Loader;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class MapEngine 
	{
		private var mapRunning:Boolean;
		private var view:IsoView;
		private var xml:XML;
		private var resourceLibraryData:Vector.<String>
		private var resourceLibraries:Vector.<IResourceLib>;
		private var resources:Object;
		private var resourceLoader:Loader;
		private var stage:Stage;
		public function MapEngine(view:IsoView,stage:Stage) 
		{
			mapRunning = false;
			this.view = view;
			this.stage = stage;
		}
		/**
		 * load the compressed XML file
		 * @param	filepath
		 */
		public function loadMap(filepath:String) {
			if (mapRunning)
				throw new Error("current map must be unloaded first");
			mapRunning = false;
			resourceLibraries = new Vector.<IResourceLib>();
			resourceLibraryData = new Vector.<String>();
			var byteLoader:URLLoader = new URLLoader();
			byteLoader.dataFormat = URLLoaderDataFormat.BINARY;
			byteLoader.addEventListener(Event.COMPLETE, _binaryLoaded);
			byteLoader.load(new URLRequest(filepath));
		}
		public function unloadCurrentMap() {
			
			mapRunning = false;
		}
		private function drawMap() {
			//view.setSize(xml.header.width, xml.header.height);
			var s:IsoScene = new IsoScene();
			view.addChild(s);
			for each (var i:XML in xml.body) {
				var item:IsoSprite = new IsoSprite();
			}
		}
		private function loadResources():void {
			resourceLoader = new Loader();
			resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, _resourceLoaded);
			resourceLoader.load(new URLRequest( resourceLibraryData.shift()))
		}
		
		//Event Listeners
		private function _binaryLoaded(e:Event) {
			e.currentTarget.removeEventListener(e.type, _binaryLoaded);
			var bytes:ByteArray = e.target.data as ByteArray;
			//bytes.uncompress();
			xml = new XML(bytes);
			//needs GC!!!!!!!!!!!!!
			for (var i:uint; i < xml.libraries.lib.length(); i++) {
				resourceLibraryData.push(xml.libraries.lib[i]);
			}
			//e.currentTarget.unloadAndStop();
			loadResources();
		}
		private function _resourceLoaded(e:Event) {
			e.currentTarget.removeEventListener(Event.COMPLETE, _resourceLoaded);
			//needs GC!!!!!!!!!!!!!!!!
			resourceLibraries.push(e.target.content);
			//e.target.loader.unloadAndStop();
			if (resourceLibraryData.length > 0) {
				loadResources();
			} else {
				drawMap();
			}
		}
	}

}