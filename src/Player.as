package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Player extends FlxSprite
	{
		
		public function Player(x:uint, y:uint) 
		{
			super(x, y);
			makeGraphic(64, 64, 0xffffffff, true, null);
			active = true;
		}
		
		override public function update():void
		{
			if(FlxG.mouse.x > 0)
			x = FlxG.mouse.x;
			
			if(FlxG.mouse.y > 0)
			y = FlxG.mouse.y;
		}
	}

}