package fanshymy.view.role
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import fanshymy.controller.util.RoleManage;
	import fanshymy.proxy.battles.vo.AddObjectVO;
	import fanshymy.proxy.transmission.LoaderUtil;

	/**
	 * 角色位图播放器 
	 * @author Leo
	 * 
	 */	
	public class Animation extends Sprite
	{
		public var roleBitmap :Bitmap;
		public var curBitmapList :Vector.<BitmapData>;
		public var isPlayEnd :Boolean = false;
		private var curIndex :int;
		private var curPlayTime :int;
		private var loop :int;
		private var addObjVO :AddObjectVO;
		public function Animation(vo :AddObjectVO)
		{
			super();
			roleBitmap = new Bitmap();
			this.addChild(roleBitmap);
			this.addObjVO = vo;
		}
		/**
		 * 随便获取一张位图的宽高，用来确定血条的位置 
		 * @return 
		 * 
		 */		
		public function getBMDWH():Point
		{
			if(this.curBitmapList && this.curBitmapList.length > 0)
			{
				var bmd :BitmapData = this.curBitmapList[0] as BitmapData;
				var p :Point = new Point(bmd.width,bmd.height);
				
				return p;
			}
			
			return null;
		}
		/**
		 * 播放某一动作 
		 * @param action
		 * @param loop
		 * 
		 */		
		public function playAction(action :String = "fighting_idle",loop :int = -1):void
		{
			var list :Vector.<BitmapData> = RoleManage.I.getRoleBMDList(addObjVO.roleID,action);
			curBitmapList = list;
			this.loop = loop;
			if(this.curBitmapList && this.curBitmapList.length > 0)
			{
				
			}else
			{
				this.isPlayEnd = true;
				return;
			}
			
			this.curIndex = 0;
			this.curPlayTime = 0;
		}
		
		public function playAttack():void
		{
			isPlayEnd = false;
			playAction("attack",1);
		}
		
		public  function playHurt():void
		{
			isPlayEnd = false;
			playAction("be_hit",1);
		}
		
		public function checkIsPlayEnd():Boolean
		{
			 if(this.isPlayEnd)
			 {
				 return true;
			 }
			 
			 return false;
		}
		/**
		 * 更新函数 
		 * 
		 */		
		public function update():void
		{
			if(!this.curBitmapList || this.curBitmapList.length ==  0)
			{
				//应付还没加载完的情况。。会一直取图片，直到加载完成
//				playAction();
				return;
			}
			
			play();
		}
		/**
		 * 动画播放 
		 * 
		 */		
		private function play():void
		{
			if(this.curIndex > this.curBitmapList.length - 1)  
			{
				if(loop != -1)
				{
					this.curPlayTime++;
					if(this.curPlayTime >= loop)
					{
						playAction();
						isPlayEnd = true;
						return;
					}
				}
				this.curIndex = 0;
			}
			var bmd :BitmapData = this.curBitmapList[this.curIndex];
			this.roleBitmap.bitmapData = bmd;
			this.roleBitmap.x = -bmd.width/2;
			this.roleBitmap.y = -bmd.height;
			this.curIndex++;
		}
	}
}