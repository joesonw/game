package fanshymy.view.ui
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import fanshymy.controller.util.LayerUtil;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.proxy.vo.BaseUI;

	/**
	 * 战役列表子项 
	 * @author Leo
	 * 
	 */	
	public class UIBattleListItem extends SimpleButton
	{
		public var txtBattleName :TextField;
		public var txtBattleContent :TextField;
		public var txtBattleAward :TextField;
		public var mcContent :MovieClip;
		public var btnShow :SimpleButton;
		private var mc :MovieClip;
		private var _data :BattleVO;
		public function UIBattleListItem(mc :* = null)
		{
			if(mc)
			{
				this.mc = mc;
				this.txtBattleAward = mc.txtBattleAward;
				this.txtBattleContent = mc.txtBattleContent;
				this.txtBattleName = mc.txtBattleName;
				this.mcContent = mc.mcContent;
				this.btnShow = mc.btnShow;
				
				mc.addEventListener(MouseEvent.MOUSE_OVER,mouseHandler);
				mc.addEventListener(MouseEvent.MOUSE_OUT,mouseHandler);
				mc.addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			}
			super();
		}
		
		private function mouseHandler(e :MouseEvent):void
		{
			switch(e.type)
			{
				case MouseEvent.MOUSE_OVER:
					if(this.mcContent)
					{
						this.mcContent.filters = GameConst.MOUSE_ON;
					}
					break;
				case MouseEvent.MOUSE_OUT:
					if(this.mcContent)
					{
						this.mcContent.filters = null;
					}
					break;
				case MouseEvent.MOUSE_UP:
					switch(e.currentTarget)
					{
						case this.mc:
						case this.btnShow:
							show();
					}
					break;
			}
			
		}
		
		private function show():void
		{
			if(UIBattleList.I)
			{
				UIBattleList.I.destroy();
			}
			trace("开始播放战役");
			
			if(data)
			{
				var view :UIBattleView = new UIBattleView(data);
				LayerUtil.I.layerDict[UIBattleView.NAME] = view;
				GameConst.main.setStage(view);
			}
			
			if(GameConst.main)
			{
				GameConst.main.hide();
			}
		}

		public function get data():BattleVO
		{
			return _data;
		}

		public function set data(vo:BattleVO):void
		{
			_data = vo;
			
			if(vo == null)
			{
				this.mc.visible = false;
				return;
			}
			
			this.txtBattleName.text = vo.battleInfoVO.name;
			this.txtBattleContent.htmlText = "经验： " + "<font color='#fff000'>" + vo.battleInfoVO.exp + "</font>" + "     " +
											"金币： " + "<font color='#fff000'>" + vo.battleInfoVO.gold + "</font>" + "     " +
											"物品： " + "<font color='#fff000'>" + vo.battleInfoVO.itemID + "</font>";
		}
		
		public function destroy():void
		{
			mc.addEventListener(MouseEvent.MOUSE_OVER,mouseHandler);
			mc.addEventListener(MouseEvent.MOUSE_OUT,mouseHandler);
			mc.addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			mc = null;
			txtBattleName = null;
			txtBattleContent = null;
			txtBattleAward = null;
			mcContent = null;
			btnShow = null;
		}
		

	}
}