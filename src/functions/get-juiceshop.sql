CREATE OR REPLACE FUNCTION public.get_juiceShop_byId(p_id integer)
RETURNS TABLE(id integer, name text, location text, description text)
LANGUAGE sql
AS $$
    SELECT id, name, location, description
    FROM public.juiceshops
    WHERE id = p_id;
$$;