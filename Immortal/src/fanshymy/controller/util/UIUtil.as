package fanshymy.controller.util
{
	import flash.display.DisplayObject;
	
	import fanshymy.view.ui.UIBattleListItem;
	/**
	 * UI工具 
	 * @author Leo
	 * 
	 */
	public class UIUtil
	{
		private static var _I :UIUtil = null;
		public function UIUtil(prv :PrivateClass)
		{
		}
		
		public function binding(scoure :DisplayObject,itemList :Vector.<UIBattleListItem>,cls :Class,itemName:String = "item",start :int = 1,len :int = int.MAX_VALUE):void
		{
			var i:int = start;
			while(true)
			{
				var o:DisplayObject = scoure[itemName + i];
				if(!o) break;
				var tmp:Object;
				tmp = new cls(o)
				itemList.push(tmp);
				i++;
				if(i > len) break;
			}
		}

		public static function get I():UIUtil
		{
			if(_I == null)
			{
				_I = new UIUtil(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}