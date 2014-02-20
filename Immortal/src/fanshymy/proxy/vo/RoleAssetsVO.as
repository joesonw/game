package fanshymy.proxy.vo
{
	import flash.display.BitmapData;
	/**
	 * 角色资源VO 
	 * @author Leo
	 * 
	 */
	public class RoleAssetsVO
	{
		/**
		 *  角色动作
		 */		
		public var action :String;
		/**
		 * 角色动作位图列表 
		 */		
		public var bmdList :Vector.<BitmapData>;
		/**
		 * 角色ID 
		 */		
		public var roleID :int;
		public function RoleAssetsVO()
		{
			bmdList = new Vector.<BitmapData>();
		}
	}
}