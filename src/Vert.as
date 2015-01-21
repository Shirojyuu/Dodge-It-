package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class Vert extends FlxSprite
	{
		
		public function Vert(x:uint, y:uint) 
		{
			super(x, y);
			makeGraphic(64, 64, 0xffff0000, false, null);
			acceleration.y = -250;
		}
		
		override public function update():void
		{
			if (y < -32)
			{
				kill();
			}
		}
		
	}

}