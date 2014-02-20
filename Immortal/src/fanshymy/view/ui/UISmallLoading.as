package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.proxy.GameConst;
	/**
	 * 小loading界面 
	 * @author Leo
	 * 
	 */	
	public class UISmallLoading extends Sprite
	{
		public  var mc :MovieClip;
		public function UISmallLoading()
		{
			super();
			this.mc = BitmapUtil.I.getMCByName(GameConst.smallLoading);
			if(this.mc)
			{
				this.addChild(this.mc);
			}
		}
		
		public function destroy():void
		{
			if(this.mc)
			{
				this.mc.stop();
				this.removeChild(this.mc);
			}
			
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
		
		public function setPosition():void
		{
			if(stage)
			{
				this.x = stage.stageWidth/2;
				this.y = stage.stageHeight/2;
			}
		}
	}
}