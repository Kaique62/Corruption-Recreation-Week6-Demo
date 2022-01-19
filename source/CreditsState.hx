package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class CreditsState extends MusicBeatState
{
    var creditsArray:Array<String> = ['Phantom Fear', 'Merch', 'DatDavi', 'JellyFish', 'Gryscl', 'PinceProd', 'Neato', 'Squeaksc', 'FluffyHairs', 'Cval', 'SaraSacuni', 'NinjaMuffin', 'PhantomArcade', 'KawaiSprite', 'EvilSKR', 'KadeDev'];
    var creditsText:FlxTypedGroup<Alphabet>;
    var curSelected:Int = 0;

    override function create() {

		var creditsBG:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('creditsBG'));
		creditsBG.setGraphicSize(Std.int(creditsBG.width * 1.1));
		creditsBG.updateHitbox();
		creditsBG.screenCenter();
		creditsBG.antialiasing = true;
		add(creditsBG);

        var creditsFG:FlxSprite = new FlxSprite(-80).loadGraphic(Paths.image('creditsFG'));
		creditsFG.setGraphicSize(Std.int(creditsFG.width * 1.1));
		creditsFG.updateHitbox();
		creditsFG.screenCenter();
		creditsFG.antialiasing = true;
		add(creditsFG);

        creditsText = new FlxTypedGroup<Alphabet>();
		add(creditsText);

		for (i in 0...creditsArray.length)
		{ 
			var creditstxt:Alphabet = new Alphabet(0, 0, creditsArray[i], true, false);
			creditstxt.isMenuItem = true;
			creditstxt.targetY = i - 10;
			creditsText.add(creditstxt);
		}        

        super.create();
    }

	override function update(elapsed:Float)
        {
            super.update(elapsed);

            if (controls.BACK)
                FlxG.switchState(new MainMenuState());
            if (controls.UP_P)
                changeSelection(-1);
            if (controls.DOWN_P)
                changeSelection(1);

            if (controls.ACCEPT)
                {
                    var daSelected:String = creditsArray[curSelected];

                    switch (daSelected)
                    {
                        case "Phantom Fear":
                            FlxG.openURL('https://www.youtube.com/channel/UCRab81QtbYFqbnkvhYC9G4A');					
                        case "Merch":
                            FlxG.openURL('https://crowdmade.com/collections/phantomfear');	
                        case "DatDavi":
                            FlxG.openURL('https://www.youtube.com/channel/UCG7giAv1amNwu545m9X2LsQ');
                        case "JellyFish":
                            FlxG.openURL('https://www.youtube.com/channel/UCVgVvwOzvsR8pRwVy316SyA');
                        case "Gryscl":
                            FlxG.openURL('https://www.youtube.com/channel/UCUh2_UWT3yiKMXNH5RlBZxQ');
                        case "PinceProd":
                            FlxG.openURL('https://www.youtube.com/channel/UCRKD64HIOEREF7afcmu0WGA');
                        case "Neato":
                            FlxG.openURL('https://twitter.com/NeatoNG_');
                        case "Squeaksc":
                            FlxG.openURL('https://www.youtube.com/c/Squeak_SC');
                        case "FluffyHairs":
                            FlxG.openURL('https://www.youtube.com/c/fluffyhairsmusic');
                        case "Cval":
                            FlxG.openURL('https://www.youtube.com/channel/UCKFbKhsFKJ6uTs2t2w9KtPQ');
                        case "SaraSacuni":
                            FlxG.openURL('https://twitter.com/sarasacuni');
                        case "NinjaMuffin":
                            FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                        case "PhantomArcade":
                            FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                        case "KawaiSprite":
                            FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                        case "EvilSKR":
                            FlxG.openURL('https://www.kickstarter.com/projects/funkin/friday-night-funkin-the-full-ass-game');
                        case "KadeDev":
                            FlxG.openURL('https://www.youtube.com/c/KadeDev');                                               													
                    }     
            }
        }       

	function changeSelection(change:Int = 0)
		{
	
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	
			curSelected += change;
	
			if (curSelected < 0)
				curSelected = creditsArray.length - 1;
			if (curSelected >= creditsArray.length)
				curSelected = 0;
	
			// selector.y = (70 * curSelected) + 30;
	
			var bullShit:Int = 0;
		
			for (item in creditsText.members)
			{
				item.targetY = bullShit - curSelected;
				bullShit++;
	
				item.alpha = 0.6;
	
				if (item.targetY == 0)
				{
					item.alpha = 1;
				}
			}
		}
}