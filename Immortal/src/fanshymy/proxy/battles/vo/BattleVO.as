package fanshymy.proxy.battles.vo
{
	import flash.utils.Dictionary;
	/**
	 * 战役VO 
	 * @author Leo
	 * 
	 */
	public class BattleVO
	{
		/**
		 * 战役信息VO 
		 */		
		public var battleInfoVO :BattleInfoVO;
		/**
		 * 战役中所有的动作 
		 */		
		public var actions:Array = new Array();
//		/**
//		 * 复制的战役中所有的动作 数组 
//		 */		
//		public var copyActions :Array;
		/**
		 * 战役的参战对象VO列表 
		 */		
		public var battleObjects:Vector.<AddObjectVO> = new Vector.<AddObjectVO>();
		public function BattleVO()
		{
			battleInfoVO = new BattleInfoVO();
		}
		
	}
}