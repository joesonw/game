package fanshymy.controller.util
{
	import flash.geom.Point;
	
	import ghostcat.manager.SoundManager;
	
	import fanshymy.proxy.battles.action.BaseBattleAction;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.view.role.MapObject;
	import fanshymy.view.ui.UIBattleResult;
	import fanshymy.view.ui.UIBattleView;

	/**
	 * 播放器工具 
	 * @author Leo
	 * 
	 */	
	public class PlayerUtil
	{
		private static var _I :PlayerUtil = null;
		/**
		 * 开始播放 
		 */		
		private var start :Boolean = false;
		/**
		 * 当前正在播放的动作 
		 */		
		private var curAction :BaseBattleAction;
		/**
		 * 当前播放的序列 
		 */		
		private var curIndex :int;
		/**
		 * 需要播放的列表 
		 */		
		private var actionList :Array;
		public function PlayerUtil(prv :PrivateClass)
		{
		}
		/**
		 * 开始播放战斗 
		 * @param actionList
		 * 
		 */		
		public function playBattle(actionList :Array):void
		{
			if(!actionList || actionList.length == 0)
			{
				return;
			}
			this.actionList = actionList;
			this.curIndex = 0;
			this.start = true;
			curAction = actionList[curIndex];
			curAction.exec();
			
		}
		/**
		 * 更新播放序列
		 * 
		 */		
		public function update ():void
		{
			if(!start || !this.actionList || this.actionList.length == 0)
			{
				return;
			}

			
			if(curAction.allActionFinish)
			{
				this.curIndex++;
				if(this.curIndex > this.actionList.length - 1)
				{
					//播放完成，战斗结束
					this.start = false;
					resetAction();
					winOrlose();
					return;
				}
				this.curAction = this.actionList[this.curIndex];
				this.curAction.exec();
			}
			
		}
		/**
		 * 获取近身攻击后人物返回的点 
		 * @param fireObj
		 * @return 
		 * 
		 */		
		public function getGoBackPoint(fireObj :MapObject):Point
		{
			var battleView :UIBattleView = LayerUtil.I.layerDict[UIBattleView.NAME] as UIBattleView;
			var home :Boolean = fireObj.addObjVO.roleType == AddObjectVO.TYPE_HERO ? true : false;
			var p :Point = battleView.battlePlace.getPlacePosition(fireObj.addObjVO.place,home);
			
			return p;
		}
		/**
		 * 停止战斗音乐
		 */		
		public function stopBattleMusic():void
		{
			//停止战斗音乐
			SoundManager.instance.stop("BattleMusic");
		}
		/**
		 * 播放战斗音乐
		 */		
		public function playBattleMusic():void
		{
			//停止战斗音乐
			SoundManager.instance.play("BattleMusic",-1);
		}
		/**
		 * 播放受伤音乐
		 */		
		public function playHurtMusic():void
		{
			SoundManager.instance.play("HurtMusic");
		}
		/**
		 * 播放技能效果音乐
		 */		
		public function playSkillMusic():void
		{
			SoundManager.instance.play("SkillMusic");
		}
		/**
		 * 重置战斗命令 
		 * 
		 */		
		public function resetAction():void
		{
			for each(var baseBattleAction :BaseBattleAction in this.actionList)
			{
				if(baseBattleAction.allActionFinish)
				{
					baseBattleAction.allActionFinish = false;
				}
				
				if(baseBattleAction.queue)
				{
					baseBattleAction.queue.halt();
				}
			}
		}
		
		private function winOrlose():void
		{
			var roleList :Vector.<MapObject> = RoleManage.I.roleList;
			var result :Boolean = false;
			for each(var mapObj :MapObject in roleList)
			{
				if(mapObj && mapObj.isAlive)
				{
					if(mapObj.addObjVO.roleType == AddObjectVO.TYPE_HERO)
					{
						result = true;
						break;
					}
				}
			}
			
			var uiBattleView :UIBattleView = LayerUtil.I.getLayer(UIBattleView.NAME) as UIBattleView;
			if(uiBattleView)
			{
				if(result)  //战斗胜利
				{
					uiBattleView.battleRoleLayer.addChild(new UIBattleResult(true));
				}else   // 战斗失败
				{
					uiBattleView.battleRoleLayer.addChild(new UIBattleResult(false));
				}
			}else
			{
				trace("PlayerUtil 战斗UI查找出错");
			}
		}

		public static function get I():PlayerUtil
		{
			if(_I == null)
			{
				_I = new PlayerUtil(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}