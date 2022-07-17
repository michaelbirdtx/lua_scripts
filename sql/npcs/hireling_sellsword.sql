SET
@Entry 			:= 669001,
@Model1 		:= 17214,
@Model2 		:= 3054,
@Model3 		:= 1314,
@Model4 		:= 17671,
@Name 			:= 'Sellsword',
@MinLevel 		:= 10,
@MaxLevel 		:= 10,
@Faction 		:= 35,
@DetectionRange := 60,
@Class			:= 1,
@AIName			:= "CombatAI"
;

DELETE FROM acore_world.creature_template WHERE entry = @Entry;
INSERT INTO acore_world.creature_template
	(`entry`,`difficulty_entry_1`,`difficulty_entry_2`,`difficulty_entry_3`,`KillCredit1`,`KillCredit2`,`modelid1`,`modelid2`,`modelid3`,`modelid4`,`name`,`subname`,`IconName`,`gossip_menu_id`,`minlevel`,`maxlevel`,`exp`,`faction`,`npcflag`,`speed_walk`,`speed_run`,`speed_swim`,`speed_flight`,`detection_range`,`scale`,`rank`,`dmgschool`,`DamageModifier`,`BaseAttackTime`,`RangeAttackTime`,`BaseVariance`,`RangeVariance`,`unit_class`,`unit_flags`,`unit_flags2`,`dynamicflags`,`family`,`trainer_type`,`trainer_spell`,`trainer_class`,`trainer_race`,`type`,`type_flags`,`lootid`,`pickpocketloot`,`skinloot`,`PetSpellDataId`,`VehicleId`,`mingold`,`maxgold`,`AIName`,`MovementType`,`HoverHeight`,`HealthModifier`,`ManaModifier`,`ArmorModifier`,`ExperienceModifier`,`RacialLeader`,`movementId`,`RegenHealth`,`mechanic_immune_mask`,`spell_school_immune_mask`,`flags_extra`,`ScriptName`,`VerifiedBuild`)
	VALUES (@Entry,0,0,0,0,0,@Model1,@Model2,@Model3,@Model4,@Name,'','',0,@MinLevel,@MaxLevel,2,@Faction,1,1,1.14286,1,1,@DetectionRange,1,0,0,1,2000,2000,1,1,@Class,8,2048,2,0,0,0,0,0,7,0,0,0,0,0,0,0,0,@AIName,0,1,1,1,1,1,0,121,1,76561,0,0,'',12340);
SELECT * FROM acore_world.creature_template WHERE entry = @Entry;
