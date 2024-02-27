CREATE OR REPLACE FUNCTION find_term_positions (text[])     
RETURNS text[] AS 
$$    
DECLARE    
	input_positions ALIAS FOR $1;
	positions text[];
	arr_length int := array_length(input_positions, 1);
	word_positions_array text[];
	word_counter int := 1;
	positions_to_remove text[];
	output_positions text[];
 BEGIN
 	FOR I IN 1..arr_length
  	LOOP
  		word_positions_array := string_to_array(input_positions[I], ' ');
 		positions := array_cat(positions, word_positions_array);
 	END LOOP;
 	positions = ARRAY(SELECT unnest(positions) ORDER BY 1);
 	
 	IF arr_length > 1 THEN
 	FOR I IN 1..(array_length(positions, 1)-1)
 	LOOP
 		IF (positions[I]::int +1) != positions[I+1]::int THEN
 			word_counter = 1;
 		ELSE 
 			word_counter = word_counter + 1;
 		END IF;
 		IF word_counter = arr_length THEN
 			output_positions = array_cat(output_positions, positions[(I-arr_length+1):(I+1)]);
 			word_counter = 1;
 		END IF;
 	END LOOP;
 	ELSE
 		output_positions = positions;
 	END IF;

RETURN output_positions;  
END;   
$$  LANGUAGE PLpgSQL;