package fanshymy.controller.util
{
	import flash.display.BitmapData;
	
	import ghostcat.util.easing.TweenUtil;
	
	import fanshymy.proxy.vo.RoleAssetsVO;
	import fanshymy.view.role.MapObject;

	/**
	 * 角色管理 
	 * @author Leo
	 * 
	 */	
	public class RoleManage
	{
		private static var _I :RoleManage = null;
		/**
		 * 角色位图信息缓存
		 */		
		public var roleBMDList :Vector.<RoleAssetsVO> = new Vector.<RoleAssetsVO>;
		/**
		 * 角色实例列表 
		 */		
		public var roleList :Vector.<MapObject> = new Vector.<MapObject>();
		public function RoleManage(prv :PrivateClass)
		{
			
		}
		/**
		 * 获取角色相应的位图列表 
		 * @param roleID
		 * @param action
		 * @return 
		 * 
		 */		
		public function getRoleBMDList(roleID :int,action :String):Vector.<BitmapData>
		{
			for each(var roleAssetsVO :RoleAssetsVO in this.roleBMDList)
			{
				if(roleAssetsVO.roleID == roleID && roleAssetsVO.action == action)
				{
					return roleAssetsVO.bmdList;
				}
			}
			return null;
		}
		/**
		 * 获取地图上的角色实例 
		 * @param objID
		 * @return 
		 * 
		 */		
		public function getMapObj(objID :int):MapObject
		{
			for each(var mapObj :MapObject in this.roleList)
			{
				if(mapObj.addObjVO.objID == objID)
				{
					return mapObj;
				}
			}
			return null;
		}
		/**
		 *  获取地图上的角色实例列表
		 * @param objIDList
		 * @return 
		 * 
		 */		
		public function getMapObjList(objIDList :Array):Array
		{
			var result :Array = [];
			
			for each(var id :String in objIDList)
			{
				var obj :MapObject = getMapObj(int(id));
				if(obj)
				{
					result.push(obj);
				}
			}
			return result;
		}
		/**
		 * 销毁角色缓存的位图 
		 * 
		 */		
		public function destroyAllBMD():void
		{
			trace("销毁位图引用");
			
			var list :Vector.<RoleAssetsVO> = RoleManage.I.roleBMDList;
			
			for(var i :int = list.length - 1; i >= 0; i--)
			{
				var vo :RoleAssetsVO = list[i] as RoleAssetsVO;
				
				for (var index :int = vo.bmdList.length - 1; index >= 0; index--)
				{
					var bmd :BitmapData = vo.bmdList[index] as BitmapData;
					bmd.dispose();
					bmd = null;
					vo.bmdList.splice(index,1);
				}
				
				list.splice(i,1);
			}
			
			list = new Vector.<RoleAssetsVO>();
		}
		
		public function destroyRoleObj():void
		{
			for(var i :int = this.roleList.length - 1; i >= 0; i--)
			{
				var mapObj :MapObject = this.roleList[i] as MapObject;
				if(mapObj)
				{
					TweenUtil.removeTween(mapObj,false);
					mapObj.destroy();
					mapObj = null;
				}
				this.roleList.splice(i,1);
			}
			this.roleList.length = 0;
		}

		public static function get I():RoleManage
		{
			if(_I == null)
			{
				_I = new RoleManage(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}