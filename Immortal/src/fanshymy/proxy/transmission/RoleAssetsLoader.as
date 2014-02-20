package fanshymy.proxy.transmission
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.controller.util.RoleManage;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.vo.RoleAssetsVO;
	import fanshymy.proxy.vo.RoleItemVO;

	/**
	 * 角色资源加载器 
	 * @author Leo
	 * 
	 */	
	public class RoleAssetsLoader
	{
		
		private var rhand :Function;
		private var fhand :Function;
		private var dict :Dictionary;
		private var index :int;
		private var sum :int;
		private var addObjVO :AddObjectVO;
		public function RoleAssetsLoader(vo :AddObjectVO,list :Array,rhand :Function = null,fhand :Function = null)
		{
			if(!vo)
			{
				return;
			}
			dict = new Dictionary();
			var fileDict :Dictionary = LoaderUtil.I.fileList;
			this.addObjVO = vo;
			this.rhand = rhand;
			this.fhand = fhand;
			this.sum = list.length;
			this.index = 0;
			for each(var str :String in list)
			{
				var roleItemVO :RoleItemVO = new RoleItemVO(str,"",vo.roleID);
				
				var loaderVO :RoleItemVO = fileDict[roleItemVO.swfPath];
				if(loaderVO)   //如果已经加载过
				{
					completeHandler(null);
				}else
				{
					var loader :CustomLoader = new CustomLoader();
					loader.id = roleItemVO.swfPath;
					loader.roleType = str;
					loader.roleID = vo.roleID;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,completeHandler);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,errorHandler);
					loader.load(new URLRequest(roleItemVO.swfPath));
					this.dict[roleItemVO.swfPath] = loader;
					fileDict[roleItemVO.swfPath] = roleItemVO;
				}
			}
			
		}
		
		private function completeHandler(e :Event):void
		{
//			this.index++;
//			var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
//			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
//			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
//			var roleType :String = loader.roleType;
//			var roleID :int = loader.roleID;
//			var i :int = 1;
//			var str :String = "image";
//			var name :String;
//			var cls :Class;
//			var bmd :BitmapData;
//			var roleList :Vector.<RoleAssetsVO> = RoleManage.I.roleBMDList;
//			var obj :RoleAssetsVO = new RoleAssetsVO();
//			obj.roleType = roleType;
//			obj.roleID = roleID;
//			while(i < int.MAX_VALUE)
//			{
//				name = str + i;
//				var value :Boolean = loader.contentLoaderInfo.applicationDomain.hasDefinition(name);
//				if(value)
//				{
//					cls = loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
//					bmd = new cls() as BitmapData;
//					obj.bmdList.unshift(bmd);
//				}else
//				{
//					break;
//				}
//				i++;
//			}
//			roleList.push(obj);
//			
//			if(this.dict[loader.id])
//			{
//				loader.unload();
//				delete this.dict[loader.id];
//				loader = null;
//			}
//			
//			if(this.index == this.sum)
//			{
//				if(this.rhand != null)
//				{
//					rhand();
//					rhand = null;
//					fhand = null;
//				}
//			}
			
			
			this.index++;
			var url :String;
			if(e != null)
			{
				var loader :CustomLoader = (e.target as LoaderInfo).loader as CustomLoader;
				loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,completeHandler);
				loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,errorHandler);
				url = loader.id;
				var roleType :String = loader.roleType;
				var roleID :int = loader.roleID;
				var i :int = 1;
				var str :String = "BMP_";
				var name :String;
				var cls :Class;
				var bmd :BitmapData;
				var roleList :Vector.<RoleAssetsVO> = RoleManage.I.roleBMDList;
				var obj :RoleAssetsVO = new RoleAssetsVO();
				obj.action = roleType;
				obj.roleID = roleID;
				
				//将SWF中的图片反射出来存好备用
				while(i < 50)
				{
					name = str + i;
					var value :Boolean = loader.contentLoaderInfo.applicationDomain.hasDefinition(name);
					if(value)
					{
						cls = loader.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
						bmd = new cls() as BitmapData;
						obj.bmdList.push(bmd);
					}else
					{
						break;
					}
					i+= 2;
				}
				
				//敌人图片需要反转
				switch(addObjVO.roleType)
				{
					case AddObjectVO.TYPE_HERO:
						break;
					case AddObjectVO.TYPE_MONSTER:
						obj.bmdList = BitmapUtil.I.rotationBitmapData(obj.bmdList);
						break;
				}
				
				roleList.push(obj);
				
				//删除加载器
				if(this.dict[loader.id])
				{
					loader.unload();
					delete this.dict[loader.id];
					loader = null;
				}
			}
			//加载完成
			if(this.index == this.sum)
			{
				if(e != null)
				{
					var fileDict :Dictionary = LoaderUtil.I.fileList;
					if(fileDict[url])
					{
						var roleItemVO :RoleItemVO = fileDict[url] as RoleItemVO;
						roleItemVO.complete();
					}
				}
				if(this.rhand != null)
				{
					rhand();
					rhand = null;
					fhand = null;
				}
			}
		}
		/**
		 * 加载出错 
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
			trace("人物资源出错");
		}
	}
}