package fanshymy.proxy.vo
{
	import fanshymy.proxy.GameConst;
	/**
	 * 加载UIVO基类 
	 * @author Leo
	 * 
	 */
	public class BaseUI
	{
		public var fileName :String;
		public var linkName :String;
		public var isLoading :Boolean = true;
		public var isComplete :Boolean = false;
		public function BaseUI(fileName :String , linkName :String)
		{
			this.fileName = fileName;
			this.linkName = linkName;
		}
		
		public function get swfPath():String
		{
			return GameConst.uiDir + this.fileName + ".swf";	
		}
		
		
		public function complete():void
		{
			this.isComplete = true;
			this.isLoading = false;
		}
	}
}