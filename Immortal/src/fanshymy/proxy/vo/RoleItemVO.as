package fanshymy.proxy.vo
{
	import fanshymy.proxy.GameConst;

	/**
	 * 人物swf的VO 
	 * @author leo
	 * 
	 */	
	public class RoleItemVO extends BaseUI
	{
		private var roleID :int;
		public function RoleItemVO(fileName :String,linkName :String,roleID :int)
		{
			super(fileName,linkName);
			this.roleID = roleID;
		}
		
		override public function get swfPath():String
		{
			return GameConst.roleDir + roleID + "/" + fileName + ".swf";
		}
		
	}
}