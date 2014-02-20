package fanshymy.view.ui
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import fanshymy.controller.util.RoleManage;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.battles.vo.BattleVO;
	import fanshymy.view.role.Hero;
	import fanshymy.view.role.MapObject;
	import fanshymy.view.role.Monster;

	/**
	 * 角色层 
	 * @author Leo
	 * 
	 */	
	public class UIBattleRoleLayer extends Sprite
	{
		private var battleVO :BattleVO;
		private var battlePlace :UIBattlePlace;
		public function UIBattleRoleLayer(battleVO :BattleVO,battlePlace :UIBattlePlace)
		{
			this.battleVO = battleVO;
			this.battlePlace = battlePlace;
			super();
			if(!this.battleVO)
			{
				return;
			}
			
			addRole();
		}
		
		private function addRole():void
		{
			var dict :Vector.<AddObjectVO> = this.battleVO.battleObjects;
			if(!dict)
			{
				return;
			}
			var p :Point;
			var roleList :Vector.<MapObject> = RoleManage.I.roleList;
			for each(var vo :AddObjectVO in dict)
			{
				if(vo.roleType == AddObjectVO.TYPE_HERO)
				{
					p = this.battlePlace.getPlacePosition(vo.place);
					var hero :Hero = new Hero(vo);
					hero.x = p.x;
					hero.y = p.y;
					this.addChild(hero);
					roleList.push(hero);
					
				}else if(vo.roleType == AddObjectVO.TYPE_MONSTER)
				{
					p = this.battlePlace.getPlacePosition(vo.place,false);
					var monster :Monster = new Monster(vo);
					monster.x = p.x;
					monster.y = p.y;
					this.addChild(monster);
					
					roleList.push(monster);
				}
			}
		}
		
		public function destroy():void
		{
			
		}
		
	}
}