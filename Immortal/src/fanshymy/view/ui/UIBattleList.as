package fanshymy.view.ui
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import fanshymy.controller.util.UIUtil;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.proxy.transmission.LoaderUtil;
	import fanshymy.proxy.vo.BaseUI;

	/**
	 * 战斗列表UI 
	 * @author Leo
	 * 
	 */	
	public class UIBattleList extends UILoadingBase
	{
		public static var I :UIBattleList;
		public var btnClose :SimpleButton;
		public var itemList :Vector.<UIBattleListItem>;
		public var btnLeft :SimpleButton;
		public var btnRight :SimpleButton;
		public var txtPage :TextField;
		public function UIBattleList(baseUI:BaseUI)
		{
			if(!baseUI)
			{
				baseUI = new BaseUI("BattleList","BattleList");
			}
			super(baseUI);
		}
		
		override protected function swfLoadComplete():void
		{
			super.swfLoadComplete();
			
			if(!content)
			{
				return;
			}
			this.itemList = new Vector.<UIBattleListItem>();
			binding(content,itemList,UIBattleListItem);
			
			btnClose = content.btnClose;
			this.btnLeft = content.btnLeft;
			this.btnRight = content.btnRight;
			this.txtPage = content.txtPage;
			
			data = [];
			var list :Dictionary = LoaderUtil.I.battleVOList;
			for (var key :* in list)
			{
				var vo :BattleVO = list[key] as BattleVO;
				if(vo)
				{
					data.push(vo);
				}
			}
			
			var index :int = 0;
			for each(var item :UIBattleListItem in itemList)
			{
				if(data[index])
				{
					item.data = data[index];
				}else
				{
					item.data = null;
				}
				index++;
			}
			
			addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			
			I = this;
		}
		
		private function mouseHandler(e :MouseEvent):void
		{
			switch(e.target)
			{
				case this.btnClose:
					destroy();
					break;
				case this.btnLeft:
					trace("left");
					break;
				case this.btnRight:
					trace("right");
					break;
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
			
			removeEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			unBinding(itemList);
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			I = null;
			
			if(GameConst.main)
			{
				GameConst.main.show();
			}
		}
	}
}