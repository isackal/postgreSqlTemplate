CREATE OR REPLACE FUNCTION public.create_juiceShopComment(
    p_juiceShopId integer,
    p_userId integer,
    p_commentText text
)
-- Only return created id
RETURNS integer
LANGUAGE sql
AS $$
    INSERT INTO JuiceShopComment (juiceShopId, userId, comment)
    VALUES (p_juiceShopId, p_userId, p_commentText)
    RETURNING id;
$$;