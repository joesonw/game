package  
{
	import as3isolib.display.IsoSprite;
	import as3isolib.display.IsoView;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.enum.IsoOrientation;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.graphics.SolidColorFill;
	import fl.controls.List;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.NativeMenu;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoaderDataFormat
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import com.flassari.swfclassexplorer.SwfClassExplorer;
	import com.flassari.swfclassexplorer.data.Traits
	import flash.display.DisplayObject
	import flash.utils.Timer;
	import as3isolib.geom.IsoMath;
	
	/**
	 * ...
	 * @author Qiaosen Huang
	 */
	public class MapEditor extends MovieClip
	{
		/******Map properties*************/
		private var _gridSize:uint = 10;
		private var _gridWidth:uint = 100;
		private var _gridHeight:uint = 100;
		
		/*END***Map properties ***********/
		private var grid:IsoGrid;
		private var view:IsoView;
		private var scene:IsoScene;
		private var renderTimer:Timer;
		private var resourceList:Vector.<Object>;
		private var libraryList:Vector.<String>;
		private var currentCursor:Class;
		private var cursor:IsoRectangle
		private var currentCursorIndex:uint;
		private var objectList:Array;
		
		private var startDragX:int;
		private var startDragY:int;
		
		public function MapEditor() 
		{
			resourceList = new Vector.<Object>();
			libraryList = new Vector.<String>();
			cursor = new IsoRectangle();
			cursor.fills = [new SolidColorFill(0xff0000, 0.8)];
			objectList = new Array(100);
			for (var i:uint = 0; i < 100; i++) {
				objectList[i] = new Array(100);
				for (var j:int = 0; j < 100; j++) {
					objectList[i][j] = 0;	
				}
			}
			view= new IsoView();
			grid = new IsoGrid();
			scene = new IsoScene();
			grid.cellSize = 10;
			grid.setGridSize(100, 100, 0);
			//grid.showOrigin = false;
			scene.addChild(grid);
			view.addScene(scene);
			view.setSize(1620, 880);
			view.x = 300
			view.y = 200;
			addChild(view);
			
			renderTimer = new Timer(1000 / 30);
			renderTimer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) {
				scene.render();
			})
			renderTimer.start();
			view.addEventListener(MouseEvent.MOUSE_DOWN, screenDragStart); //map drag functiob
			addLibrary.addEventListener(MouseEvent.CLICK, openLibrary);
			view.addEventListener(MouseEvent.MOUSE_WHEEL, zoomMap); //zoom map area
			_resourcetList.addEventListener(Event.CHANGE, cursorSelection);
			saveMap.addEventListener(MouseEvent.CLICK, save_map);
			
		}
		private function showCursor(e:MouseEvent):void {
			view.addEventListener(MouseEvent.MOUSE_MOVE, moveCursor);
			scene.addChild(cursor);
			var isoPt:Pt = view.localToIso(new Pt(mouseX-300, mouseY-200));
			cursor.moveTo(Math.floor(isoPt.x/10)*10, Math.floor(isoPt.y/10)*10,0);
			cursor.setSize(10, 10, 0);
		}
		private function hideCursor(e:MouseEvent):void {
			view.removeEventListener(MouseEvent.MOUSE_OUT, hideCursor);
			scene.removeChild(cursor);
		}
		private function moveCursor(e:MouseEvent):void {
			var isoPt:Pt = view.localToIso(new Pt(mouseX-300, mouseY-200));
			cursor.moveTo(Math.floor(isoPt.x/10)*10, Math.floor(isoPt.y/10)*10,0);
		}
		private function cursorSelection(e:Event):void {
			currentCursor = resourceList[e.target.selectedItem.data].resource;
			currentCursorIndex = e.target.selectedItem.data;
			if (resourceView.image.numChildren > 0)
				resourceView.image.removeChildAt(0);
			resourceView.image.addChild(new currentCursor());
			view.addEventListener(MouseEvent.CLICK, addNewItem);
			view.addEventListener(MouseEvent.MOUSE_OVER, showCursor); // show cursor
		}
		private function addNewItem(e:MouseEvent):void {
			var isoPt:Pt = view.localToIso(new Pt(mouseX-300, mouseY-200));
			var ptX = Math.floor(isoPt.x / 10);
			var ptY = Math.floor(isoPt.y / 10);
			if (objectList[ptX][ptY] == 0) { //no IsoSprite occupied
				objectList[ptX][ptY] = new Object();
				objectList[ptX][ptY].img = new IsoSprite();
				objectList[ptX][ptY].walkale = walkable_check.selected
				objectList[ptX][ptY].index = currentCursorIndex;
			}
			objectList[ptX][ptY].img.setSize(itemWidth.text, itemLength.text, itemHeight.text);
			objectList[ptX][ptY].img.moveTo(ptX * 10, ptY * 10, 0);
			objectList[ptX][ptY].img.sprites = mergeArray(objectList[ptX][ptY].img.sprites,[currentCursor]);
			scene.addChild(objectList[ptX][ptY].img);
			addEventListener(KeyboardEvent.KEY_UP, endAddNewItem);
		}
		private function endAddNewItem(e:KeyboardEvent):void {
			if (e.keyCode == 27 && currentCursor!=null) { //ESC
				view.removeEventListener(MouseEvent.CLICK, addNewItem);
				removeEventListener(KeyboardEvent.KEY_UP, endAddNewItem);
				view.removeEventListener(MouseEvent.MOUSE_OVER, hideCursor); //hide cursor
				view.removeEventListener(MouseEvent.MOUSE_OVER, showCursor); // show cursor
				view.removeEventListener(MouseEvent.MOUSE_MOVE, moveCursor)
				currentCursor = null;
				if (resourceView.image.numChildren > 0)
					resourceView.image.removeChildAt(0);
			}
		}
		private function refreshResourceList():void {
			_resourcetList.removeAll();
			for (var index in resourceList) {
				_resourcetList.addItem({label:resourceList[index].name,data:index});
			}
		}
		private function zoomMap(e:MouseEvent) {
			if (e.delta > 0)
				view.currentZoom += 0.1
			if (e.delta < 0)
				view.currentZoom-=0.1
		}
		private function openLibrary(e:MouseEvent) {
			var file:File = new File();
			file.addEventListener(Event.SELECT,libraryOpened);
			file.browseForOpen("打开资源库文件", [new FileFilter("swf", "*.swf")]);
		}
		private function libraryOpened(e:Event) {
			var libraryName:String = (new File(e.target.nativePath)).name;
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY
			loader.addEventListener(Event.COMPLETE, function(evt:Event) {
				var bytes:ByteArray = ByteArray(URLLoader(evt.currentTarget).data)
				var list:Array = SwfClassExplorer.getClassNames(bytes);
				var loaderContext:LoaderContext = new LoaderContext();
				loaderContext.allowCodeImport = true;
				var resourceLoader:Loader = new Loader();
				libraryList.push(libraryName);
				resourceLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(evt:Event) { 
					for each (var itemName:String in list) {
						resourceList.push({"name":itemName, "library":libraryList.length - 1, "resource":resourceLoader.contentLoaderInfo.applicationDomain.getDefinition(itemName) as Class	} )
					}
					refreshResourceList();
				});
				resourceLoader.loadBytes(bytes,loaderContext);
			});
			loader.load(new URLRequest(e.target.nativePath))
		}
		private function screenDragStart(e:MouseEvent) {
			view.removeEventListener(MouseEvent.MOUSE_DOWN, screenDragStart);
			startDragX = mouseX;
			startDragY = mouseY;
			view.addEventListener(MouseEvent.MOUSE_UP, screenDragStop);
			view.addEventListener(MouseEvent.MOUSE_MOVE, screenPan);		
		}
		private function screenPan(e:MouseEvent) {
			view.panBy(startDragX - mouseX, startDragY - mouseY);
			startDragX = mouseX;
			startDragY = mouseY;
		}
		private function screenDragStop(e:MouseEvent) {
			view.addEventListener(MouseEvent.MOUSE_DOWN, screenDragStart);
			view.removeEventListener(MouseEvent.MOUSE_UP, screenDragStop);
			view.removeEventListener(MouseEvent.MOUSE_MOVE, screenPan);	
		}
		private function mergeArray(source1:Array, source2:Array):Array {
			var result:Array = new Array();
			for (var i = 0; i < source1.length; i++) {
				result.push(source1[i]);
			}
			for (var j= 0; j < source2.length; j++) {
				result.push(source2[j]);
			}
			return result;
		}
		private function save_map(e:MouseEvent):void {
			var file:File = new File();
			file.browseForSave("ssave map");
			file.addEventListener(Event.SELECT, save_map_file);
		}
		private function save_map_file(e:Event):void {
			e.target.removeEventListener(Event.SELECT, save_map_file);
			var file:File = e.target as File;
			var contents:XML = new XML("<xml></xml>");
			var header:XML = new XML("<head></head>");
			header.appendChild(new XML("<width>" + Number(gridWidth.text)*10 + "</width>"));
			header.appendChild(new XML("<height>" + Number(gridHeight.text) * 10 + "</height>"));
			var resources:XML = new XML("<resources></resources>");
			var counter:uint = 0;
			
			var item:XML
			for each (var i:Object in resourceList) {
				item = new XML("<resource>"+i.name+"</resource>");
				item.@id = counter;
				item.@libid = i.library;
				resources.appendChild(item);
				counter++;
			}
			counter = 0;
			var libraries:XML = new XML("<libraries></libraries>");
			for each (var j:String in libraryList) {
				item = new XML("<library>" + j + "</library>");
				item.@id = counter;
				libraries.appendChild(item);
				counter++;
			}
			var body:XML = new XML("<body></body>");
			for (var m:uint = 0; m < objectList.length;m++ ) {
				for (var n:int = 0; n < objectList[m].length;n++ ) {
					var cur = objectList[m][n];
					if (cur != 0) {
						item = new XML("<tile>" + cur.index + "</tile>");
						item.@x = m;
						item.@y = n;
						item.@width = cur.img.width;
						item.@length = cur.img.length;
						item.@height = cur.img.height;
						item.@walkable = cur.walkale;
						body.appendChild(item);
					}
				}
			}
			contents.appendChild(header);
			contents.appendChild(resources);
			contents.appendChild(body);
			contents.appendChild(libraries);
			if (!file.exists) {
				var s:FileStream = new FileStream();
				s.open(file, FileMode.WRITE);
				s.writeUTFBytes(contents.toString());
				s.close();
			}
		}
	}

}