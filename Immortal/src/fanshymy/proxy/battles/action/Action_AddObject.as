package fanshymy.proxy.battles.action
{
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.battles.vo.BattleVO;
	/**
	 * 播放动作-增加角色  
	 * @author Leo
	 * 
	 */
	public class Action_AddObject extends BaseBattleAction
	{
		public var addObjectVO :AddObjectVO;
		public function Action_AddObject()
		{
			super();
		}
		
		override public function parse(actionXML:XML,battleVO:BattleVO):void
		{
			super.parse(actionXML,battleVO);
			this.addObjectVO = new AddObjectVO();
			this.addObjectVO.parse(actionXML,battleVO);
			
		}
		
		override public function exec():void
		{
			super.exec();
			this.allActionFinish = true;
		}
	}
}