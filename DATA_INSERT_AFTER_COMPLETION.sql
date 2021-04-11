-- ------------------------------------------------------------------------------------------------
-- Every time a new sample is taken, BarCode_Gen is populated as a result of the trigger
-- @test_group_name, @operator_name come as input from the website/app
------------------------------------------------------------------------------------------------

SELECT @test_group_id := test_group_id 
FROM   test_group 
WHERE  Lower(test_group_name) = Lower(@test_group_name); 

SELECT @operator_id := operatorid 
FROM   operators_details 
WHERE  Lower(operator_name) = Lower(@operator_name); 

INSERT INTO `wesh`.`samples_taken` 
            (test_group_test_group_id, 
             operators_details_operatorid, 
             `sample time`) 
SELECT @test_group_id, 
       @operator_id, 
       CURRENT_TIMESTAMP(); 

 -- ------------------------------------------------------------------------------------------------
-- INSERT a new row into analysis done, for each new test
-- @operator_name, @Bar_Code come as input from the website/app
-- ------------------------------------------------------------------------------------------------

-- SELECT @test_description_test_id :=  test_description_test_id from test_description where lower(test_name) = lower(@test_name)  
-- AND test_group_ID= SELECT test_group_ID FROM test_group where  lower(test_group_name) = lower(@test_group_name) ;


SELECT @operators_details_operatorid := operators_details_operatorid 
FROM   operators_details 
WHERE  Lower(operator_name) = Lower(@operator_name); 

CREATE temporary TABLE IF NOT EXISTS test_ids_table AS 
(SELECT DISTINCT d.test_id AS test_id 
FROM   test_description AS d 
INNER JOIN (SELECT a.*, 
	 b.* 
FROM   barcode_gen AS a 
	 INNER JOIN samples_taken AS b 
			 ON a.samples_taken_sample_id = b.sample_id 
WHERE  Lower(sample_bar_code) = Lower(@bar_code)) AS c 
ON c.test_group_test_group_id = d.test_group_test_group_id); 

SELECT @sample_id := samples_taken_sample_id 
FROM   barcode_gen 
WHERE  Lower(sample_bar_code) = Lower(@bar_code); 

INSERT INTO wesh.analysis_done 
(operators_details_operatorid, 
test_description_test_id, 
samples_taken_sample_id, 
analysis_result, 
analysis_time) 
SELECT @operators_details_operatorid, 
test_id, 
@sample_id, 
@analysis_result, 
CURRENT_TIMESTAMP() 
FROM   test_ids_table; 
