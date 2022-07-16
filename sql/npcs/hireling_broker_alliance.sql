SET
@Entry 		:= 669010,
@Model1 	:= 17213,
@Model2 	:= 6198,
@Model3 	:= 12778,
@Model4 	:= 12780,
@Name 		:= "Hireling Broker",
@Title		:= "Blackwater Raiders",
@Icon 		:= "Speak", /* Options: Directions, Gunner, vehicleCursor, Driver, Attack, Buy, Speak, Pickup, Interact, Trainer, Taxi, Repair, LootAll, Quest, PVP */
@GossipMenu := 0,
@MinLevel 	:= 80,
@MaxLevel 	:= 80,
@Faction 	:= 35,
@NPCFlag 	:= 1, /* 1=Gossip, 2=Quest Giver, 16=Trainer, 32=Class Trainer, 64=Profession Trainer, 128=Generic Vendor, 256=Vendor Ammo, 512=Vendor Food, 1024=Vendor Poison, 2048=Vendor Reagent, 4096=Repairer, 8192=Flight Master, 65536=Innkeeper, 131072=Banker */
@WalkSpeed	:= 1,
@Scale		:= 1,
@Type 		:= 7, /* 0=None, 1=Beast, 2=Dragonkin, 3=Demon, 4=Elemental, 5=Giant, 6=Undead, 7=Humanoid, 8=Critter, 9=Mechanical */
@TypeFlags 	:= 0,
@FlagsExtra := 0,
@AIName		:= "SmartAI",
@Script 	:= "";

DELETE FROM acore_world.creature_template WHERE entry = @Entry;
INSERT INTO acore_world.creature_template
	(`entry`,`modelid1`, `modelid2`, `modelid3`, `modelid4`, `name`, `subname`, `IconName`, `gossip_menu_id`, `minlevel`, `maxlevel`, `faction`, `npcflag`, `speed_walk`, `speed_run`, `scale`, `unit_class`, `unit_flags`, `type`, `type_flags`, `RegenHealth`, `flags_extra`, `AiName`, `ScriptName`)
    VALUES (@Entry, @Model1, @Model2, @Model3, @Model4, @Name, @Title, @Icon, @GossipMenu, @MinLevel, @MaxLevel, @Faction, @NPCFlag, @WalkSpeed, 1.14286, @Scale, 1, 2, @Type, @TypeFlags, 1, @FlagsExtra, @AIName, @Script);

SELECT * FROM acore_world.creature_template WHERE `entry` = @Entry;
