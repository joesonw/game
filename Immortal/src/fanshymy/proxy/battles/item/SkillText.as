package fanshymy.proxy.battles.item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.text.TextField;
	
	import ghostcat.display.movieclip.GMovieClip;
	import ghostcat.operation.MovieOper;
	import ghostcat.operation.Oper;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.proxy.GameConst;

	/**
	 * 技能显示文本 
	 * @author Leo
	 * 
	 */	
	public class SkillText extends Oper
	{
		/**
		 * 技能名字文本 
		 */		
		public var txtSkillName :TextField;
		private var position :Point;
		private var target :DisplayObjectContainer;
		private var skillTextMC :MovieClip;
		public function SkillText(target :DisplayObjectContainer, skillID :int,position :Point = null)
		{
			this.target = target;
			this.position = position;
			skillTextMC = BitmapUtil.I.getMCByName("SkillText3");
			if(skillTextMC)
			{
				this.txtSkillName = skillTextMC.txtSkillName;
				txtSkillName.text = (getSkillName(skillID));
			}
			super();
		}
		
		override public function execute():void
		{
			this.skillTextMC.addFrameScript(this.skillTextMC.totalFrames - 1,result);
			if(this.skillTextMC && this.target)
			{
				if(this.position)
				{
					this.skillTextMC.x = this.position.x;
					this.skillTextMC.y = this.position.y;
				}else
				{
					this.skillTextMC.x = this.target.stage.stageWidth/2 - 100;
				}
				this.target.parent.addChild(this.skillTextMC);
			}
			super.execute();
		}
		
		override protected function end(event:*=null):void
		{
			super.end(event);
			if(this.skillTextMC && this.skillTextMC.parent)
			{
				this.skillTextMC.parent.removeChild(this.skillTextMC);
				this.skillTextMC = null;
			}
		}
		
		private function getSkillName(skillID :int):String
		{
			var name :String = "";
			var list :Array = GameConst.SKILL_NAME;
			var index :int = (list.length - 1) * Math.random();
			return list[index];
		}
	}
}