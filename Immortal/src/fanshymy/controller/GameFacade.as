package fanshymy.controller
{
	import org.puremvc.as3.interfaces.IFacade;
	import org.puremvc.as3.patterns.facade.Facade;
	
	/**
	 * 游戏中注册命令专用 
	 * @author leo
	 * 
	 */	
	public class GameFacade extends Facade implements IFacade
	{
		private static var _I :GameFacade = null;
		
		public function GameFacade(prv :PrivateClass)
		{
			super();
		}
		
		public static function regCommand(notificationName :String,commandClass :Class):void
		{
			I.registerCommand(notificationName,commandClass);
		}
		
		public static function reg(commandClass :Class):void
		{
			regCommand(commandClass["NAME"],commandClass);
		}
		
		public static function send(notificationName :String ,body :Object = null,type :String = null):void
		{
			I.sendNotification(notificationName,body,type);
		}
		
		

		public static function get I():GameFacade
		{
			if(_I == null)
			{
				_I = new GameFacade(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}