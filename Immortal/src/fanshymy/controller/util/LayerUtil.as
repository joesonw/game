package fanshymy.controller.util
{
	import flash.utils.Dictionary;
	/**
	 * 视图层管理器 
	 * @author Leo
	 * 
	 */
	public class LayerUtil
	{
		public var layerDict :Dictionary;
		private static var _I :LayerUtil = null;
		public function LayerUtil(prv :PrivateClass)
		{
			layerDict = new Dictionary();
		}
		
		public function getLayer(name :String):*
		{
			return layerDict[name];
		}

		public static function get I():LayerUtil
		{
			if(_I == null)
			{
				_I = new LayerUtil(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}