package fanshymy.view.ui
{
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import fanshymy.controller.util.BitmapUtil;
	import fanshymy.controller.util.UIUtil;
	import fanshymy.proxy.GameConst;
	import fanshymy.proxy.transmission.LoaderUtil;
	import fanshymy.proxy.vo.BaseUI;

	/**
	 * 自动加载UI基类 
	 * @author leo
	 * 
	 */	
	public class UILoadingBase extends Sprite
	{
		public var content :MovieClip;
		public var data :Object;
		private var loadingMC :MovieClip;
		private var baseUI :BaseUI;
		public function UILoadingBase(baseUI :BaseUI)
		{
			super();
			this.baseUI = baseUI;
			addEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		public function binding(source:DisplayObjectContainer,itemList:Vector.<UIBattleListItem>,itemClass :Class):void
		{
			UIUtil.I.binding(source,itemList,itemClass);
		}
		
		public function unBinding(itemList :Vector.<UIBattleListItem>):void
		{
			var i :int = 0;
			if(itemList && itemList.length > 0)
			{
				for each(var item :UIBattleListItem in itemList)
				{
					item.destroy();
					itemList.splice(i,1);
					i++;
				}
			}
		}
		
		private function addToStageHandler(event :Event):void
		{
			init();
			removeEventListener(Event.ADDED_TO_STAGE,addToStageHandler);
		}
		
		protected function init():void
		{
			if(!this.baseUI)
			{
				return;
			}
			var fileList :Dictionary = LoaderUtil.I.fileList;
			var vo :BaseUI = fileList[this.baseUI.swfPath];
			if(vo && vo.isComplete)
			{
				swfLoadComplete();
			}else
			{
				LoaderUtil.I.loadUI(baseUI,swfLoadComplete,swfLoadError);
				removeLoading();
				var name :String = GameConst.smallLoading;
				this.loadingMC = BitmapUtil.I.getMCByName(name);
				if(this.loadingMC)
				{
					this.addChild(this.loadingMC);
					if(stage)
					{
						this.loadingMC.x = stage.stageWidth/2;
						this.loadingMC.y = stage.stageHeight/2;
					}
				}
			}
		}
		
		protected function swfLoadComplete():void
		{
			removeLoading();
			content = BitmapUtil.I.getMCByName(baseUI.linkName);
			if(content)
			{
				this.addChild(content);
				
				if(stage)
				{
					this.x = (stage.stageWidth - content.width)/2;
					this.y = (stage.stageHeight - content.height)/2;
				}
			}
		}
		
		protected function swfLoadError():void
		{
			trace("UI 加载出错" + baseUI.swfPath);
		}

		
		private function removeLoading():void
		{
			if(this.loadingMC)
			{
				if(this.loadingMC.parent)
				{
					this.loadingMC.parent.removeChild(this.loadingMC);
				}
			}
		}
		
		public function destroy():void
		{
			
		}

		
	}
}