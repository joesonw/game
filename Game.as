package {
	import as3isolib.display.IsoView;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;
	import starling.display.Sprite
	import flash.display.Sprite
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.events.EnterFrameEvent
	public class Game extends starling.display.Sprite{
		private var view:IsoView;
		private var bd:BitmapData;
		private var t:Texture;
		private var i:Image;
		public function Game () {
			
		}
		public function init(view:IsoView) {
			this.view = view;
			bd = new BitmapData(1000,800);
			t = Texture.fromBitmapData(bd);
			i = new Image(t);
		}
		public function renderView() {
			view.render(true);
			bd.dispose()
			bd = new BitmapData(1000, 800);
			bd.draw(view);
			t.dispose();
			t = Texture.fromBitmapData(bd);
			i.texture.dispose();
			i.texture = t;
			addChild(i);
		}
	}
}