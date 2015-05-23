package;

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
 * ...
 * @author Samuel Batista
 */
class TiledLevel extends TiledMap
{
	// For each "Tile Layer" in the map, you must define a "tileset" property which contains the name of a tile sheet image 
	// used to draw tiles in that layer (without file extension). The image file must be located in the directory specified bellow.
	private inline static var c_PATH_LEVEL_TILESHEETS = "assets/levels/";
	
	// Array of tilemaps used for collision
	public var allStuff:FlxGroup = new FlxGroup();
	
	public var foregroundTiles:FlxGroup;
	public var backgroundTiles:FlxGroup;
	public var coins:FlxGroup;
	private var startPoint:FlxObject;
	private var collidableTileLayers:Array<FlxTilemap>;
	private var parent:PlayState;
	
	public function new(tiledLevel:Dynamic)
	{
		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();
		
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
		
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
				foregroundTiles.add(tilemap);
			}
			else
			{
				backgroundTiles.add(tilemap);
			}
			
		}
	}
	
	public function loadLevel(state:PlayState)
	{
		parent = state;
		
		// Add tilemaps
		allStuff.add(backgroundTiles);
		
		// Draw coins first
		coins = new FlxGroup();
		allStuff.add(coins);
		
		// Load player objects
		loadObjects();
		
		// Add foreground tiles after adding level objects, so these tiles render on top of player
		allStuff.add(foregroundTiles);
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
				startPoint = new FlxObject(x, y);
				
			case "floor":
				var floor = new FlxObject(x, y, o.width, o.height);
				parent.floor = floor;
				
			case "coin":
				var tileset = g.map.getGidOwner(o.gid);
				var coin = new FlxSprite(x, y, c_PATH_LEVEL_TILESHEETS + tileset.imageSource);
				coins.add(coin);
				
			case "exit":
				// Create the level exit
				var exit = new FlxSprite(x, y);
				exit.makeGraphic(32, 32, 0xff3f3f3f);
				exit.exists = false;
		}
	}
	
	public function getStartPoint():Array<Float>
	{
		var ret = new Array<Float>();
		ret.push(startPoint.x);
		ret.push(startPoint.y);
		return ret;
	}
	
	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool
	{
		if (collidableTileLayers != null)
		{
			for (map in collidableTileLayers)
			{
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				return FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate);
			}
		}
		return false;
	}
}