package fanshymy.proxy.battles.action
{
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.Queue;
	
	import fanshymy.proxy.battles.vo.BattleVO;

	/**
	 * 播放动作-基类 
	 * @author Leo
	 * 
	 */
	public class BaseBattleAction implements IBattleAction
	{
		public var TYPE_ADD :int = 1;
		public var TYPE_ATTACK :int = 2;
		/**
		 * 动作ID 
		 */		
		public var id :int;
		/**
		 * 动作类型，增加人物/攻击... 
		 */
		public var type :int;
		/**
		 * 战役VO 
		 */		
		public var battleVO :BattleVO;
		/**
		 * 所有命令执行完毕 
		 */		
		public var allActionFinish :Boolean = false;
		
		/**
		 * 队列 
		 */		
		public var queue:Queue;
		public function BaseBattleAction()
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
			this.type = actionXML.@type;
			this.id = actionXML.@id;
			this.battleVO = battleVO;
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