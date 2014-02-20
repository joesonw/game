package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.controller.util.LayerUtil;

	/**
	 * 战斗结果界面 
	 * @author Leo
	 * 
	 */	
	public class UIBattleResult extends Sprite
	{
		private var content :MovieClip;
		private var btnOK :SimpleButton;
		private var txtContent :TextField;
		private var txtOK :TextField;
		private var result :Boolean;
		public function UIBattleResult(result :Boolean)
		{
			super();
			this.result = result;
			addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e :*):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,init);
			content = BitmapUtil.I.getMCByName("SimpleMessageBox");
			if(content)
			{
				this.btnOK = content.btnOK;
				this.txtContent = content.txtContent;
				this.txtOK = content.txtOK;
				this.txtOK.mouseEnabled = false;
				
				if(result)
				{
					this.txtContent.text = "战斗胜利";
				}else
				{
					this.txtContent.text = "战斗失败";
				}
				
				this.btnOK.addEventListener(MouseEvent.MOUSE_UP,mouseHandler);
				this.addChild(content);
				
				this.x = (this.parent.stage.stageWidth - this.width)/2;
				this.y = (this.parent.stage.stageHeight - this.height)/2;
			}
		}
		
		private function mouseHandler(e :MouseEvent):void
		{
			this.btnOK.removeEventListener(MouseEvent.MOUSE_UP,mouseHandler);
			destroy();
		}
		
		
		public function destroy():void
		{
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
			
			var uiBattleView :UIBattleView = LayerUtil.I.getLayer(UIBattleView.NAME) as UIBattleView;
			if(uiBattleView)
			{
				uiBattleView.destroy();
			}
		}
	}
}