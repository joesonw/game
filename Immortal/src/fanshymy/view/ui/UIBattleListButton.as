package fanshymy.view.ui
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	
	public class UIBattleListButton extends SimpleButton
	{
		public function UIBattleListButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
		}
	}
}