package fanshymy.controller.util
{
	public class TimerUtil
	{
		private static var _I :TimerUtil = null;
		public function TimerUtil(prv :PrivateClass)
		{
		}
		

		public static function get I():TimerUtil
		{
			if(_I == null)
			{
				_I = new TimerUtil(new PrivateClass());
			}
			return _I;
		}

	}
}

class PrivateClass{}