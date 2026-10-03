DROP POLICY IF EXISTS profiles_member_read ON public.profiles;
CREATE POLICY profiles_member_read ON public.profiles FOR SELECT TO authenticated USING (is_freelancer(id) OR id = auth.uid());

DROP POLICY IF EXISTS reviews_member_read ON public.reviews;
CREATE POLICY reviews_member_read ON public.reviews FOR SELECT TO authenticated USING (is_freelancer(freelancer_id) OR client_id = auth.uid() OR freelancer_id = auth.uid());