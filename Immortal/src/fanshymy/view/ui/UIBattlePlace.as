package fanshymy.view.ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.proxy.vo.BaseUI;

	/**
	 * 角色位置层 
	 * @author Leo
	 * 
	 */	
	public class UIBattlePlace extends Sprite
	{
		public static const NAME :String = "UIBattlePlace";
		public var formationHome :MovieClip;
		public var formationVisitor :MovieClip;
		private var content :MovieClip;
		public function UIBattlePlace()
		{
			super();
			init();
			mouseChildren = mouseEnabled = false;
			this.visible = false;
		}
		
		
		private function init():void
		{
			this.content = BitmapUtil.I.getMCByName("BattlePlace");
			if(!this.content)
			{
				return;
			}
			this.addChild(content);
			content.x = 0;
			content.y = 0;
			
			this.formationHome = this.content.BattleFormation.Formation_Home;
			this.formationVisitor = this.content.BattleFormation.Formation_Visitor;
			
		}
		
		public function getPlacePosition(place :String,home :Boolean = true):Point
		{
			var name :String;
			var placeItem :MovieClip;
			var p :Point;
			if(home)   //自家
			{
				name = "Place_" + place;
				if(this.formationHome[name])
				{
					placeItem = this.formationHome[name] as MovieClip;
					p = new Point(placeItem.x,placeItem.y + placeItem.height/4);
					return p;
				}
			}else   //敌人
			{
				name = "Place_" + place;
				if(this.formationVisitor[name])
				{
					placeItem = this.formationVisitor[name] as MovieClip;
					p = new Point(placeItem.x,placeItem.y +placeItem.height/4);
					return p;
				}
			}
			return null;
		}
		
		public function destroy():void
		{
			
		}
		
	}
}