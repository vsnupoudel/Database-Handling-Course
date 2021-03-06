USE bishnu;
CREATE TABLE IF NOT EXISTS `bishnu`.`TABLE 1` 
(`analysis_id` int(2), 
`analysis_time` varchar(19), 
`test_name` varchar(22), 
`analysis_result` decimal(4,1),
 `sample_id` int(1), 
 `name` varchar(5), 
 `role` varchar(15)) 
 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;




INSERT INTO `bishnu`.`TABLE 1` (`analysis_id`, `analysis_time`, `test_name`, `analysis_result`, `sample_id`, `name`, `role`) VALUES (1, '2020-03-10 18:00:00', 'Ortophosphate', 2.5, 1, 'Frank', 'lab technichian'),
 (2, '2020-03-10 18:00:00', 'Total suspended solids', 10, 1, 'Frank', 'lab technichian'),
 (3, '2020-03-10 18:00:00', 'nitrogen', 45, 1, 'Frank', 'lab technichian'),
 (4, '2020-03-10 18:00:00', 'PH', 6.2, 1, 'Frank', 'lab technichian'),
 (5, '2020-03-11 17:00:00', 'Ortophosphate', 3, 2, 'Frank', 'lab technichian'),
 (6, '2020-03-11 17:00:00', 'Total suspended solids', 11, 2, 'Frank', 'lab technichian'),
 (7, '2020-03-11 17:00:00', 'nitrogen', 50, 2, 'Frank', 'lab technichian'),
 (8, '2020-03-12 17:00:00', 'Ortophosphate', 2.6, 3, 'Frank', 'lab technichian'),
 (9, '2020-03-12 17:00:00', 'Total suspended solids', 102, 3, 'Frank', 'lab technichian'),
 (10, '2020-03-12 17:00:00', 'nitrogen', 64, 3, 'Frank', 'lab technichian'),
 (11, '2020-03-13 19:00:00', 'Ortophosphate', 2.1, 4, 'Frank', 'lab technichian'),
 (12, '2020-03-13 19:00:00', 'Total suspended solids', 13.2, 4, 'Frank', 'lab technichian'),
 (13, '2020-03-13 19:00:00', 'nitrogen', 133, 4, 'Frank', 'lab technichian'),
 (14, '2020-03-13 19:00:00', 'PH', 6.2, 4, 'Frank', 'lab technichian'),
 (15, '2020-03-14 17:00:00', 'Ortophosphate', 1.1, 5, 'Frank', 'lab technichian'),
 (16, '2020-03-14 17:00:00', 'Total suspended solids', 8.2, 5, 'Frank', 'lab technichian'),
 (17, '2020-03-14 17:00:00', 'nitrogen', 88, 5, 'Frank', 'lab technichian');
 
 DROP TABLE IF  EXISTS `bishnu`.`analysis_original`;
 RENAME TABLE `bishnu`.`TABLE 1` TO analysis_original;
 
 
 
 CREATE TABLE IF NOT EXISTS `bishnu`.`TABLE 2` (
 `sample_id` int(1)
 , `tests_to_run` varchar(13)
 , `sample time` varchar(19)
 , `operator_id` int(1)
 , `name` varchar(10)
 , `role` varchar(8)) 
 DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
 
 INSERT INTO `bishnu`.`TABLE 2` (`sample_id`, `tests_to_run`, `sample time`, `operator_id`, `name`, `role`) VALUES (1, 'Full tests', '2020-03-10 14:00:00', 1, 'Aleksander', 'operator'),
 (2, 'full minus PH', '2020-03-11 14:00:00', 1, 'Aleksander', 'operator'),
 (3, 'full minus PH', '2020-03-12 14:00:00', 1, 'Aleksander', 'operator'),
 (4, 'Full tests', '2020-03-13 14:00:00', 2, 'Nils', 'operator'),
 (5, 'full minus PH', '2020-03-14 14:00:00', 2, 'Nils', 'operator');
 
  DROP TABLE IF  EXISTS `bishnu`.`samples_original`;
  RENAME TABLE `bishnu`.`TABLE 2` TO samples_original;
 
 
 
 
 