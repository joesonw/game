package fanshymy.proxy.battles.item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import ghostcat.display.movieclip.GMovieClip;
	import ghostcat.operation.MovieOper;
	import ghostcat.operation.Oper;
	
	import fanshymy.controller.util.BitmapUtil;

	/**
	 * 技能释放效果 
	 * @author Leo
	 * 
	 */	
	public class SkillEffect extends Oper
	{
		public var target :DisplayObjectContainer;
		public var position :Point;
		private var skillMC :MovieClip;
		public function SkillEffect(target :DisplayObjectContainer,position :Point = null)
		{
			this.target = target;
			this.position = position;
			skillMC = BitmapUtil.I.getMCByName("perSkill_1");
			if(skillMC)
			{
			}
			super();
		}
		
		override public function execute():void
		{
			if(this.skillMC && this.target && this.target.parent)
			{
				this.skillMC.addFrameScript(this.skillMC.totalFrames - 1, result);
				if(this.position)
				{
					this.skillMC.x = this.position.x;
					this.skillMC.y = this.position.y;
				}else
				{
					this.skillMC.x = this.target.x;
					this.skillMC.y =this.target.y;
				}
				this.target.parent.addChild(this.skillMC);
			}
			super.execute();
		}
		
		override protected function end(event:*=null):void
		{
			super.end(event);
			if(this.skillMC && this.skillMC.parent)
			{
				this.skillMC.parent.removeChild(this.skillMC);
				this.skillMC = null;
			}
		}
	}
}