package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import org.flixel.FlxCamera;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class TitleScreen extends FlxState
	{
		private var Title:FlxText = new FlxText(120, 240, 200, "Dodge It!", false);
		public function TitleScreen() 
		{
			add(Title);
			
		}
		
		override public function create():void
		{
			FlxG.bgColor = FlxG.BLUE;
			toggle_fullscreen(StageDisplayState.FULL_SCREEN);
		}
		
		override public function update():void
		{
			if (FlxG.keys.justPressed("SPACE") || FlxG.mouse.justPressed())
			{
				FlxG.switchState(new GameScreen);
			}
			
		}
		
		private function toggle_fullscreen(ForceDisplayState:String=null):void {
 
            // 1. Change the size of the Flash window to fullscreen/windowed
            //    This is easily done by checking stage.displayState and then setting it accordingly
            if (ForceDisplayState) {
                FlxG.stage.displayState = ForceDisplayState;
            } else {
                if (FlxG.stage.displayState == StageDisplayState.NORMAL) {
                    FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
                } else {
                    FlxG.stage.displayState = StageDisplayState.NORMAL;
                }
            }
 
            // The next function contains steps 2-4
            window_resized();
        }

		        // This is called every time the window is resized
        // It's a separate function than toggle_fullscreen because we want to call it when the window
        // size changed even if the user didn't click the fullscreen button (eg by pressing escape to exit fullscreen mode)
        private function window_resized(e:Event = null):void {
 
            // 2. Change the size of the Flixel game window
            //    We already changed the size of the Flash window, so now we need to update Flixel.
            //    Just update the FlxG dimensions to match the new stage dimensions from step 1
            FlxG.width = FlxG.stage.stageWidth / FlxCamera.defaultZoom;
            FlxG.height = FlxG.stage.stageHeight / FlxCamera.defaultZoom;
 
            // 3. Change the size of the Flixel camera
            //    Lastly, update the Flixel camera to match the new dimensions from the previous step
            //    This is so that the camera can see all of the freshly resized dimensions
            FlxG.resetCameras(new FlxCamera(0, 0, FlxG.width, FlxG.height));
 
            // 4. Optionally, depening on your game, you may need to update couple more things:
            //    - Reposition / resize things such as the Hud to match the new screen dimensions
            //    - Camera bounds to allow the camera to travel everywhere within the resized dimensions
            //    - World bounds to allow everything to collide within the resized dimensions
            //    - For more information on camera/world bounds/hud positioning check out our other tutorial at
            //              http://www.funstormgames.com/blog/2011/10/flixel-setting-up-game-dimensions-swf-camera-level-hud-mouse/
            //    Anyways, we're just going to update the fullscreen button and dimensions text
            Title.x = FlxG.width / 2 - Title.width / 2;
            Title.y = FlxG.height / 2 - Title.height / 2;
 
        }
 
		override public function destroy():void
		{
			super.destroy();
		}
	}

	
}