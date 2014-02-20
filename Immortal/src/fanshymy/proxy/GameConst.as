package fanshymy.proxy
{
	import flash.filters.GlowFilter;
	
	import fanshymy.BattlePlayer;

	/**
	 * 游戏常用的常量 
	 * @author leo
	 * 
	 */	
	public class GameConst
	{
		public static var main :BattlePlayer = null;
//		public static const CONFIG_XML :String = "leo/assets/data/config.xml";
		public static const CONFIG_XML :String = "fanshymy/assets/data/config.xml";
		public static var itemDir :String;
		public static var uiDir :String;
		public static var roleDir :String;
		public static var mapDir :String;
		public static var battleXML :String;
		public static var uiList :Array = [];
		public static var smallLoading :String = "smallLoading";
		public static const POP_LAYER :String = "pop_layer";
		public static const BATTLE_LAYER :String = "battle_layer";
		
		public static const PACKAGE_ACTION :String = "fanshymy.proxy.battles.action.";
		public static const ROLE_ACTION_ARY :Array = ["attack","be_hit","fighting_idle"];
		public static const SPEED :int = 3;
		
		public static const MOUSE_ON :Array = [new GlowFilter(0xffff00,1,2,2,2,2)];
		public static const SKILL_NAME :Array = ["天魔杀星","冰凌剑空","灵木刺阵","十方剑气","天魔斩","八方棍法","雷动八方","琥珀冲杀","毒龙蚀天","地狱之火","葬林狂舞"];
		public function GameConst()
		{
		}
	}
}