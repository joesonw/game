package fanshymy.view.role
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.transmission.RoleAssetsLoader;

	/**
	 * 显示对象基类 
	 * @author leo
	 * 
	 */	
	public class MapObject extends Sprite
	{
		/**
		 * 加载中显示的图片 
		 */		
		private var roleDummy :RoleDummy;
		/**
		 * 图片播放器 
		 */		
		public var animation :Animation;
		/**
		 * 地图上的对象VO 
		 */		
		public var addObjVO :AddObjectVO;
		/**
		 *  是否存活 
		 */		
		public var isAlive :Boolean = true;
		/**
		 * 角色血槽 
		 */		
		private var roleBloodSlot :RoleBloodSlot;
		/**
		 * 角色文本 
		 */		
		private var txtRoleName :TextField;
		
		private var curHP :int;
		public function MapObject(vo :AddObjectVO)
		{
			super();
			this.curHP = vo.hp;
			roleDummy = new RoleDummy();
			this.addChild(roleDummy);
			this.addObjVO = vo;
			//位图播放器
			this.animation = new Animation(this.addObjVO);
			//血槽位置
			roleBloodSlot = new RoleBloodSlot();
			//角色名字
			this.txtRoleName = new TextField();
			loadResource();

		}
		/**
		 * 更新 
		 * 
		 */		
		public function update():void
		{
			if(!isAlive)
			{
				destroy();
			}
			if(this.animation)
			{
				this.animation.update();
			}
		}
		
		public function subHP(damage :int):void
		{
			var tempValue :Number = this.roleBloodSlot.width / this.addObjVO.hp;
			var value :Number = damage * tempValue;
			this.roleBloodSlot.sp_mask.width = this.roleBloodSlot.sp_PB_Slider.width = 
				this.roleBloodSlot.sp_mask.width - value;
			this.curHP -= damage;
			if(this.curHP <= 0)
			{
				this.isAlive = false;
			}
			
		}
		/**
		 * 加载角色资源
		 */		
		private function loadResource():void
		{
			var list : Array = GameConst.ROLE_ACTION_ARY;
			if(!list || list.length  == 0)
			{
				return;
			}
			
			new RoleAssetsLoader(this.addObjVO,list,loadComplete,loadError);
		}
		/**
		 * 加载完成 
		 * 
		 */		
		private function loadComplete():void
		{
			if(this.contains(roleDummy))
			{
				this.removeChild(roleDummy);
				this.roleDummy = null;
			}

			this.addChild(this.animation);
			this.animation.playAction();
			//"fighting_idle",2
			
			

			this.addChild(roleBloodSlot);
			var p :Point = this.animation.getBMDWH();
			if(p)
			{
				roleBloodSlot.x = -this.roleBloodSlot.width/2;
				roleBloodSlot.y = -p.y;
			}
			

			this.txtRoleName.width = this.roleBloodSlot.width;
			var format :TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.color = "0xff0000";
			format.size = 16;
			this.txtRoleName.defaultTextFormat = format;
			this.txtRoleName.selectable = false;
			this.addChild(this.txtRoleName);
			this.txtRoleName.x = roleBloodSlot.x;
			this.txtRoleName.y = roleBloodSlot.y - 30;
			this.txtRoleName.text = this.addObjVO.name;
		}
		
		private function loadError():void
		{
			
		}
		
		public function destroy():void
		{
			if(this.parent)
			{
				this.animation.curBitmapList = null;
				this.parent.removeChild(this);
			}
		}
	}
}