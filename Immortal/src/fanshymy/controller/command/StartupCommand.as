package fanshymy.controller.command
{
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	/**
	 * 启动PureMVC命令 
	 * @author leo
	 * 
	 */	
	public class StartupCommand extends SimpleCommand implements ICommand
	{
		public static var NAME :String = "StartupCommand";
		public function StartupCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var str :String = notification.getBody() as String;
			trace(str);
			
			facade.removeCommand(NAME);
		}
	}
}