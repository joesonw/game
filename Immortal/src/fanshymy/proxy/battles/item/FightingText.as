package fanshymy.proxy.battles.item
{
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import ghostcat.operation.Oper;
	
	import fanshymy.controller.util.BitmapUtil;
	/**
	 * 战斗中反击/抵挡/暴击/闪避 
	 * @author Leo
	 * 
	 */	
	public class FightingText extends Oper
	{
		/**
		 * 反击 
		 */		
		public static const BACK_ATTACK :int = 1;
		/**
		 *  抵挡
		 */		
		public static const RESIS :int = 2;
		/**
		 * 暴击 
		 */		
		public static const CRUCIAL :int = 3;
		/**
		 * 闪避 
		 */		
		public static const JINK :int = 4;
		private var target :DisplayObjectContainer;
		private var position :Point;
		private var figtingTextMC :MovieClip;
		public function FightingText(target :DisplayObjectContainer,type :int,position :Point = null)
		{
			super();
			this.target = target;
			this.position = position;
			var name :String;
			switch(type)
			{
				case BACK_ATTACK:
					name = "BackAttack";
					break;
				case RESIS:
					name = "Resis";
					break;
				case CRUCIAL:
					name = "Crucial";
					break;
				case JINK:
					name = "Jink";
					break;
			}
			
			this.figtingTextMC = BitmapUtil.I.getMCByName(name);
			if(this.figtingTextMC)
			{
				this.figtingTextMC.stop();
			}
		}
		
		override public function execute():void
		{
			if(this.figtingTextMC && this.target)
			{
				this.figtingTextMC.play();
				this.figtingTextMC.addFrameScript(this.figtingTextMC.totalFrames - 1,result);
				if(this.position)
				{
					this.figtingTextMC.x = this.position.x;
					this.figtingTextMC.y = this.position.y;
				}else
				{
					this.figtingTextMC.x = this.target.x;
					this.figtingTextMC.y = this.target.y - this.target.height;
				}
				this.target.parent.addChild(this.figtingTextMC);
			}
			super.execute();
		}
		
		override protected function end(event:*=null):void
		{
			super.end(event);
			if(this.figtingTextMC && this.figtingTextMC.parent)
			{
				this.figtingTextMC.parent.removeChild(this.figtingTextMC);
				this.figtingTextMC = null;
			}
		}
	}
}