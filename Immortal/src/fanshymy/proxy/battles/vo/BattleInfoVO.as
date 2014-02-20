package fanshymy.proxy.battles.vo
{
	import fanshymy.proxy.battles.action.IBattleAction;

	public class BattleInfoVO implements IBattleAction
	{
		/**
		 * 战役ID 
		 */		
		public var id :int;
		/**
		 * 战役名字 
		 */		
		public var name :String;
		/**
		 * 战役获得经验 
		 */		
		public var exp :int;
		/**
		 * 战役获得金币 
		 */		
		public var gold :int;
		/**
		 * 战役获得物品ID 
		 */		
		public var itemID :int;
		/**
		 * 战役地图ID 
		 */		
		public var battleMapID :String;
		public function BattleInfoVO()
		{
		}
		/**
		 * 解析 
		 * @param actionXML
		 * @param battleVO
		 * 
		 */		
		public function parse(actionXML:XML,battleVO:BattleVO):void
		{
			battleVO.battleInfoVO.id = actionXML.@id;
			battleVO.battleInfoVO.battleMapID = actionXML.@battleMapID;
			battleVO.battleInfoVO.exp = actionXML.@exp;
			battleVO.battleInfoVO.gold = actionXML.@gold;
			battleVO.battleInfoVO.itemID = actionXML.@itemID;
			battleVO.battleInfoVO.name = actionXML.@name;
		}
		/**
		 * 执行 
		 * @param battleVO
		 * 
		 */		
		public function exec():void
		{
			
		}
	}
}