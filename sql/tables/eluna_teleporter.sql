USE `acore_world`;

-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: acore_world
-- ------------------------------------------------------
-- Server version	8.0.29

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

TRUNCATE TABLE `eluna_teleporter`;
--
-- Dumping data for table `eluna_teleporter`
--

LOCK TABLES `eluna_teleporter` WRITE;
/*!40000 ALTER TABLE `eluna_teleporter` DISABLE KEYS */;
INSERT INTO `eluna_teleporter` VALUES (1, 0, 1, -1, 0, 'Old World Dungeons', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `eluna_teleporter` VALUES (2, 0, 1, -1, 0, 'Outland Dungeons', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `eluna_teleporter` VALUES (3, 0, 1, -1, 0, 'Northrend Dungeons', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `eluna_teleporter` VALUES (4, 0, 1, -1, 0, 'Places of Interest', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `eluna_teleporter` VALUES (5, 0, 1, -1, 0, 'Starting Zones', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `eluna_teleporter` VALUES (6, 0, 1, -1, 0, 'The Caverns of Time', NULL, NULL, NULL, NULL, NULL);

INSERT INTO `eluna_teleporter` VALUES (101, 1, 2, -1, 9, 'Blackfathom Deeps', 1, 4249.990, 740.102, -25.671, 1.341);
INSERT INTO `eluna_teleporter` VALUES (102, 1, 2, -1, 9, 'Blackrock Depths', 0, -7179.34, -921.212, 165.821, 5.09599);
INSERT INTO `eluna_teleporter` VALUES (103, 1, 2, -1, 9, 'The Deadmines', 0, -11208.700, 1673.520, 24.636, 1.511);
INSERT INTO `eluna_teleporter` VALUES (104, 1, 2, -1, 9, 'Dire Maul: East', 1, -3980.800, 789.005, 161.007, 4.719);
INSERT INTO `eluna_teleporter` VALUES (105, 1, 2, -1, 9, 'Dire Maul: North', 1, -3521.290, 1085.200, 161.097, 4.728);
INSERT INTO `eluna_teleporter` VALUES (106, 1, 2, -1, 9, 'Dire Maul: West', 1, -3828.010, 1250.220, 160.226, 3.208);
INSERT INTO `eluna_teleporter` VALUES (107, 1, 2, -1, 9, 'Gnomeregan', 0, -5163.540, 925.423, 257.181, 1.574);
INSERT INTO `eluna_teleporter` VALUES (108, 1, 2, -1, 9, 'Maraudon (Orange)', 1, -1464.14, 2615.21, 76.7172, 3.21357);
INSERT INTO `eluna_teleporter` VALUES (109, 1, 2, -1, 9, 'Maraudon (Purple)', 1, -1188.37, 2879.61, 85.7888, 5.07366);
INSERT INTO `eluna_teleporter` VALUES (110, 1, 2, -1, 9, 'Maraudon (Portal)', 1, -1388.64, 2924.35, 73.4021, 5.55014);
INSERT INTO `eluna_teleporter` VALUES (111, 1, 2, -1, 9, 'Ragefire Chasm', 1, 1811.780, -4410.500, -18.470, 5.202);
INSERT INTO `eluna_teleporter` VALUES (112, 1, 2, -1, 9, 'Razorfen Downs', 1, -4657.300, -2519.350, 81.053, 4.548);
INSERT INTO `eluna_teleporter` VALUES (113, 1, 2, -1, 9, 'Razorfen Kraul', 1, -4470.280, -1677.770, 81.393, 1.163);
INSERT INTO `eluna_teleporter` VALUES (114, 1, 2, -1, 9, 'Scarlet Monastery: Armory', 0, 2886.63, -835.027, 160.327, 3.66606);
INSERT INTO `eluna_teleporter` VALUES (115, 1, 2, -1, 9, 'Scarlet Monastery: Cathedral', 0, 2912.24, -824.175, 160.328, 0.373669);
INSERT INTO `eluna_teleporter` VALUES (116, 1, 2, -1, 9, 'Scarlet Monastery: Graveyard', 0, 2915.85, -801.677, 160.332, 0.354036);
INSERT INTO `eluna_teleporter` VALUES (117, 1, 2, -1, 9, 'Scarlet Monastery: Library', 0, 2868.6, -821.127, 160.332, 3.57024);
INSERT INTO `eluna_teleporter` VALUES (118, 1, 2, -1, 9, 'Scholomance', 0, 1269.640, -2556.210, 93.609, 0.621);
INSERT INTO `eluna_teleporter` VALUES (119, 1, 2, -1, 9, 'Shadowfang Keep', 0, -234.675, 1561.630, 76.892, 1.240);
INSERT INTO `eluna_teleporter` VALUES (120, 1, 2,  0, 9, 'The Stockade', 0, -8779.900, 834.349, 94.680, 0.653);
INSERT INTO `eluna_teleporter` VALUES (121, 1, 2, -1, 9, 'Stratholme', 0, 3352.920, -3379.030, 144.782, 6.260);
INSERT INTO `eluna_teleporter` VALUES (122, 1, 2, -1, 9, 'The Sunken Temple', 0, -10177.900, -3994.900, -111.239, 6.019);
INSERT INTO `eluna_teleporter` VALUES (123, 1, 2, -1, 9, 'Uldaman', 0, -6071.370, -2955.160, 209.782, 0.016);
INSERT INTO `eluna_teleporter` VALUES (124, 1, 2, -1, 9, 'Wailing Caverns', 1, -731.607, -2218.390, 17.028, 2.785);
INSERT INTO `eluna_teleporter` VALUES (125, 1, 2, -1, 9, 'Zul\'Farrak', 1, -6801.190, -2893.020, 9.004, 0.159);
INSERT INTO `eluna_teleporter` VALUES (199, 1, 3, -1, 4, 'Random Old World Dungeon', 0, 101, 123, NULL, NULL);

INSERT INTO `eluna_teleporter` VALUES (201, 2, 2, -1, 2, 'Auchindoun: Auchenai Crypts', 530, -3362.04, 5209.85, -101.05, 1.60924);
INSERT INTO `eluna_teleporter` VALUES (202, 2, 2, -1, 2, 'Auchindoun: Mana Tombs', 530, -3104.18, 4945.52, -101.507, 6.22344);
INSERT INTO `eluna_teleporter` VALUES (203, 2, 2, -1, 2, 'Auchindoun: Sethekk Halls', 530, -3362.2, 4664.12, -101.049, 4.6605);
INSERT INTO `eluna_teleporter` VALUES (204, 2, 2, -1, 2, 'Auchindoun: Shadow Labyrinth', 530, -3627.9, 4941.98, -101.049, 3.16039);
INSERT INTO `eluna_teleporter` VALUES (205, 2, 2, -1, 2, 'Coilfang Reservoir: The Slave Pens', 530, 717.282, 6979.87, -73.0281, 1.50287);
INSERT INTO `eluna_teleporter` VALUES (206, 2, 2, -1, 2, 'Coilfang Reservoir: The Steamvault', 530, 794.537, 6927.81, -80.4757, 0.159089);
INSERT INTO `eluna_teleporter` VALUES (207, 2, 2, -1, 2, 'Coilfang Reservoir: The Underbog', 530, 763.307, 6767.81, -67.7695, 5.99726);
INSERT INTO `eluna_teleporter` VALUES (208, 2, 2, -1, 2, 'Hellfire Citadel: The Blood Furnace', 530, -291.324, 3149.1, 31.5541, 2.27147);
INSERT INTO `eluna_teleporter` VALUES (209, 2, 2, -1, 2, 'Hellfire Citadel: Hellfire Ramparts', 530, -360.671, 3071.9, -15.0977, 1.89389);
INSERT INTO `eluna_teleporter` VALUES (210, 2, 2, -1, 2, 'Hellfire Citadel: The Shattered Halls', 530, -310.065, 3083.18, -3.75016, 1.73114);
INSERT INTO `eluna_teleporter` VALUES (211, 2, 2, -1, 2, 'Tempest Keep: The Arcatraz', 530, 3311.54, 1332.84, 505.556, 5.07581);
INSERT INTO `eluna_teleporter` VALUES (212, 2, 2, -1, 2, 'Tempest Keep: The Botanica', 530, 3407.11, 1488.48, 182.838, 5.59559);
INSERT INTO `eluna_teleporter` VALUES (213, 2, 2, -1, 2, 'Tempest Keep: The Mechanar', 530, 2867.12, 1549.42, 252.159, 3.82218);
INSERT INTO `eluna_teleporter` VALUES (299, 2, 3, -1, 4, 'Random Outlands Dungeon', 0, 201, 213, NULL, NULL);

INSERT INTO `eluna_teleporter` VALUES (301, 3, 2, -1, 9, 'Ahn\'Kahet: The Old Kingdom', 571, 3643.310, 2036.510, 1.787, 4.339);
INSERT INTO `eluna_teleporter` VALUES (302, 3, 2, -1, 9, 'Azjol-Nerub', 571, 3677.530, 2166.700, 35.808, 2.301);
INSERT INTO `eluna_teleporter` VALUES (303, 3, 2, -1, 9, 'Drak\'Tharon Keep', 571, 4774.600, -2032.920, 229.150, 1.590);
INSERT INTO `eluna_teleporter` VALUES (304, 3, 2, -1, 9, 'The Frozen Halls', 571, 5635.4, 2055.32, 798.05, 4.62485);
INSERT INTO `eluna_teleporter` VALUES (305, 3, 2, -1, 9, 'Gundrak', 571, 6952.300, -4419.980, 450.078, 0.808);
INSERT INTO `eluna_teleporter` VALUES (306, 3, 2, -1, 9, 'The Nexus', 571, 3893.510, 6985.330, 69.488, 6.279);
INSERT INTO `eluna_teleporter` VALUES (307, 3, 2, -1, 9, 'The Nexus: The Oculus', 571, 3879.960, 6984.620, 106.312, 3.197);
INSERT INTO `eluna_teleporter` VALUES (308, 3, 2, -1, 9, 'Ulduar: Halls of Lightning', 571, 9182.920, -1384.820, 1110.210, 5.578);
INSERT INTO `eluna_teleporter` VALUES (309, 3, 2, -1, 9, 'Ulduar: Halls of Stone', 571, 8921.910, -993.503, 1039.410, 1.553);
INSERT INTO `eluna_teleporter` VALUES (310, 3, 2, -1, 9, 'Utgarde Keep', 571, 1219.720, -4865.280, 41.248, 0.313);
INSERT INTO `eluna_teleporter` VALUES (311, 3, 2, -1, 9, 'Utgarde Pinnacle', 571, 1259.330, -4852.020, 215.763, 3.483);
INSERT INTO `eluna_teleporter` VALUES (312, 3, 2, -1, 9, 'The Violet Hold', 571, 5682.66, 490.089, 652.494, 4.03);
INSERT INTO `eluna_teleporter` VALUES (399, 3, 3, -1, 4, 'Random Northrend Dungeon', 0, 301, 312, NULL, NULL);

INSERT INTO `eluna_teleporter` VALUES (400, 4, 2,  0, 2, 'Dwarven Airfield', 0, -4686.74, -1693.35, 503.325, 0.0234865);
INSERT INTO `eluna_teleporter` VALUES (401, 4, 2, -1, 2, 'Emerald Forest', 169, 2738.87, -3320.93, 101.917, 0.366472);
INSERT INTO `eluna_teleporter` VALUES (402, 4, 2, -1, 2, 'Mirage Raceway', 1, -6221.35, -3927.64, -58.7495, 0.757735);
INSERT INTO `eluna_teleporter` VALUES (403, 4, 2, -1, 2, 'Old Ironforge', 0, -4819.56, -974.088, 464.709, 3.963);

INSERT INTO `eluna_teleporter` VALUES (500, 5, 2, 0, 2, 'Ammen Vale', 530, -4021.4, -13582.1, 54.7153, 2.06953);
INSERT INTO `eluna_teleporter` VALUES (501, 5, 2, 0, 2, 'Coldridge Valley', 0, -6231.77, 332.993, 383.171, 0.480178);
INSERT INTO `eluna_teleporter` VALUES (502, 5, 2, 0, 2, 'Northshire Valley', 0, -8921.09, -119.135, 82.195, 5.82878);
INSERT INTO `eluna_teleporter` VALUES (503, 5, 2, 0, 2, 'Shadowglen', 1, 10334, 833.902, 1326.11, 3.62142);
INSERT INTO `eluna_teleporter` VALUES (504, 5, 2, 1, 2, 'Camp Narache', 1, -2919.35, -264.535, 53.6197, 0.409027);
INSERT INTO `eluna_teleporter` VALUES (505, 5, 2, 1, 2, 'Deathknell', 0, 1843.5, 1590, 93.2971, 3.08757);
INSERT INTO `eluna_teleporter` VALUES (506, 5, 2, 1, 2, 'Sunstrider Isle', 530, 10331.1, -6235.42, 26.7759, 1.94594);
INSERT INTO `eluna_teleporter` VALUES (507, 5, 2, 1, 2, 'Valley of Trials', 1, -601.294, -4296.76, 37.8115, 1.65401);

INSERT INTO `eluna_teleporter` VALUES (600, 6, 2, -1, 9, 'Hyjal Summit', 1, -8177.89, -4181.23, -167.552, 0.913338);
INSERT INTO `eluna_teleporter` VALUES (601, 6, 2, -1, 9, 'Old Hillsbrad Foothills', 1, -8404.3, -4070.62, -208.586, 0.237038);
INSERT INTO `eluna_teleporter` VALUES (602, 6, 2, -1, 9, 'The Black Morass', 1, -8734.3, -4230.11, -209.5, 2.16212);
INSERT INTO `eluna_teleporter` VALUES (603, 6, 2, -1, 9, 'The Culling of Stratholme', 1, -8750.76, -4442.2, -199.26, 4.37694);

/* INSERT INTO `eluna_teleporter` VALUES (); */
/*
INSERT INTO `eluna_teleporter` VALUES ();
*/

/*!40000 ALTER TABLE `eluna_teleporter` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-06 15:41:08
