package  
{
	import adobe.utils.CustomActions;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FX.BlurFX;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FlxExtendedSprite;
	import org.flixel.plugin.photonstorm.FlxMouseControl;
	import flash.utils.Timer;
	import org.flixel.FlxSave;
	import flash.system.System;
	/**
	 * ...
	 * @author Alec Day
	 */
	public class GameScreen extends FlxState
	{
		[Embed(source = "sprites/exit.png")]public static var eBut:Class;
		[Embed(source = "sprites/restart.png")]public static var rBut:Class;
		
		private var player:Player = new Player(320, 240);
		private var score:int = 0;
		private var intervalMod:uint = 3;
		private var sText:FlxText = new FlxText(FlxG.width / 2, 0, 300, "");
		private var enemyTimer:Timer = new Timer(1000, 3);
		private var gameTimer:Timer = new Timer(1000, 0);
		private var game2Timer:Timer = new Timer(1, 0);
		private var created:Boolean = false;
		private var enemies:FlxGroup = new FlxGroup();
		private var activeGame:Boolean = true;
		
		private var blur:BlurFX;
		private var blurFXKT:FlxSprite;
		private var exitButton:FlxExtendedSprite = new FlxExtendedSprite(0, 0, eBut);
		private var restartButton:FlxExtendedSprite = new FlxExtendedSprite(1080, 0, rBut);
		public function GameScreen() 
		{
			add(player);
			
			sText.size = 40; 
			gameTimer.start();
			game2Timer.start();
			add(sText);
			
			enemyTimer.start();
			
			if (FlxG.getPlugin(FlxMouseControl) == null)
			{
				FlxG.addPlugin(new FlxMouseControl);
				
			}
			
			exitButton.enableMouseClicks(true, false, 255);
			restartButton.enableMouseClicks(true, false, 255);
			
			exitButton.mouseReleasedCallback = exit;
			restartButton.mouseReleasedCallback = restart;
			add(exitButton);
			add(restartButton);
		}
		
		override public function create():void
		{
			
			
			
			if (FlxG.getPlugin(FlxSpecialFX) == null)
			{
				FlxG.addPlugin(new FlxSpecialFX);
				
			}
			
			if (FlxG.getPlugin(FlxExtendedSprite) == null)
			{
				FlxG.addPlugin(new FlxExtendedSprite);
				
			}
			
			
			blur = FlxSpecialFX.blur();
 
			blurFXKT = blur.create(1920, 1080, 4, 4, 1);
 
			blur.addSprite(player);
 
			//add(blurFXKT);
			add(player);
 
			blur.start(0);
		}
		override public function update():void
		{
			
			if (FlxG.keys.justPressed("ESCAPE"))
			{
				System.exit(0);
			}
			
			if (FlxG.keys.justPressed("R"))
			{
				FlxG.resetState();
			}
			
			if (FlxG.keys.justPressed("P"))
			{
				if (activeGame)
				{
				activeGame = false;
				}
				else if (!activeGame)
				activeGame = true;
			}
			super.update();
			
			if (activeGame)
			{
				exitButton.visible = false;
				restartButton.visible = false;
			}
			
			if (!activeGame)
			{
				exitButton.visible = true;
				restartButton.visible = true;
				return;
			}
			var mins:uint = gameTimer.currentCount / 60;
			var secs:uint = gameTimer.currentCount % 60;
			var mSecs:uint = game2Timer.currentCount % 10;
			
			
			if(secs < 10)
			sText.text = mins.toString() + " : 0" + secs.toString() + " : " + mSecs.toString();
			
			if(secs >= 10)
			sText.text = mins.toString() + " : " + secs.toString() + " : " + mSecs.toString();
			score += 1;
			if (FlxG.collide(player,enemies))
			{
				lose();
			}
			
			if (enemyTimer.running == false)
			{
				var tempEnem:Horiz = new Horiz(1984, Math.random() * 1080);
				var tempEnem2:Vert = new Vert( Math.random() * 1920, 1200);
				
				switch(intervalMod)
				{
					case 3:
						break;
					case 5:
						tempEnem.acceleration.x = - 500;
						tempEnem2.acceleration.y = - 500;
						break;
					case 7:
						tempEnem.acceleration.x = - 700;
						tempEnem2.acceleration.y = - 700;
						break;
					case 9:
						tempEnem.acceleration.x = - 900;
						tempEnem2.acceleration.y = - 900;
						break;
				}
				for (var i:int = 0; i < intervalMod; i++)
				{
				add(tempEnem);
				enemies.add(tempEnem);
				
				add(tempEnem2);
				enemies.add(tempEnem2);
				}
				enemyTimer.start();
				
			}
			
			//Tick changer
			if (score == 1000)
			{
				intervalMod = 5;
				enemyTimer.repeatCount = 2;
			}
			
			if (score == 1500)
			{
				intervalMod = 7;
				enemyTimer.repeatCount = 2;
			}
			
			if (score == 2800)
			{
				intervalMod = 9;
				enemyTimer.repeatCount = 1;
			}
			
		}
		
		public function lose():void
		{
			FlxG.flash(0xffffffff, 1, null, false);
			activeGame = false;
			enemies.kill();
			player.active = false;
			sText.color = 0xffff0000;
		}
		
		override public function destroy():void
		{
			//	Important! Clear out the plugin, otherwise resources will get messed right up after a while
			FlxSpecialFX.clear();
 
			super.destroy();
		}
		
		public function exit(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			System.exit(0);
		}
		
		public function restart(a:FlxExtendedSprite,b:uint,c:uint):void
		{
			FlxG.resetState();
		}
 
	}

}