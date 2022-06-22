SET
@Entry 		:= 667100,
@Model 		:= 27295,
@Name 		:= "Zardoz",
@Title 		:= "Master of Glyphs",
@Icon 		:= "Speak",
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1,
@WalkSpeed	:= 1,
@Scale		:= 1,
@Type 		:= 7,
@TypeFlags 	:= 0,
@FlagsExtra := 0,
@AIName		:= "SmartAI",
@Script 	:= "",
@NPCTextM	:= "",
@NPCTextF	:= "",
@NPCEmoteM	:= 0,
@NPCEmoteF	:= 0;

DELETE FROM acore_world.creature_template WHERE entry = @Entry;
INSERT INTO acore_world.creature_template
	(`entry`, `modelid1`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `AiName`, `ScriptName`)
    VALUES (@Entry, @Model, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, @WalkSpeed, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra, @AIName, @Script);

SELECT * FROM acore_world.creature_template WHERE `entry` = @Entry;
