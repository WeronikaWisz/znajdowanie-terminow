DELETE FROM
    terms a
        USING terms b
WHERE
    a.id < b.id
    AND a.name = b.name;