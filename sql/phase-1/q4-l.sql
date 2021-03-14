/*create materialized view of Similarity Percentage*/
CREATE MATERIALIZED VIEW mat_view_similarity_percentage AS SELECT * FROM mytab; SELECT * FROM similarity_percentage;
