package fanshymy.proxy.battles.vo
{
	/**
	 * 增加对象到地图上的VO 
	 * @author Leo
	 * 
	 */	
	public class AddObjectVO extends BaseActionVO
	{
		/**
		 * 角色类型-玩家 
		 */		
		public static const TYPE_HERO :int = 1;
		/**
		 * 角色类型-敌人 
		 */		
		public static const TYPE_MONSTER :int = 2;
		/**
		 * 角色ID 
		 */		
		public var roleID:int;
		/**
		 * 对象ID,用来找地图上唯一的值对象
		 */		
		public var objID :int;
		/**
		 * 角色类型  玩家or敌人
		 */		
		public var roleType :int;
	
		/**
		 * 位置值 
		 */		
		public var place :String;
		/**
		 * 名字 
		 */		
		public var name:String;
		/**
		 * 血量 
		 */		
		public var hp:int;
		/**
		 * 魔法值 
		 */		
		public var mp:int;
		
		public function AddObjectVO()
		{
		}
		/**
		 * 解析xml为对象 
		 * @param actionXML
		 * @param battleVO
		 * 
		 */		
		override public function parse(actionXML :XML,battleVO :BattleVO):void
		{
			this.roleID = actionXML.@roleID;
			this.name = actionXML.@name;
			this.place = actionXML.@place;
			this.roleType = actionXML.@roleType;
			this.hp = actionXML.@hp;
			this.mp = actionXML.@mp;
			this.objID = actionXML.@objID;
			battleVO.battleObjects.push(this);
		}
	}
}