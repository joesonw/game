package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	
	
	/**
	 * 战役按钮 
	 * @author Leo
	 * 
	 */	
	public class BtnBattle extends Sprite
	{
		private var content :SimpleButton;
		public function BtnBattle()
		{
			var mc :SimpleButton = BitmapUtil.I.getBtnByName("BtnStartBattle");
			if(mc)
			{
				this.addChild(mc);
			}
			super();
		}
	}
}