package 
{
	import as3isolib.display.IsoGroup;
	import as3isolib.display.IsoSprite;
	import as3isolib.display.primitive.IsoBox;
	import as3isolib.display.primitive.IsoPolygon;
	import as3isolib.display.primitive.IsoRectangle;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.display.IsoView
	import as3isolib.display.scene.IsoGrid
	import as3isolib.geom.Pt;
	import com.smartfoxserver.v2.entities.data.ISFSArray;
	import com.smartfoxserver.v2.entities.data.ISFSObject;
	import com.smartfoxserver.v2.entities.data.SFSObject;
	import com.smartfoxserver.v2.entities.Room;
	import com.smartfoxserver.v2.entities.SFSRoom;
	import com.smartfoxserver.v2.entities.User;
	import com.smartfoxserver.v2.requests.ExtensionRequest;
	import com.smartfoxserver.v2.requests.JoinRoomRequest;
	import com.smartfoxserver.v2.requests.LoginRequest;
	import com.smartfoxserver.v2.requests.PublicMessageRequest;
	import efnx.time.FPSBox;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.net.URLLoaderDataFormat
	import flash.utils.Timer;
	import map.MapEngine;
	import pathing.Node;
	import pathing.PathFinding;
	import managers.MouseManager;
	import flash.display.Sprite;
	import com.smartfoxserver.v2.SmartFox
	import com.smartfoxserver.v2.core.SFSEvent
	import starling.core.Starling;
	import starling.events.Event
	import flash.external.ExternalInterface;
	public class Main extends Sprite
	{	
		private var p:PathFinding;
		private var sfs:SmartFox 
		
		
		private var room:Room;
		private var o:Array 
		
		private var v:IsoView 
		private var s:IsoScene
		public function Main()
		{	
			/***trace("start");
			sfs= new SmartFox();
			sfs.debug = true;
			sfs.addEventListener(SFSEvent.CONNECTION, onConnection)
			sfs.addEventListener(SFSEvent.CONNECTION_LOST, onConnectionLost)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_SUCCESS, onConfigLoadSuccess)
			sfs.addEventListener(SFSEvent.CONFIG_LOAD_FAILURE, onConfigLoadFailure)
			sfs.addEventListener(SFSEvent.EXTENSION_RESPONSE, msg);
			sfs.addEventListener(SFSEvent.LOGIN, logined);
			sfs.addEventListener(SFSEvent.ROOM_JOIN, joined);
			sfs.loadConfig();**/

			s = new IsoScene();
			v = new IsoView();
			o = new Array();
			var g:IsoGrid = new IsoGrid();
			g.setGridSize(100, 100, 0);
			g.cellSize = 10;
			v.setSize(1000, 800);
			for (var i:uint = 0; i < 20; i++) {
				o.push(new Array());
				for (var j:uint = 0; j < 20; j++) {
					var t:IsoBox =  new IsoBox();
					o[i].push(t);
					o[i][j].setSize(5, 5, 20);
					o[i][j].moveTo(i * 20, j * 20, 0);
					s.addChild(o[i][j]);
				}
			}
			
			
			s.addChild(g);
			v.addScene(s)
			var r:Timer = new Timer(1000.0/15);
			var st:Starling = new Starling(Game, stage);
			Starling.current.nativeStage.frameRate = 60;
			
			st.addEventListener(starling.events.Event.ROOT_CREATED, function (e:starling.events.Event) {
				(Starling.current.root as Game).init(v);
				(Starling.current.root as Game).renderView();
				
				r.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) {
					(Starling.current.root as Game).renderView();
				})
				r.start();
			})
			st.start();
			
			var timer:Timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, function(e:TimerEvent) {
				for (var i:uint = 0; i < 20; i++) {
					for (var j:uint = 0; j < 20; j++) {
						o[i][j].moveTo(i * 20 + Math.floor(Math.random() * 6), j * 20 + Math.floor(Math.random() * 6), 0);
					}
				}
				
				(Starling.current.root as Game).renderView();
			})
			timer.start();
			var fps:FPSBox = new FPSBox();
			addChild(fps);
			
			/*var m:Sprite = new Sprite();
			var bd:BitmapData = new BitmapData(550, 400, true, 0);
			bd.draw(v);
			var img:Bitmap = new Bitmap(bd);
			addChild(img);*/
			
			  /** var grid:IsoGrid = new IsoGrid();
				
				grid.showOrigin = false;
				var scene:IsoScene = new IsoScene();
				var r:IsoRectangle = new IsoRectangle();
				r.moveTo(10, 10, 0);
				r.setSize(20, 20, 0);
				
				scene.addChild(r);
				grid.cellSize = 10;
				grid.setGridSize(50, 50, 0);
				scene.addChild(grid);
				var view:IsoView = new IsoView();
				view.setSize(550, 400);
				view.addScene(scene);
				view.clipContent = true;
				view.showBorder = false;
				var s:IsoSprite = new IsoSprite();
				s.setSize(10, 10, 0);
				
				scene.addChild(s);
				
				
				view.render();
				addChild(view);
				var m:EngineManager = new EngineManager(stage);
				var mm:MouseManager = new MouseManager(view);
				m.addManager(mm);
				m.startAll();
				
				
				var b1:IsoBox = new IsoBox();
				b1.setSize(20, 20, 40);
				b1.moveTo(10, 20, 0);
				var b2:IsoBox = new IsoBox();
				b2.setSize(40, 50, 10);
				b2.moveTo(50, 80, 0);
				scene.addChild(b1);
				scene.addChild(b2);
				scene.render();**/
		}
		private function joined(e:SFSEvent):void {
			var data:SFSObject = new SFSObject();
			data.putUtfString("room", sfs.roomList[0].name);
			data.putUtfString("message", "hello world");
			sfs.send(new ExtensionRequest("msg", data, room));
		}
		private function logined(e:SFSEvent):void {
			trace("loged in");
			room = sfs.getRoomByName("CityLobby");
			sfs.send(new JoinRoomRequest("CityLobby"));
		}
		private function msg(e:SFSEvent):void {
			if (e.params.cmd == "msg") {
				trace (e.params.params.getUtfString("message"));
				//var d:ISFSArray = e.params.param.getSFSArray("data");
			}
		}
		private function onConnection(evt:SFSEvent):void {
			if (evt.params.success) {
				trace("Connection Success!")
				sfs.send(new LoginRequest("joesonw@gmail.com", "test", "FarmSoc"));
			}  else {
				trace("Connection Failure: " + evt.params.errorMessage)
			}
		}

		private function onConnectionLost(evt:SFSEvent):void {
			trace("Connection was lost. Reason: " + evt.params.reason)
		}

		private function onConfigLoadSuccess(evt:SFSEvent):void {
			trace("Config load success!")
			trace("Server settings: " + sfs.config.host + ":" + sfs.config.port)
		}

		private function onConfigLoadFailure(evt:SFSEvent):void {
			trace("Config load failure!!!")
		}
	}	
}