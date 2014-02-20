package fanshymy.proxy.battles.vo
{
	import ghostcat.display.transfer.Boob;

	/**
	 * 攻击VO  技能必中，技能伤害是实际值，没有闪避，暴击，抵挡，反击。
	 * 普通攻击只能攻击一个目标，普通攻击时可能会产生
	 * 闪避，暴击，抵挡，反击
	 * @author Leo
	 * 
	 */	
	public class AttackVO extends BaseActionVO
	{
		/**
		 * 攻击者 
		 */		
		public var fire:int;
		/**
		 * 攻击目标数组，可能是一个或多个目标
		 */		
		public var target:Array;
		/**
		 * 伤害 
		 */		
		public var damage:Array;
		/**
		 * 是否使用技能 
		 */		
		public var isSkill :Boolean;
		/**
		 * 技能ID 
		 */		
		public var skillID :int;
		/**
		 * 是否反击 
		 */		
		public var isBackAttack :Boolean;
		/**
		 * 反击伤害 
		 */		
		public var backAttackDamage :int;
		/**
		 * 是否抵挡 
		 */		
		public var isResis :Boolean;
		/**
		 * 是否暴击 
		 */		
		public var isCrucial :Boolean ;
		/**
		 * 是否闪避 
		 */		
		public var isJink :Boolean;
		public function AttackVO()
		{
			super();
		}
		
		override public function parse(actionXML:XML, battleVO:BattleVO):void
		{
			this.fire = actionXML.@fire;
			var targetStr :String = (actionXML.@target);
			this.target = targetStr.split(",");
			var damageStr :String = (actionXML.@damage);
			this.damage = damageStr.split(",");
			this.isSkill = actionXML.@isSkill > 0 ? true :false
			this.skillID = actionXML.@skillID;
			this.backAttackDamage = actionXML.@backAttackDamage;
			this.isBackAttack = actionXML.@isBackAttack > 0 ? true : false;
			this.isCrucial = actionXML.@isCrucial > 0 ? true : false;
			this.isJink = actionXML.@isJink > 0 ? true : false;
			this.isResis = actionXML.@isResis > 0 ? true : false;
		}
	}
}