package fanshymy
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.profiler.showRedrawRegions;
	import fanshymy.controller.util.LayerUtil;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.transmission.LoaderUtil;
	import fanshymy.view.ui.BtnBattle;
	import fanshymy.view.ui.BtnBattleTips;
	import fanshymy.view.ui.UIBattleList;
	
	[SWF(width="1250",height="650",frameRate="24",backgroundColor="0x000000")]
	public class BattlePlayer extends Sprite
	{
		private var curView :*;
		private var battleLayer :Sprite;
		private var popLayer :Sprite;
		private var btnBattle :BtnBattle;
		private var btnBattleTips :BtnBattleTips;
		public function BattlePlayer()
		{
			init();
			
		}
		
		private function init():void
		{
			
			LoaderUtil.I.loadConfig();
			this.battleLayer = new Sprite();
			this.popLayer = new Sprite();
			this.addChild(battleLayer);
			this.addChild(popLayer);
			LayerUtil.I.layerDict[GameConst.BATTLE_LAYER] = this.battleLayer;
			LayerUtil.I.layerDict[GameConst.POP_LAYER] = this.popLayer;
			GameConst.main = this;
			
			
		}
		
		public function rhand():void
		{
			btnBattle = new BtnBattle();
			this.addChild(btnBattle);
			btnBattleTips = new BtnBattleTips();
			btnBattleTips.x = btnBattle.x + btnBattle.width - 20;
			btnBattleTips.y = btnBattle.y + btnBattle.height - 20;
			btnBattleTips.mouseChildren = btnBattleTips.mouseEnabled = false;
			this.addChild(btnBattleTips);
			btnBattle.addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
		}
		
		public function setStage(view :*):void
		{
			if(this.curView && this.battleLayer && this.battleLayer.contains(this.curView))
			{
				this.curView.destroy;
				this.battleLayer.removeChild(this.curView);
			}
			battleLayer.addChild(view);
		}
		
		public function show():void
		{
			btnBattle.visible = true;
			btnBattle.mouseChildren = btnBattle.mouseEnabled = true;
			btnBattleTips.play();
		}
		
		public function hide():void
		{
			btnBattle.visible = false;
			btnBattle.mouseChildren = btnBattle.mouseEnabled = false;
			btnBattleTips.stop();
		}
		
		private function mouseHandler(e :MouseEvent):void
		{
			var view :UIBattleList = new UIBattleList(null);
			setStage(view);
			hide();
		}
	}
}