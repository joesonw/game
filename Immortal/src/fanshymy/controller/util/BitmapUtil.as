package fanshymy.controller.util
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getTimer;
	
	/**
	 * 位图管理类 
	 * @author leo
	 * 
	 */	
	public class BitmapUtil
	{
		private static var _I :BitmapUtil = null;
		
		public function BitmapUtil(prvClass :PrivateClass)
		{
		}
		/**
		 * 根据名字获取MC 
		 * @param name
		 * @return 
		 * 
		 */
		public function getMCByName(name :String):MovieClip
		{
			if(ApplicationDomain.currentDomain.hasDefinition(name))
			{
				var cls :Class = ApplicationDomain.currentDomain.getDefinition(name) as Class;
				var mc :MovieClip = new cls() as MovieClip;
				return mc;
			}
			return null;
		}
		
		public function getBMDByName(name :String):BitmapData
		{
			if(ApplicationDomain.currentDomain.hasDefinition(name))
			{
				var cls :Class = ApplicationDomain.currentDomain.getDefinition(name) as Class;
				var bmd :BitmapData = new cls() as BitmapData;
				return bmd;
			}
			return null;
		}
		/**
		 * 根据名字获取BTN 
		 * @param name
		 * @return 
		 * 
		 */		
		public function getBtnByName(name :String):SimpleButton
		{
			trace(ApplicationDomain.currentDomain.hasDefinition(name));
			if(ApplicationDomain.currentDomain.hasDefinition(name))
			{
				var cls :Class = ApplicationDomain.currentDomain.getDefinition(name) as Class;
				var btn :SimpleButton = new cls() as SimpleButton;
				return btn;
			}
			return null;
		}

//		/**
//		 * 位图切割成小位图数组
//		 * @param source bmd源
//		 * @param tileW 切块宽
//		 * @param tileH 切块高
//		 * @param row 第几行
//		 * @return 
//		 * 
//		 */
//		public function cutBitmapData(source :BitmapData,tileW :int,tileH :int,row :int):Vector.<BitmapData>
//		{
//			var result :Vector.<BitmapData> = new Vector.<BitmapData>();
//			
//			for(var i :int = 0; i < ROLETILECOLS; i++)
//			{
//				var bitmapData :BitmapData = new BitmapData(tileW,tileH,true,0);
//				bitmapData.lock();
//				bitmapData.copyPixels(source,new Rectangle(i * tileW, row * tileH,tileW,tileH),new Point());
//				bitmapData.unlock();
//				result.push(bitmapData);
//			}
//			
//			return result;
//		}
//		
//		
		/**
		 * 左右旋转bitmapData 
		 * @param sourceList
		 * @return 
		 * 
		 */		
		public function rotationBitmapData(sourceList :Vector.<BitmapData>):Vector.<BitmapData>
		{
			if(!sourceList || sourceList.length == 0)
			{
				trace("sourceList null");
				return null;
			}
			
//			var s :int = getTimer();
			var result :Vector.<BitmapData> = new Vector.<BitmapData>();
			for each(var elem :BitmapData in sourceList)
			{
//				var newBMD :BitmapData = new BitmapData(elem.width,elem.height,true,0);
//				for(var row :int = 0; row < elem.width; row++)
//				{
//					for(var col :int = 0; col < elem.height; col++)
//					{
//						newBMD.lock();
//						newBMD.setPixel32(elem.width - row,col,elem.getPixel32(row,col));
//						newBMD.unlock();
//					}
//				}
				var matrix:Matrix = new Matrix();
				matrix.a = -1;
				matrix.tx = elem.width;
				var newBMD :BitmapData = new BitmapData(elem.width,elem.height,true,0);
				newBMD.draw(elem,matrix);
				result.push(newBMD);
			}
//			var e :int = getTimer() - s;
//			trace("耗时 "+ e/1000);
			return result;
		}
		
		public function drawBMP():BitmapData
		{
			return null;
		}
		

		public static function get I():BitmapUtil
		{
			if(_I == null)
			{
				_I = new BitmapUtil(new PrivateClass());
			}
			return _I;
		}
		


	}
}
class PrivateClass{}