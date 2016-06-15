CREATE TEMPORARY VIEW ml_sample AS
SELECT * FROM sample_assignments_generic WHERE sample_type=1;

CREATE TEMPORARY VIEW meta AS
SELECT * FROM 
(ml_sample INNER JOIN event_weights_generic USING (eid))
INNER JOIN 
event_labels_generic USING (eid);

CREATE TEMPORARY VIEW events AS
SELECT * FROM 
(meta INNER JOIN candidate_optimized_events_generic USING (eid))
INNER JOIN
candidate_optimized_events_scores_generic USING (eid);

\copy (SELECT * FROM events) TO 'event_features.csv' WITH CSV HEADER;
