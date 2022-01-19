package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import io.newgrounds.NG;
import lime.app.Application;

using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;

	var separators:FlxSprite;

	var selected:FlxSprite;

	var storymenu:FlxSprite;
	var freeplay:FlxSprite;
	var credits:FlxSprite;
	var options:FlxSprite;

	var storymenuSelected:FlxSprite;
	var freeplaySelected:FlxSprite;
	var creditsSelected:FlxSprite;
	var optionsSelected:FlxSprite;	

	var notSelected1:FlxSprite;
	var notSelected2:FlxSprite;
	var notSelected3:FlxSprite;
	var notSelected4:FlxSprite;

	#if !switch
	var optionShit:Array<String> = ['story mode', 'freeplay', 'credits', 'options'];
	#else
	var optionShit:Array<String> = ['story mode', 'freeplay'];
	#end

  var menubfeye:FlxSprite;
 
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		FlxG.sound.playMusic(Paths.music('freakyMenu1'), 1);

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		var menubf:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuBF'));
		menubf.updateHitbox();
		menubf.antialiasing = true;
		add(menubf);

		menubfeye = new FlxSprite(0, 0).loadGraphic(Paths.image('menuBFeye'));
		menubfeye.visible = false;
		menubfeye.updateHitbox();
		menubfeye.antialiasing = true;
		add(menubfeye);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		separators = new FlxSprite(-80).loadGraphic(Paths.image('seperators'));
		separators.setGraphicSize(Std.int(separators.width * 1.1));
		separators.screenCenter();
		add(separators);

		selected = new FlxSprite(800, 130).loadGraphic(Paths.image('selected'));
		selected.alpha = 0.75;
		selected.setGraphicSize(Std.int(selected.width * 1.1));
		add(selected);


		notSelected1 = new FlxSprite(800, 122).loadGraphic(Paths.image('notselect'));
		notSelected1.setGraphicSize(Std.int(notSelected1.width * 1.1));
		notSelected1.visible = false;
		add(notSelected1);

		notSelected2 = new FlxSprite(800, 244).loadGraphic(Paths.image('notselect'));
		notSelected2.setGraphicSize(Std.int(notSelected2.width * 1.1));
		add(notSelected2);

		notSelected3 = new FlxSprite(800, 362).loadGraphic(Paths.image('notselect'));
		notSelected3.setGraphicSize(Std.int(notSelected3.width * 1.1));
		add(notSelected3);	
		
		notSelected4 = new FlxSprite(800, 482).loadGraphic(Paths.image('notselect'));
		notSelected4.setGraphicSize(Std.int(notSelected4.width * 1.1));
		add(notSelected4);			

		storymenu = new FlxSprite(750, 150).loadGraphic(Paths.image('mainmenu0'));
		storymenu.visible = false;
		menuItems.add(storymenu);

		freeplay = new FlxSprite(750, 270).loadGraphic(Paths.image('mainmenu1'));
		menuItems.add(freeplay);

		credits = new FlxSprite(750, 390).loadGraphic(Paths.image('mainmenu2'));
		menuItems.add(credits);

		options = new FlxSprite(750, 515).loadGraphic(Paths.image('mainmenu3'));
		menuItems.add(options);

		storymenuSelected = new FlxSprite(750, 150).loadGraphic(Paths.image('mainselected0'));
		add(storymenuSelected);

		freeplaySelected = new FlxSprite(750, 270).loadGraphic(Paths.image('mainselected1'));
		freeplaySelected.visible = false;
		add(freeplaySelected);

		creditsSelected = new FlxSprite(750, 390).loadGraphic(Paths.image('mainselected2'));
		creditsSelected.visible = false;
		add(creditsSelected);

		optionsSelected = new FlxSprite(750, 515).loadGraphic(Paths.image('mainselected3'));
		optionsSelected.visible = false;
		add(optionsSelected);		

		var versionShit:FlxText = new FlxText(5, FlxG.height - 18, 0, "Version: Senpai DEMO", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);


		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{
			if (controls.UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
			  menubfeye.visible = true;
			  FlxG.camera.flash(FlxColor.WHITE, 1);
				if (optionShit[curSelected] == 'donate')
				{
					#if linux
					Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
					#else
					FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
					#end
				}
				else
					{
						selectedSomethin = true;
						FlxG.sound.play(Paths.sound('confirmMenu'));
						var daChoice:String = optionShit[curSelected];
	
									switch (daChoice)
									{
										case 'story mode':
											FlxG.switchState(new StoryMenuState());
											trace("Story Menu Selected");
										case 'freeplay':
											FlxG.switchState(new FreeplayState());
	
											trace("Freeplay Menu Selected");
										
										case 'credits':
											FlxG.switchState(new CreditsState());
										case 'options':
											FlxG.switchState(new OptionsMenu());
									}
							
					}
				}
			}

		super.update(elapsed);

	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		switch (curSelected){
			case 0:
				notSelected1.visible = false;
				notSelected2.visible = true;
				notSelected3.visible = true;
				notSelected3.visible = true;

				selected.y = 130;

				storymenuSelected.visible = true;
				freeplaySelected.visible = false;
				creditsSelected.visible = false;
				optionsSelected.visible = false;	
				
				storymenu.visible = false;
				freeplay.visible = true;
				credits.visible = true;
				options.visible = true;
			case 1:
				notSelected1.visible = true;
				notSelected2.visible = false;
				notSelected3.visible = true;
				notSelected4.visible = true;

				selected.y = 250;

				storymenuSelected.visible = false;
				freeplaySelected.visible = true;
				creditsSelected.visible = false;
				optionsSelected.visible = false;	
				
				storymenu.visible = true;
				freeplay.visible = false;
				credits.visible = true;
				options.visible = true;
			case 2:
				notSelected1.visible = true;
				notSelected2.visible = true;
				notSelected3.visible = false;
				notSelected4.visible = true;

				selected.y = 370;

				storymenuSelected.visible = false;
				freeplaySelected.visible = false;
				creditsSelected.visible = true;
				optionsSelected.visible = false;	

				storymenu.visible = true;
				freeplay.visible = true;
				credits.visible = false;
				options.visible = true;
			case 3:
				notSelected1.visible = true;
				notSelected2.visible = true;
				notSelected3.visible = true;
				notSelected4.visible = false;

				selected.y = 490;		

				storymenuSelected.visible = false;
				freeplaySelected.visible = false;
				creditsSelected.visible = false;
				optionsSelected.visible = true;	
				
				storymenu.visible = true;
				freeplay.visible = true;
				credits.visible = true;
				options.visible = false;				
		}

	}
}