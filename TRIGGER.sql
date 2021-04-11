use WESH;

create trigger generate_Bar_code after insert on `WESH`.`samples_taken`
for each row
  insert into `WESH`.`BarCode_Gen`  (  samples_taken_sample_ID )
  values ( new.sample_ID );