package fanshymy.view.ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import ghostcat.manager.SoundManager;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.controller.util.LayerUtil;
	import fanshymy.controller.util.PlayerUtil;
	import fanshymy.controller.util.RoleManage;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.action.BaseBattleAction;
	import fanshymy.proxy.battles.action.IBattleAction;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.proxy.transmission.LoaderUtil;
	import fanshymy.proxy.vo.BaseUI;
	import fanshymy.proxy.vo.RoleAssetsVO;
	import fanshymy.view.role.MapObject;
	
	/**
	 * 战斗视图层 
	 * @author Leo
	 * 
	 */	
	public class UIBattleView extends Sprite
	{
		public static const NAME :String = "UIBattleView";
		public var battleMap :UIBattleMap;
		public var battlePlace :UIBattlePlace;
		public var battleRoleLayer :UIBattleRoleLayer;
		public var btnStartBattle :SimpleButton;
		public var btnExitBattle :SimpleButton;
		
		public  var battleVO :BattleVO;
		private var timer :Timer;
		public function UIBattleView(battleVO :BattleVO)
		{
			this.battleVO = battleVO;
			super();
			
			if(!this.battleVO)
			{
				return;
			}
			if(stage)
			{
				init();
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
			
		}
		
		private function init(e :* = null):void
		{
			
			removeEventListener(Event.ADDED_TO_STAGE,init);
			this.battleMap = new UIBattleMap(this.battleVO.battleInfoVO.battleMapID);
			this.addChild(this.battleMap);
			
			this.battlePlace =  new UIBattlePlace();
			this.addChild(this.battlePlace);
			
			this.battleRoleLayer = new UIBattleRoleLayer(this.battleVO,battlePlace);
			this.addChild(this.battleRoleLayer);
			
			this.btnExitBattle = BitmapUtil.I.getBtnByName("BtnExitBattle");
			if(this.btnExitBattle)
			{
				this.addChild(this.btnExitBattle);
				this.btnExitBattle.x = stage.stageWidth - 150;
				this.btnExitBattle.y = stage.stageHeight - 70;
			}
			this.btnStartBattle = BitmapUtil.I.getBtnByName("BtnStartBattle");
			if(this.btnStartBattle)
			{
				this.addChild(this.btnStartBattle);
				this.btnStartBattle.x = stage.stageWidth - 250;
				this.btnStartBattle.y = stage.stageHeight - 70;
			}
			
			this.timer = new Timer(30);
			this.timer.addEventListener(TimerEvent.TIMER,timerHandler);
			this.timer.start();
			
			addEventListener(MouseEvent.MOUSE_UP,clickHandler);
			
			//播放战斗音乐
			PlayerUtil.I.playBattleMusic();
		}
		
		private function clickHandler(e :MouseEvent):void
		{
			switch(e.target)
			{
				case this.btnExitBattle:
					trace("退出战斗");
					destroy();
					break;
				case this.btnStartBattle:
					trace("开始战斗");
					startBattle();
					this.btnStartBattle.visible = false;
					break;
			}
		}
		/**
		 * timer更新显示对象 
		 * @param e
		 * 
		 */		
		private function timerHandler(e :TimerEvent):void
		{
			var list :Vector.<MapObject> = RoleManage.I.roleList;
			if(!list || list.length == 0)
			{
				return;
			}
			
			for each(var mapObj :MapObject in list)
			{
				mapObj.update();
			}
			
			PlayerUtil.I.update();
		}
		/**
		 * 开始战役
		 */		
		private function startBattle():void
		{
			PlayerUtil.I.playBattle(this.battleVO.actions);
			
		}
		/**
		 * 销毁 
		 * 
		 */		
		public function destroy():void
		{
			removeEventListener(MouseEvent.MOUSE_UP,clickHandler);
			this.timer.stop();
			this.timer.removeEventListener(TimerEvent.TIMER,timerHandler);
			this.timer = null;
			
			RoleManage.I.destroyRoleObj();
			PlayerUtil.I.resetAction();
			
			delete LayerUtil.I.layerDict[UIBattleView.NAME];
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			
			if(GameConst.main)
			{
				GameConst.main.show();
			}
			
			PlayerUtil.I.stopBattleMusic();
		}
	}
}