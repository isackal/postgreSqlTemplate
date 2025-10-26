-- Illustrates how to make reusable queries in the database
CREATE OR REPLACE FUNCTION get_juiceShopComments(p_juiceShopId INT)
RETURNS TABLE (
    createdAt TIMESTAMP,
    userName TEXT,
    comment TEXT
)
LANGUAGE sql
AS $$
    SELECT jsc.createdAt, u.username AS userName, jsc.comment
    FROM JuiceShopComment jsc
    JOIN Users u ON jsc.userId = u.id
    WHERE jsc.juiceShopId = p_juiceShopId
    ORDER BY jsc.createdAt DESC;
$$;
