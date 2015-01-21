package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Horiz extends FlxSprite
	{
		
		public function Horiz(x:uint, y:uint) 
		{
			super(x, y);
			makeGraphic(64, 64, 0xffff0000, false, null);
			acceleration.x = -250;
		}
		
		override public function update():void
		{
			if (x < -32)
			{
				kill();
			}
		}
		
	}

}