package fanshymy.proxy.battles.action
{
	import fanshymy.proxy.battles.vo.BattleVO;

	public interface IBattleAction
	{
		 function parse(actionXML:XML,battleVO:BattleVO):void;
		
		 function exec():void;
	}
}