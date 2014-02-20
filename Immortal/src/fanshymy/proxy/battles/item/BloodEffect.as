package fanshymy.proxy.battles.item
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import ghostcat.display.movieclip.GMovieClip;
	import ghostcat.operation.MovieOper;
	import ghostcat.operation.Oper;
	import ghostcat.ui.layout.AbsoluteLayout;
	
	import fanshymy.controller.util.BitmapUtil;
	/**
	 * 扣血显示 
	 * @author Leo
	 * 
	 */	
	public class BloodEffect extends Oper
	{
		private const NAME :String = "BlloodSub";
		private const EFFECT :String = "BloodEffect";
		private var target :DisplayObjectContainer;
		private var position :Point;
		private var effectMC :MovieClip;
		public function BloodEffect(target :DisplayObjectContainer, damage :int, position :Point = null)
		{
			this.target = target;
			this.position = position;
			if(damage > 0)
			{
				var damageStr :String = damage.toString();
				effectMC = BitmapUtil.I.getMCByName(EFFECT);
				effectMC.stop();
//				var gmc :GMovieClip = new GMovieClip(effectMC);
				var name :String;
				var bmd :BitmapData;
				var bitmap :Bitmap;
				
				name = NAME + "Sub";
				bmd = BitmapUtil.I.getBMDByName(name);
				bitmap = new Bitmap(bmd);
				effectMC.BloodNums.addChild(bitmap);
				
				var i :int = 0;
				while(i < damageStr.length)
				{
					name = NAME + damageStr.charAt(i);
					bmd = BitmapUtil.I.getBMDByName(name);
					bitmap = new Bitmap(bmd);
					effectMC.BloodNums.addChild(bitmap);
					bitmap.x = i * 20 + 30;
					i++;
				}
				
			}
			effectMC.addFrameScript(effectMC.totalFrames - 20,result);
			super();
		}
		
		override public function execute():void
		{
			effectMC.play();
			if(this.effectMC && this.target)
			{
				if(this.position)
				{
					this.effectMC.x = this.position.x;
					this.effectMC.y = this.position.y;
				}else
				{
					this.effectMC.x = this.target.x;
					this.effectMC.y =this.target.y - this.target.height;
				}
				this.target.parent.addChild(this.effectMC);
			}
			super.execute();
		}
		
		override protected function end(event:*=null):void
		{
			super.end(event);
			if(this.effectMC && this.effectMC.parent)
			{
				this.effectMC.parent.removeChild(this.effectMC);
			}
		}
	}
}