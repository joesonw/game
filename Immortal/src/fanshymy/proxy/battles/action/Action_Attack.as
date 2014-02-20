package fanshymy.proxy.battles.action
{
	import flash.geom.Point;
	
	import ghostcat.events.OperationEvent;
	import ghostcat.operation.DelayOper;
	import ghostcat.operation.FunctionOper;
	import ghostcat.operation.GroupOper;
	import ghostcat.operation.Queue;
	import ghostcat.operation.TweenOper;
	import ghostcat.operation.WaitOper;
	import ghostcat.util.easing.TweenUtil;
	
	import fanshymy.controller.util.LayerUtil;
	import fanshymy.controller.util.PlayerUtil;
	import fanshymy.controller.util.RoleManage;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.item.BloodEffect;
	import fanshymy.proxy.battles.item.FightingText;
	import fanshymy.proxy.battles.item.SkillEffect;
	import fanshymy.proxy.battles.item.SkillText;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.battles.vo.AttackVO;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.view.role.MapObject;
	import fanshymy.view.ui.UIBattleView;

	/**
	 * 播放动作-攻击 
	 * @author Leo
	 * 
	 */
	public class Action_Attack extends BaseBattleAction
	{
		public var attackVO :AttackVO;
		/**
		 * 发动攻击者 
		 */		
		public var fireObj :MapObject;
		/**
		 * 被攻击的目标数组 ，有可能是一个或多个 
		 */		
		public var targetObjList :Array;

		
		public function Action_Attack()
		{
			super();
		}
		
		override public function parse(actionXML:XML,battleVO:BattleVO):void
		{
			super.parse(actionXML,battleVO);
			this.attackVO = new AttackVO();
			this.attackVO.parse(actionXML,battleVO);
		}
		
		override public function exec():void
		{
			fireObj = RoleManage.I.getMapObj(this.attackVO.fire);
			targetObjList = RoleManage.I.getMapObjList(this.attackVO.target);
			
			var targetList :Array = [];
			var targetObj :MapObject;
			var listQueue :Array = [];
			//一起执行，不分先后的
			var groupList :Array = [];
			if(this.attackVO.isSkill)   //使用技能
			{
				//增加释放技能效果
				groupList.push(new SkillEffect(this.fireObj));
				groupList.push(new SkillText(this.fireObj.parent,this.attackVO.skillID));
				groupList.push(new FunctionOper(this.fireObj.animation.playAttack));
				groupList.push(new FunctionOper(PlayerUtil.I.playSkillMusic));
				listQueue.push(new GroupOper(groupList));
			}else   //不是使用技能,则需要近身攻击
			{
				//不使用技能只能攻击单一目标，取第一个
				targetObj = targetObjList[0];
				var targetWidth :int = targetObj.addObjVO.roleType == AddObjectVO.TYPE_HERO ? targetObj.width : -targetObj.width;
				//移动
				listQueue.push(new TweenOper(this.fireObj,
											100 * GameConst.SPEED,
											{x:targetObj.x + targetWidth,y:targetObj.y}));
				//攻击动作
				listQueue.push(new FunctionOper(this.fireObj.animation.playAttack));
				listQueue.push(new WaitOper(this.fireObj.animation.checkIsPlayEnd));
				
			}
			
			//释放技能时等人物播放完攻击动作再播放伤害效果
			if(this.attackVO.isSkill)
			{
				listQueue.push(new WaitOper(this.fireObj.animation.checkIsPlayEnd));
			}
			
			//受伤动作
			groupList = [];
			var isAddHurtMusic :Boolean = false;
			for(var i :int = 0; i < targetObjList.length; i++)
			{
				targetObj = targetObjList[i] as MapObject;
				var damage :int = this.attackVO.damage[i];
				if(damage > 0 && !this.attackVO.isJink)
				{
					groupList.push(new FunctionOper(targetObj.animation.playHurt));
					//抵挡
					if(this.attackVO.isResis)
					{
						groupList.push(new FightingText(targetObj,FightingText.RESIS));
					}
					//暴击
					if(this.attackVO.isCrucial)
					{
						groupList.push(new FightingText(targetObj,FightingText.CRUCIAL));
					}
					groupList.push(new BloodEffect(targetObj,damage));
					groupList.push(new FunctionOper(targetObj.subHP,[damage]));
					
					if(!isAddHurtMusic)  //还没增加受伤音乐
					{
						groupList.push(new FunctionOper(PlayerUtil.I.playHurtMusic));
						isAddHurtMusic = true;
					}
				}else   //没伤害且是闪避
				{
					groupList.push(new FightingText(targetObj,FightingText.JINK));
					var dx :int = targetObj.addObjVO.roleType == AddObjectVO.TYPE_HERO ? -30 : 30;
					groupList.push(new TweenOper(targetObj,10 * GameConst.SPEED,
						{x :targetObj.x + dx}));

				}
			}
			listQueue.push(new GroupOper(groupList));
			
			//显示完闪避和做了闪避动作再回复原位
			if(this.attackVO.isJink)  
			{
				listQueue.push(new TweenOper(targetObj,20 * GameConst.SPEED,
					{x :targetObj.x}));
			}
			
			//反击
			if(this.attackVO.isBackAttack)
			{
				groupList = [];
				groupList.push(new FunctionOper(targetObj.animation.playAttack));
				groupList.push(new FightingText(targetObj,FightingText.BACK_ATTACK));
				listQueue.push(new GroupOper(groupList));
				if(this.attackVO.backAttackDamage > 0)
				{
					groupList = [];
					groupList.push(new FunctionOper(this.fireObj.animation.playHurt));
					groupList.push(new BloodEffect(this.fireObj,this.attackVO.backAttackDamage));
					listQueue.push(new GroupOper(groupList));
				}
			}
			
			
			//攻击完毕返回
			if(!this.attackVO.isSkill)
			{
				var goBackP :Point = PlayerUtil.I.getGoBackPoint(this.fireObj);
				listQueue.push(new TweenOper(this.fireObj,50 * GameConst.SPEED,
					{x :goBackP.x, y :goBackP.y}));
			}
			
			queue = new Queue(listQueue);
			queue.execute();
			queue.addEventListener(OperationEvent.OPERATION_COMPLETE,queueCompleteHandler);
		}
		
	    protected function queueCompleteHandler(e :OperationEvent = null):void
		{
			if(e)
			{
				e.oper.removeEventListener(OperationEvent.OPERATION_COMPLETE,queueCompleteHandler);
			}
			allActionFinish = true;
			TweenUtil.removeAllTween(false);
			if(queue)
			{
				queue.result(e);
				this.queue = null;
			}
			trace("一条有效命令执行完毕");
		}
		
			
	}
}