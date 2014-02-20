package managers
{
	
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public interface IManager 
	{
		
		function get running():Boolean;
		function start():void;
		function stop():void;
		function notifyChange(args:Array):void;
	}
	
}