package fanshymy.proxy.transmission
{
	import flash.display.Loader;
	/**
	 * 自定义显示对象加载器 
	 * @author Leo
	 * 
	 */	
	public class CustomLoader extends Loader
	{
		/**
		 * 加载路径 
		 */		
		public var id :String;
		/**
		 * 人物资源加载时用，用来区分人物的动作类型  attack,be_hit,fighting_idle 
		 */		
		public var roleType :String;
		/**
		 * 角色ID 
		 */		
		public var roleID :int;
		public function CustomLoader()
		{
			super();
		}
	}
}