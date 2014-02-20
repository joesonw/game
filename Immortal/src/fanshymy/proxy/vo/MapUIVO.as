package fanshymy.proxy.vo
{
	import fanshymy.proxy.GameConst;
	/**
	 * 地图UIVo 
	 * @author Leo
	 * 
	 */
	public class MapUIVO extends BaseUI
	{
		public function MapUIVO(fileName:String, linkName:String)
		{
			super(fileName, linkName);
		}
		
		override public function get swfPath():String
		{
			return GameConst.mapDir + this.fileName + ".swf";
		}
		
		public function get jpg():String
		{
			return GameConst.mapDir + this.fileName + ".jpg";
		}
	}
}