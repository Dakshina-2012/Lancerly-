CREATE OR REPLACE FUNCTION public.is_freelancer(_user_id uuid) RETURNS boolean LANGUAGE sql STABLE SECURITY DEFINER SET search_path = public AS $$ SELECT EXISTS (SELECT 1 FROM public.user_roles WHERE user_id = _user_id AND role = 'freelancer') $$;
DROP POLICY IF EXISTS profiles_public_read ON public.profiles;
CREATE POLICY profiles_member_read ON public.profiles FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY profiles_freelancer_public_read ON public.profiles FOR SELECT TO anon USING (public.is_freelancer(id));
DROP POLICY IF EXISTS reviews_public_read ON public.reviews;
CREATE POLICY reviews_member_read ON public.reviews FOR SELECT TO authenticated USING (auth.uid() IS NOT NULL);
CREATE POLICY reviews_freelancer_public_read ON public.reviews FOR SELECT TO anon USING (public.is_freelancer(freelancer_id));