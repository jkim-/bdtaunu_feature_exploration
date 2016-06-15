CREATE TEMPORARY VIEW meta AS
SELECT * FROM 
(sample_assignments_generic INNER JOIN event_weights_generic USING (eid))
INNER JOIN 
event_labels_generic USING (eid);

CREATE TEMPORARY VIEW events AS
SELECT * FROM 
(meta INNER JOIN candidate_optimized_events_generic USING (eid))
INNER JOIN
candidate_optimized_events_scores_generic USING eid;

EXPLAIN SELECT * FROM events;

--\copy (SELECT * FROM F) TO 'event_features.csv' WITH CSV HEADER;

/*CREATE TEMPORARY VIEW E AS
SELECT 
    eid,
    ny, 
    ntrk,
    r2,
    rf_useopt_score,
    rf_dvsdstar_sigmc_score,
    event_weight,
    mc_evttype,
    bad,
    data_source,
    ml_sample
FROM (McEvent INNER JOIN EventMetaData USING (eid));

CREATE TEMPORARY VIEW C AS
SELECT *
FROM McCandidate INNER JOIN OptCandidateIdx USING (eid, idx);

CREATE TEMPORARY VIEW F AS
SELECT 
    ny,
    ntrk,
    r2,
    cand_score,
    mmiss_prime2,
    eextra50,
    costhetat,
    tag_lp3,
    tag_cosby,
    tag_costhetadl,
    tag_dmass,
    tag_deltam,
    tag_costhetadsoft,
    tag_softp3magcm,
    sig_hp3,
    sig_cosby,
    sig_costhetadtau,
    sig_vtxb,
    sig_dmass,
    sig_deltam,
    sig_costhetadsoft,
    sig_softp3magcm,
    sig_hmass,
    sig_vtxh,
    tag_dtype,
    tag_dstartype,
    sig_dtype,
    sig_dstartype,
    tag_l_epid,
    tag_l_mupid,
    sig_h_epid,
    sig_h_mupid,
    rf_useopt_score,
    rf_dvsdstar_sigmc_score,
    event_weight,
    mc_evttype
FROM E INNER JOIN C USING (eid)
WHERE
    bad=0 AND
    data_source>1 AND 
    ml_sample=1
;

\copy (SELECT * FROM F) TO 'event_features.csv' WITH CSV HEADER;
*/
