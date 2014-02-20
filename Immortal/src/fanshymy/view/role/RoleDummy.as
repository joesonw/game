package fanshymy.view.role
{
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	
	public class RoleDummy extends Sprite
	{
		private var content :Sprite;
		public function RoleDummy()
		{
			super();
			
			this.content = BitmapUtil.I.getMCByName("RoleDummy") as Sprite;
			if(this.content)
			{
				this.addChild(this.content);
			}
		}
		
		public function destroy():void
		{
			if(this.content)
			{
				this.removeChild(content);
			}
			
		}
	}
}