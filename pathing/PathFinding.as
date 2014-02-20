package  pathing
{
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	import as3isolib.core.IIsoDisplayObject;
	public class PathFinding 
	{
		private var _grid:Grid
		private var _width:uint;
		private var _length:uint;
		private var _gridsize:uint;
		/**
		 * Constructor of path finding engine
		 * @param	_width	width of the map
		 * @param	_length	length of the map
		 * @param	gridsize grid size used by IsoGrid
		 */
		public function PathFinding(_width:uint,_length:uint,gridsize:uint):void 
		{
			_grid = new Grid(_width, _length);
			this._gridsize = gridsize;
			this._width = _width;
			this._length = _length;
		}
		/**
		 * Add obstacle to the path map
		 * @param	item The IIsoDisplayObject that will be blocking the path
		 */
		public function addtObstacle(item:IIsoDisplayObject):void {
			var _x = item.x / _gridsize;
			var _y = item.y / _gridsize;
			var _x_margin = item.width / _gridsize;
			var _y_margin = item.length / _gridsize;
			for (var i:uint = 0; i < _x_margin; ++i) {
				for (var j:uint = 0; j < _y_margin;++j) {
					_grid.setWalkable(_x + i, _y + j, false);
				}
			}
		}
		/**
		 * find the path between two points;
		 * @param	x_start
		 * @param	y_start
		 * @param	x_end
		 * @param	y_end
		 * @return 	the vector or passing nodes in order.
		 */
		public function pathTo(x_start:int,y_start:int,x_end:int,y_end:int):Vector.<Node> {
			var result:Vector.<Node> = new Vector.<Node>();
			_grid.setStartNode(Math.floor(x_start / 10), Math.floor(y_start / 10));
			_grid.setEndNode(Math.floor(x_end / 10), Math.floor(y_end / 10));
			var astar:AStar = new AStar();
			if (astar.findPath(_grid)) {
				return astar.path;
			}
			return result;
		}
	}

}