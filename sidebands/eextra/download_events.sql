-- MC
CREATE TEMPORARY VIEW mc_explore AS 
SELECT * FROM sample_assignments_generic WHERE sample_type=1;

-- remember to multiply weights by 25 in the following tables

CREATE TEMPORARY TABLE mc_weight_tbl AS TABLE event_weights_generic;
UPDATE mc_weight_tbl SET weight = weight*25;

CREATE TEMPORARY VIEW sideband_mc AS
SELECT * FROM
sideband_generic INNER JOIN event_labels_generic_augmented USING (eid) WHERE sideband_generic.eextra_sideband = 1;

CREATE TEMPORARY VIEW mc_meta AS
SELECT * FROM
((mc_explore INNER JOIN sideband_mc USING (eid))
INNER JOIN 
mc_weight_tbl USING (eid))
INNER JOIN
event_weights_generic_augmented USING (eid);

CREATE TEMPORARY VIEW mc AS
SELECT * FROM 
(mc_meta INNER JOIN candidate_optimized_events_scores_generic_t USING (eid))
INNER JOIN 
candidate_optimized_events_generic USING (eid);

\copy (SELECT * FROM mc) TO 'mc_sideband.csv' WITH CSV HEADER;

-- Sideband Data
CREATE TEMPORARY VIEW sideband AS
SELECT * FROM
sideband_data INNER JOIN event_labels_data USING (eid) WHERE sideband_data.eextra_sideband = 1;

-- Onpeak Data
CREATE TEMPORARY VIEW onpeak_data_meta AS 
SELECT * FROM 
sideband WHERE sideband.mode_label = 1;

CREATE TEMPORARY VIEW onpeak_data AS
SELECT * FROM
(onpeak_data_meta INNER JOIN candidate_optimized_events_scores_data_t USING (eid))
INNER JOIN 
candidate_optimized_events_data USING (eid);

\copy (SELECT * FROM onpeak_data) TO 'onpeak_data_sideband.csv' WITH CSV HEADER;

-- Offpeak Data

CREATE TEMPORARY VIEW offpeak_data_meta AS 
SELECT * FROM 
sideband WHERE sideband.mode_label = 0;

CREATE TEMPORARY VIEW offpeak_data AS
SELECT * FROM
(offpeak_data_meta INNER JOIN candidate_optimized_events_scores_data_t USING (eid))
INNER JOIN 
candidate_optimized_events_data USING (eid);

\copy (SELECT * FROM offpeak_data) TO 'offpeak_data_sideband.csv' WITH CSV HEADER;
