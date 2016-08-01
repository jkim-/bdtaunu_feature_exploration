CREATE TEMPORARY VIEW ml_sample AS
SELECT * FROM sample_assignments_generic WHERE sample_type=1;

CREATE TEMPORARY VIEW meta AS
SELECT * FROM 
(ml_sample INNER JOIN event_weights_generic USING (eid))
INNER JOIN 
event_labels_generic_augmented USING (eid);

CREATE TEMPORARY VIEW events AS
SELECT * FROM 
(meta INNER JOIN candidate_optimized_events_generic USING (eid))
INNER JOIN
(SELECT * 
 FROM candidate_optimized_events_scores_generic_t 
 WHERE (logit_logre_signal_score IS NOT NULL) AND
       (logit_gbdt300_signal_score IS NOT NULL) AND
       (logit_logre_dstartau_score IS NOT NULL) AND
       (logit_gbdt300_dstartau_score IS NOT NULL)) AS Q
USING (eid);

\copy (SELECT * FROM events) TO 'event_features.csv' WITH CSV HEADER;
