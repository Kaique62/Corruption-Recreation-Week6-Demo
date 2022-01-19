package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

using StringTools;

//Using dialoguebox.hx cuz skill issue

class TitleIntro extends FlxSpriteGroup
{
	var box:FlxSprite;

	var curCharacter:String = '';

	var dialogue:Alphabet;
	var dialogueList:Array<String> = [];

	// SECOND DIALOGUE FOR THE PIXEL SHIT INSTEAD???
	var swagDialogue:FlxTypeText;

	var dropText:FlxText;

	public var finishThing:Void->Void;

	var intro1:FlxSprite;
	var intro2:FlxSprite;
	var intro3:FlxSprite;

	public function new(talkingRight:Bool = true, ?dialogueList:Array<String>)
	{
		super();


		box = new FlxSprite(-20, 45);
		
		var hasDialog = false;

		hasDialog = true;
		box.loadGraphic("assets/images/chains.png");
		box.scrollFactor.x = 0;
		box.scrollFactor.y = 0.18;
		box.setGraphicSize(Std.int(box.width * 1));
		box.updateHitbox();
		box.screenCenter();
		box.antialiasing = true;		

		this.dialogueList = dialogueList;
		
		if (!hasDialog)
			return;
		
		intro1 = new FlxSprite(-20, 40);
		intro1.loadGraphic("assets/images/warningImage1.png");
		intro1.setGraphicSize(Std.int(intro1.width * 0.5));
		add(intro1);
		intro1.visible = false;

		intro2 = new FlxSprite(-20, 40);
		intro2.loadGraphic("assets/images/warningImage2.png");
		intro2.setGraphicSize(Std.int(intro2.width * 0.5));
		add(intro2);
		intro2.visible = false;

		intro3 = new FlxSprite(-20, 40);
		intro3.loadGraphic("assets/images/warningImage3.png");
		intro3.setGraphicSize(Std.int(intro3.width * 0.5));
		add(intro3);
		intro3.visible = false;		
		

		add(box);

		box.screenCenter(X);
		intro1.screenCenter(X);
		intro2.screenCenter(X);
		intro3.screenCenter(X);

		intro1.screenCenter(Y);
		intro2.screenCenter(Y);
		intro3.screenCenter(Y);


		if (!talkingRight)
		{
			// box.flipX = true;
		}

		dropText = new FlxText(242, 502, Std.int(FlxG.width * 0.6), "", 32);
		dropText.font = 'Pixel Arial 11 Bold';
		dropText.color = 0xFFD89494;
		dropText.visible = false;
		add(dropText);

		swagDialogue = new FlxTypeText(240, 500, Std.int(FlxG.width * 0.6), "", 32);
		swagDialogue.font = 'Pixel Arial 11 Bold';
		swagDialogue.color = 0xFF3F2021;
		swagDialogue.visible = false;
		add(swagDialogue);

		dialogue = new Alphabet(0, 80, "", false, true);
		// dialogue.x = 90;
		// add(dialogue);
	}

	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;

	override function update(elapsed:Float)
	{
		// HARD CODING CUZ IM STUPDI


		dropText.text = swagDialogue.text;

		new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{
			dialogueOpened = true;
		});

		if (dialogueOpened && !dialogueStarted)
		{
			startDialogue();
			dialogueStarted = true;
		}

		if (FlxG.keys.justPressed.ENTER  && dialogueStarted == true)
		{
			FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);

			remove(dialogue);

			if (dialogueList[1] == null && dialogueList[0] != null)
			{
				if (!isEnding)
				{
					finishThing();
					kill();
				}
			}
			else
			{
				dialogueList.remove(dialogueList[0]);
				startDialogue();
			}
		}
		
		super.update(elapsed);
	}

	var isEnding:Bool = false;

	function startDialogue():Void
	{
		cleanDialog();
		// var theDialog:Alphabet = new Alphabet(0, 70, dialogueList[0], false, true);
		// dialogue = theDialog;
		// add(theDialog);

		// swagDialogue.text = ;
		swagDialogue.resetText(dialogueList[0]);
		swagDialogue.start(0.04, true);

		switch (curCharacter)
		{
			case 'intro1':
				intro1.visible = true;
				intro2.visible = false;
				intro3.visible = false;
			case 'intro2':
				intro1.visible = false;
				intro2.visible = true;
				intro3.visible = false;
			case 'intro3':
				intro1.visible = false;
				intro2.visible = false;
				intro3.visible = true;
		}
	}

	function cleanDialog():Void
	{
		var splitName:Array<String> = dialogueList[0].split(":");
		curCharacter = splitName[1];
		dialogueList[0] = dialogueList[0].substr(splitName[1].length + 2).trim();
	}
}
