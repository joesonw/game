package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	
	public class UILoading extends Sprite
	{
		private var content :MovieClip;
		public function UILoading()
		{
			super();
			
			this.content = BitmapUtil.I.getMCByName("loading");
			if(this.content)
			{
				this.addChild(content);
			}
		}
		
		public function show(list :Array):void
		{
			
		}
		
		public function hide():void
		{
			
		}
		
		
		public function destroy():void
		{
			
		}
	}
}