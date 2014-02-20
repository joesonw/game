package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	/**
	 * 战役按钮提示 
	 * @author Leo
	 * 
	 */	
	public class BtnBattleTips extends Sprite
	{
		private var mc:MovieClip;
		public function BtnBattleTips()
		{
			super();
			
			mc = BitmapUtil.I.getMCByName("btnBattleTips");
			if(mc)
			{
				this.addChild(mc);
			}
		}
		
		public function stop():void
		{
			if(mc)
			{
				mc.stop();
			}
			this.visible = false;
		}
		
		public function play():void
		{
			if(mc)
			{
				mc.play();
			}
			this.visible = true;
		}
	}
}