package;

import flixel.group.FlxTypedGroup;
import openfl.Assets;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

/**
 * A level in the game. Includes loading the level and displaying
 * @author Samuel Batista
 * @author Jakob
 */
class TiledLevel extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/levels/";
	
	public var foregroundStuff:FlxGroup;
	public var backgroundStuff:FlxGroup;
	public var coins:FlxGroup;
	public var startPoint:FlxObject;
	public var activatableObjects:FlxTypedGroup<GameObject> = new FlxTypedGroup<GameObject>();
	public var triggers:FlxTypedGroup<GameObject> = new FlxTypedGroup<GameObject>();
	public var levelName:String;
	public var exitPoints:Array<GameObject> = new Array<GameObject>();
	
	private var collidableTileLayers:Array<FlxTilemap>;
	private var bgImages = new FlxTypedGroup<FlxSprite>();
	public var collisionBoxes  = new FlxTypedGroup<GameObject>();
	
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		foregroundStuff = new FlxGroup();
		backgroundStuff = new FlxGroup();
		backgroundStuff.add(bgImages);
		
		
		// Load Tile Maps
		for (tileLayer in layers)
		{
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			if (tileSheetName == null)
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
				
			var tileSet:TiledTileSet = null;
			for (ts in tilesets)
			{
				if (ts.name == tileSheetName)
				{
					tileSet = ts;
					break;
				}
			}
			
			if (tileSet == null)
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tileset' property in " + tileLayer.name + "' layer?";
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= c_PATH_LEVEL_TILESHEETS + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width;
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);
			
			if (tileLayer.properties.contains("collide"))
			{
				if (collidableTileLayers == null)
					collidableTileLayers = new Array<FlxTilemap>();
				
				collidableTileLayers.push(tilemap);
			}
			
			if (tileLayer.properties.get("z") == "front")
			{
				foregroundStuff.add(tilemap);
			}
			else
			{
				backgroundStuff.add(tilemap);
			}
			
		}
	}
	
	public function loadLevel()
	{
		loadObjects();
		
		//foregroundStuff.add(collisionBoxes);
		//foregroundStuff.add(activatableObjects);
	}
	
	private function loadObjects()
	{
		for (group in objectGroups)
		{
			for (o in group.objects)
			{
				loadObject(o, group);
			}
		}
	}
	
	private function loadObject(o:TiledObject, g:TiledObjectGroup)
	{
		var x:Int = o.x;
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1)
			y -= g.map.getGidOwner(o.gid).tileHeight;
		
		switch (o.type.toLowerCase())
		{
			case "player_start":
				if (o.name.toLowerCase() == "start")
				{
					startPoint = new FlxObject(x, y);
				}
				else
				{
					var exitPoint = new GameObject(x, y);
					exitPoint.name = o.name;
					exitPoints.push(exitPoint);
				}
				
			case "warp":
				var warp = new Warp(x, y, o.width, o.height);
				warp.target = o.name.toLowerCase();
				activatableObjects.add(warp);
				
			case "collisionbox":
				var box = new GameObject(x, y, o.width, o.height);
				box.immovable = true;
				collisionBoxes.add(box);
				
			case "child":
				var child = new Child(x, y, Std.parseInt(o.name));
				backgroundStuff.add(child.graphicComponent);
				activatableObjects.add(child);
				
			case "knowledge":
				var kPiece = new KnowledgePickup(x, y, Std.parseInt(o.name));
				foregroundStuff.add(kPiece.graphicComponent);
				triggers.add(kPiece);
				
			case "background":
				var i:Float = 0;
				do
				{
					var bg = new FlxSprite(i, y, "assets/levels/" + o.name.toLowerCase() + ".png");
					bgImages.add(bg);
					i += bg.width;
				}
				while (i < this.fullWidth);
				
			case "dialogue":
				var dialogue = new Dialogue(x, y, o.width, o.height, o.name.toLowerCase());
				triggers.add(dialogue);
		}
	}
	
	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		var ret:Bool = false;
		
		if (collidableTileLayers != null)
		{
			for (map in collidableTileLayers)
			{
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				ret = (ret || FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate));
			}
		}
		return ret;
	}
}