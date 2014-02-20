package fanshymy.proxy.transmission
{
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.action.Action_AddObject;
	import fanshymy.proxy.battles.action.Action_Attack;
	import fanshymy.proxy.battles.action.IBattleAction;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.proxy.vo.BaseUI;
	import fanshymy.proxy.vo.RoleAssetsVO;

	/**
	 * 加载工具 
	 * @author leo
	 * 
	 */	
	public class LoaderUtil
	{
		private static var _I :LoaderUtil = null;
		/**
		 * 加载器缓存 
		 */		
		public var loaderDict :Dictionary = new Dictionary();
		/**
		 * 所有加载过的UI的VO 
		 */		
		public var fileList :Dictionary = new Dictionary();
		/**
		 * 缓存的战斗VO表 
		 */		
		public var battleVOList :Dictionary = new Dictionary();
		/**
		 * 缓存战斗地图 
		 */		
		public var battleMapDict :Dictionary = new Dictionary();
		/**
		 * 总加载数 
		 */		
		private var sum :int;
		/**
		 * 当前已加载数 
		 */		
		private var index :int;
		/**
		 * 加载列表成功函数 
		 */		
		private var rhand :Function;
		/**
		 * 加载列表失败函数 
		 */		
		private var fhand :Function;
		/**
		 *  加载UI成功函数
		 */		
		private var uiRhand :Function;
		/**
		 * 加载UI失败函数 
		 */		
		private var uiFhand :Function;
		public function LoaderUtil(prv :PrivateClass)
		{
		}
		/**
		 * 加载UI列表 
		 * @param list  完整路径列表
		 * @param rhand
		 * @param fhand
		 * 
		 */		
		public function loadList(list :Array,rhand :Function = null,fhand :Function = null):void
		{
			if(!list || list.length == 0)
			{
				return;
			}
			this.rhand = rhand;
			this.fhand = fhand;
			this.sum = 0;
			this.sum = list.length;
			for(var i :int = 0; i < list.length; i++)
			{
				var url :String = list[i] as String;
				var loader :CustomLoader = new CustomLoader();
				loader.id = url;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
				var loaderContext :LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
				loader.load(new URLRequest(url),loaderContext);
				this.loaderDict[loader.id] = loader;
			}
		}
		/**
		 * 加载UI列表成功 
		 * @param e
		 * 
		 */		
		private function completeHandler(e :Event):void
		{
			this.index++;
			var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			if(this.loaderDict[loader.id])
			{
				loader.unload();
				delete this.loaderDict[loader.id];
				loader = null;
			}
			
			if(this.index == this.sum)
			{
				if(this.rhand != null)
				{
					rhand();
					rhand = null;
					fhand = null;
				}
			}
		}
		/**
		 * 加载UI列表失败 
		 * @param e
		 * 
		 */		
		private function errorHandler(e :IOErrorEvent):void
		{
			if(this.fhand != null)
			{
				fhand();
				rhand = null;
				fhand = null;
			}
			var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			trace("加载组ui出错");
		}
		
		/**
		 * 加载单个UI 
		 * @param vo
		 * @param rhand
		 * @param fhand
		 * 
		 */		
		public function loadUI(vo :BaseUI,rhand :Function,fhand :Function = null):void
		{
			if(!vo)
			{
				return;
			}
			this.uiRhand = rhand;
			this.uiFhand = fhand;
			var url :String = vo.swfPath;
			var loader :CustomLoader = new CustomLoader();
			loader.id = url;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,uiComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,uiError);
			var loaderContext :LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
			loader.load(new URLRequest(url),loaderContext);
			this.loaderDict[loader.id] = loader;
			this.fileList[vo.swfPath] = vo;
		}
		/**
		 * 加载单个UI成功 
		 * @param e
		 * 
		 */		
		private function uiComplete(e :Event):void
		{
			var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			if(this.fileList[loader.id])
			{
				var vo :BaseUI = this.fileList[loader.id] as BaseUI;
				vo.isComplete = true;
				vo.isLoading = false;
			}
			
			if(this.loaderDict[loader.id])
			{
				loader.unload();
				delete this.loaderDict[loader.id];
				loader = null;
			}
			
			if(this.uiRhand != null)
			{
				this.uiRhand();
				this.uiRhand = null;
				uiFhand = null;
			}
			
		}
		/**
		 * 加载单个UI失败 
		 * @param e
		 * 
		 */		
		private function uiError(e :IOErrorEvent):void
		{
			var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
			if(this.uiFhand != null)
			{
				uiFhand();
				this.uiRhand = null;
				uiFhand = null;
			}
			trace("加载单个ui出错");
		}
		
		/**
		 * 加载config.xml 
		 * 
		 */		
		public function loadConfig():void
		{
			var str :String = GameConst.CONFIG_XML;
			var loader :URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,configComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,configError);
			loader.load(new URLRequest(str));
		}
		/**
		 * 加载config.xml成功 
		 * @param e
		 * 
		 */		
		private function configComplete(e :Event):void
		{
			var xml :XML = new XML(((e.target) as URLLoader).data);
			
			GameConst.uiDir = xml.uiDir;
			GameConst.itemDir = xml.itemDir;
			GameConst.roleDir = xml.roleDir;
			GameConst.mapDir = xml.mapDir;
			GameConst.battleXML = xml.battleXML;
			
			var str :String = xml.ui;
			var ary :Array = str.split(",");
			
			while(ary.length > 0)
			{
				var url :String = GameConst.uiDir + ary.pop() + ".swf";
				GameConst.uiList.push(url);
			}
			((e.target) as URLLoader).removeEventListener(Event.COMPLETE,configComplete);
			((e.target) as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR,configError);
			loadBattleData();
		}
		/**
		 * 加载config.xml失败 
		 * @param e
		 * 
		 */		
		private function  configError(e :IOErrorEvent):void
		{
			((e.target) as URLLoader).removeEventListener(Event.COMPLETE,configComplete);
			((e.target) as URLLoader).removeEventListener(IOErrorEvent.IO_ERROR,configError);
			trace("加载config出错");
		}
		/**
		 * 加载战斗XML 
		 * 
		 */		
		private function loadBattleData():void
		{
			var loader :URLLoader = new URLLoader();
			var url :String = GameConst.battleXML;
			loader.addEventListener(Event.COMPLETE,battleXMLComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR,battleXMLError);
			loader.load(new URLRequest(url));
		}
		/**
		 * 加载战斗XML成功 
		 * @param e
		 * 
		 */		
		private function battleXMLComplete(e :Event):void
		{
			var loader :URLLoader = e.target as URLLoader;
			var xml :XML = new XML(loader.data);
			
			for each(var battleXML :XML in xml.battle)
			{
				var battleVO :BattleVO = new BattleVO();
				battleVO.battleInfoVO.parse(battleXML,battleVO);
				
				
				for each(var actionXML :XML in battleXML.item)
				{
					var actionName :String= actionXML.@actionName;
					
					//注意一定要导入要实例化的类才能getDefinitionByName，要不然会报错
					importClass();
					var path :String = GameConst.PACKAGE_ACTION;
					var actionCls:Class = getDefinitionByName(path + actionName) as Class;
					var action:IBattleAction = new actionCls() as IBattleAction;
					action.parse(actionXML,battleVO);
					battleVO.actions.push(action);
				}
				this.battleVOList[battleVO.battleInfoVO.id] = battleVO;
			}

			loader.removeEventListener(Event.COMPLETE,battleXMLComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR,battleXMLError);
			loader = null;
			
			trace(".,,,,,,,,,,,,,,,,");
			loadList(GameConst.uiList,GameConst.main.rhand);
		}
		/**
		 * 加载战斗XML失败 
		 * @param e
		 * 
		 */		
		private function battleXMLError(e :IOErrorEvent):void
		{
			var loader :URLLoader = e.target as URLLoader;
			loader.removeEventListener(Event.COMPLETE,battleXMLComplete);
			loader.removeEventListener(IOErrorEvent.IO_ERROR,battleXMLError);
			trace("加载战斗XML出错");
		}
		
		public function checkIsLoad(swfPath :String):Boolean
		{
			var vo :BaseUI = this.fileList[swfPath] as BaseUI;
			if(vo && (vo.isLoading || vo.isComplete))
			{
				return true;
			}
			return false;
		}
		
		private function importClass():void
		{
			var cls1 :Action_AddObject;
			var cls2 :Action_Attack;
		}


		public static function get I():LoaderUtil
		{
			if(_I == null)
			{
				_I = new LoaderUtil(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}