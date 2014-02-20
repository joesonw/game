package fanshymy.view.role
{
	import flash.display.Sprite;
	
	import fanshymy.controller.util.BitmapUtil;
	/**
	 * 角色血槽 
	 * @author Leo
	 * 
	 */	
	public class RoleBloodSlot extends Sprite
	{
		private var content :*;
		public var sp_mask :Sprite;
		public var sp_PB_Slider :Sprite;
		public function RoleBloodSlot()
		{
			super();
			
			this.content = BitmapUtil.I.getMCByName("blood");
			if(this.content)
			{
				this.addChild(this.content);
				this.sp_mask = this.content.Mask;
				this.sp_PB_Slider = this.content.PB_Slider;
			}
			
		}
		
		public function destroy():void
		{
			if(this.content)
			{
				this.removeChild(content);
			}
			
			if(this.parent)
			{
				this.parent.removeChild(this);
			}
		}
	}
}