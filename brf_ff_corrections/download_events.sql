-- MC
CREATE TEMPORARY VIEW mc_explore AS 
SELECT * FROM sample_assignments_generic WHERE sample_type=1;

CREATE TEMPORARY TABLE mc_weight_tbl AS TABLE event_weights_generic;
UPDATE mc_weight_tbl SET weight = weight*0.25;

CREATE TEMPORARY VIEW mc_meta AS
SELECT * FROM
((mc_explore INNER JOIN event_labels_generic USING (eid))
INNER JOIN 
mc_weight_tbl USING (eid))
INNER JOIN
event_weights_generic_augmented USING (eid);

CREATE TEMPORARY VIEW mc AS
SELECT * FROM 
(mc_meta INNER JOIN candidate_optimized_events_scores_generic USING (eid))
INNER JOIN 
candidate_optimized_events_generic USING (eid);

\copy (SELECT * FROM mc) TO 'mc.csv' WITH CSV HEADER;

-- Onpeak Data
CREATE TEMPORARY VIEW onpeak_data_meta AS 
SELECT * FROM 
unblinded_control_data INNER JOIN event_labels_data USING (eid) WHERE event_labels_data.mode_label = 1;

CREATE TEMPORARY VIEW onpeak_data AS
SELECT * FROM
(onpeak_data_meta INNER JOIN candidate_optimized_events_scores_data USING (eid))
INNER JOIN 
candidate_optimized_events_data USING (eid);

\copy (SELECT * FROM onpeak_data) TO 'onpeak_data.csv' WITH CSV HEADER;

-- Offpeak Data
CREATE TEMPORARY VIEW offpeak_data_meta AS 
SELECT * FROM 
(SELECT eid FROM framework_ntuples_data WHERE mode_label=0) AS a 
INNER JOIN event_labels_data USING (eid);

CREATE TEMPORARY VIEW offpeak_data AS
SELECT * FROM
(offpeak_data_meta INNER JOIN candidate_optimized_events_scores_data USING (eid))
INNER JOIN 
candidate_optimized_events_data USING (eid);

\copy (SELECT * FROM offpeak_data) TO 'offpeak_data.csv' WITH CSV HEADER;
