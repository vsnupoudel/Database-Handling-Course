-- ------------------------------------------------------------------------------------------------
-- Operator details
-- ------------------------------------------------------------------------------------------------

INSERT INTO `WESH`.`operators_details` (operator_name, operator_role) VALUES 	
('Aleksander',	'operator'),
('Nils',	'operator'),
('Frank',	'lab technician');

-- ------------------------------------------------------------------------------------------------
-- Every time a sample is generated, the end-user selects a test_name ( eg Ortophosphate)
-- and a test group name ( eg Full tests)
-- So first we insert into `test_description` and `test_group`
-- ------------------------------------------------------------------------------------------------
 INSERT INTO `WESH`.`test_group`  (test_group_name) VALUES 
('Full tests'),
('Full minus PH');

	 INSERT INTO `WESH`.`test_description`  ( test_group_test_group_ID, test_name, test_description) VALUES 	
('2',	'Ortophosphate',	'"Zero" the meter (if you are using one) using a reagent blank (distilled water plus the reagent powder) and following the manufacturer''s directions."'),
('2',	'Total suspended solids',	'TSS of a water or wastewater sample is determined by pouring a carefully measured volume of water (typically one litre; but less if the particulate density is high, or as much as two or three litres for very clean water) through a pre-weighed filter of a specified pore size, then weighing the filter again after the drying process that removes all water on the filter. Filters for TSS measurements are typically composed of glass fibres.[2] The gain in weight is a dry weight measure of the particulates present in the water sample expressed in units derived or calculated from the volume of water filtered (typically milligrams per litre or mg/L).'),
('2',	'nitrogen',	'1. Start program'),
('1',	'Ortophosphate',	'"Zero" the meter (if you are using one) using a reagent blank (distilled water plus the reagent powder) and following the manufacturer''s directions."'),
('1',	'Total suspended solids',	'TSS of a water or wastewater sample is determined by pouring a carefully measured volume of water (typically one litre; but less if the particulate density is high, or as much as two or three litres for very clean water) through a pre-weighed filter of a specified pore size, then weighing the filter again after the drying process that removes all water on the filter. Filters for TSS measurements are typically composed of glass fibres.[2] The gain in weight is a dry weight measure of the particulates present in the water sample expressed in units derived or calculated from the volume of water filtered (typically milligrams per litre or mg/L).'),
('1',	'nitrogen',	'1. Start program'),
('1',	'PH',	'The pH value can be measured using electrochemical measuring systems, litmus paper, or indicators and colorimeters. The easiest way to take a pH measurement is to use litmus paper or a colorimeter. The advantage of this type of pH measurement is that the pH range is well known and they are easy to apply.');
		

-- ------------------------------------------------------------------------------------------------
-- sample taken inserts, BarCode_Gen is populated as a result of the trigger
-- ------------------------------------------------------------------------------------------------

INSERT INTO `WESH`.`samples_taken`   (test_group_test_group_ID , operators_details_OperatorID, `sample time`)                  
select c.test_group_ID , d.operator_id, d.`sample time` 
from bishnu.samples_original as d 
inner join
(SELECT test_group_ID,  test_group_name
from   WESH.test_group ) AS c
 on LOWER( d.tests_to_run) = LOWER( c.test_group_name);
 
 -- ------------------------------------------------------------------------------------------------
-- analysis done
-- ------------------------------------------------------------------------------------------------
 INSERT INTO  WESH.analysis_done 
( operators_details_OperatorID,
 test_description_test_id,
 samples_taken_sample_ID,
 analysis_result,
 analysis_time)
SELECT 3 as operators_details,
b.test_ID as  test_description_test_id,
a.sample_id as  samples_taken_sample_ID,
a.analysis_result ,
a.analysis_time

FROM bishnu.analysis_original as a
inner join 
WESH.test_description as b 
ON a.test_name=b.test_name
WHERE b.test_group_test_group_ID =1;