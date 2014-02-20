package fanshymy.view.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.transmission.LoaderUtil;
	import fanshymy.proxy.vo.MapUIVO;

	/**
	 * 战斗地图类 
	 * @author Leo
	 * 
	 */	
	public class UIBattleMap extends Sprite
	{
		private var loader :Loader;
		private var mapUIVO :MapUIVO;
		private var smallLoading :UISmallLoading;
		private var battleMap :Bitmap;
		private var mapID :String;
		public function UIBattleMap(mapID :String)
		{
			super();
			
			if(mapID)
			{
				this.mapID = mapID;
				addEventListener(Event.ADDED_TO_STAGE,init);
			}else
			{
				trace("没有地图ID");
			}
		}
		
		private function init(e :* = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			mapUIVO = new MapUIVO(mapID,"");
			var value :Boolean = LoaderUtil.I.checkIsLoad(mapUIVO.jpg);
			if(value)
			{
				this.battleMap = LoaderUtil.I.battleMapDict[mapUIVO.jpg];
				this.addChild(this.battleMap);
				return;
			}
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,mapCompleteHandler);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,mapErrorHandler);
			loader.load(new URLRequest(mapUIVO.jpg));
			LoaderUtil.I.fileList[mapUIVO.jpg] = mapUIVO;
			if(this.smallLoading)
			{
				this.smallLoading.destroy();
			}
			this.smallLoading = new UISmallLoading();
			this.addChild(this.smallLoading);
			this.smallLoading.mc.play();
			this.smallLoading.setPosition();
			
		}
		
		private function mapCompleteHandler(e :Event):void
		{
			if(this.smallLoading)
			{
				this.smallLoading.destroy();
			}
			this.battleMap = this.loader.content as Bitmap;
			this.addChild(this.battleMap);
			LoaderUtil.I.battleMapDict[mapUIVO.jpg] = this.battleMap;
			mapUIVO.complete();
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,mapCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,mapErrorHandler);
			loader.unload();
			this.loader = null;

		}
		
		private function mapErrorHandler(e :IOErrorEvent):void
		{
			if(this.smallLoading)
			{
				this.smallLoading.destroy();
			}
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,mapCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,mapErrorHandler);
			trace("加载地图出错  " + loader.loaderInfo.url);
			loader.unload();
			delete LoaderUtil.I.fileList[mapUIVO.swfPath];
		}
		
		
		public function destroy():void
		{
			if(loader)
			{
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,mapCompleteHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,mapErrorHandler);
				loader.unloadAndStop();
				loader.unload();
				this.loader = null;
			}
			
			if(this.battleMap)
			{
				this.removeChild(this.battleMap);
			}
			
			if(this.smallLoading)
			{
				this.smallLoading.destroy();
			}
			
		}
	}
}