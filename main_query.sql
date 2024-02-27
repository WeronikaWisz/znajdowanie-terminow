WITH doc AS (SELECT to_tsvector('english', 'text that we want to search for terms in') AS vector)
SELECT id, find_term_positions(array_agg(array_to_string(positions, ' '))) as term_positions FROM terms, doc 
CROSS JOIN unnest(doc.vector) u(lexeme, positions, weights)
WHERE doc.vector @@ terms.query 
AND lexeme = ANY(array_remove(string_to_array(terms.query::varchar, ''''), ''))
GROUP BY id;