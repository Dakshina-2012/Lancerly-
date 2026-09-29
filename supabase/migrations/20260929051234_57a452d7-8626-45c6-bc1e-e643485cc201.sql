CREATE TABLE public.profiles (id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE, full_name text NOT NULL DEFAULT '', avatar_url text, location text, headline text, bio text, skills text[] NOT NULL DEFAULT '{}', hourly_rate integer, availability text NOT NULL DEFAULT 'available', company_name text, created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now());
GRANT SELECT, INSERT, UPDATE, DELETE ON public.profiles TO authenticated; GRANT SELECT ON public.profiles TO anon; GRANT ALL ON public.profiles TO service_role;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY profiles_public_read ON public.profiles FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY profiles_own_insert ON public.profiles FOR INSERT TO authenticated WITH CHECK (id = auth.uid());
CREATE POLICY profiles_own_update ON public.profiles FOR UPDATE TO authenticated USING (id = auth.uid()) WITH CHECK (id = auth.uid());
CREATE TABLE public.user_roles (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE, role text NOT NULL CHECK (role IN ('client','freelancer')), UNIQUE(user_id,role));
GRANT SELECT, INSERT ON public.user_roles TO authenticated; GRANT ALL ON public.user_roles TO service_role;
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;
CREATE POLICY roles_self_read ON public.user_roles FOR SELECT TO authenticated USING (user_id = auth.uid());
CREATE POLICY roles_self_insert ON public.user_roles FOR INSERT TO authenticated WITH CHECK (user_id = auth.uid() AND role IN ('client','freelancer') AND NOT EXISTS (SELECT 1 FROM public.user_roles r WHERE r.user_id = auth.uid()));
CREATE TABLE public.projects (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), client_id uuid REFERENCES public.profiles(id) ON DELETE SET NULL, client_name text NOT NULL DEFAULT 'Lancerly client', title text NOT NULL, description text NOT NULL, category text NOT NULL, skills text[] NOT NULL DEFAULT '{}', budget_min integer NOT NULL DEFAULT 0, budget_max integer NOT NULL DEFAULT 0, budget_type text NOT NULL DEFAULT 'fixed', experience_level text NOT NULL DEFAULT 'Intermediate', deadline date, status text NOT NULL DEFAULT 'open', location text NOT NULL DEFAULT 'Remote', created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now());
GRANT SELECT ON public.projects TO anon; GRANT SELECT, INSERT, UPDATE, DELETE ON public.projects TO authenticated; GRANT ALL ON public.projects TO service_role;
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
CREATE POLICY projects_open_read ON public.projects FOR SELECT TO anon, authenticated USING (status = 'open');
CREATE POLICY projects_owner_read ON public.projects FOR SELECT TO authenticated USING (client_id = auth.uid());
CREATE POLICY projects_owner_insert ON public.projects FOR INSERT TO authenticated WITH CHECK (client_id = auth.uid() AND EXISTS (SELECT 1 FROM public.user_roles WHERE user_id = auth.uid() AND role = 'client'));
CREATE POLICY projects_owner_update ON public.projects FOR UPDATE TO authenticated USING (client_id = auth.uid()) WITH CHECK (client_id = auth.uid());
CREATE POLICY projects_owner_delete ON public.projects FOR DELETE TO authenticated USING (client_id = auth.uid());
CREATE TABLE public.proposals (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), project_id uuid NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE, freelancer_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, cover_letter text NOT NULL, proposed_budget integer NOT NULL, delivery_days integer NOT NULL, status text NOT NULL DEFAULT 'pending', created_at timestamptz NOT NULL DEFAULT now(), updated_at timestamptz NOT NULL DEFAULT now(), UNIQUE(project_id,freelancer_id));
GRANT SELECT, INSERT, UPDATE ON public.proposals TO authenticated; GRANT ALL ON public.proposals TO service_role;
ALTER TABLE public.proposals ENABLE ROW LEVEL SECURITY;
CREATE POLICY proposals_parties_read ON public.proposals FOR SELECT TO authenticated USING (freelancer_id = auth.uid() OR EXISTS (SELECT 1 FROM public.projects p WHERE p.id = project_id AND p.client_id = auth.uid()));
CREATE POLICY proposals_freelancer_insert ON public.proposals FOR INSERT TO authenticated WITH CHECK (freelancer_id = auth.uid() AND EXISTS (SELECT 1 FROM public.user_roles WHERE user_id = auth.uid() AND role = 'freelancer') AND EXISTS (SELECT 1 FROM public.projects p WHERE p.id = project_id AND p.status = 'open'));
CREATE POLICY proposals_client_update ON public.proposals FOR UPDATE TO authenticated USING (EXISTS (SELECT 1 FROM public.projects p WHERE p.id = project_id AND p.client_id = auth.uid())) WITH CHECK (EXISTS (SELECT 1 FROM public.projects p WHERE p.id = project_id AND p.client_id = auth.uid()));
CREATE TABLE public.saved_items (user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, project_id uuid REFERENCES public.projects(id) ON DELETE CASCADE, freelancer_id uuid REFERENCES public.profiles(id) ON DELETE CASCADE, created_at timestamptz NOT NULL DEFAULT now(), CHECK ((project_id IS NOT NULL) <> (freelancer_id IS NOT NULL))); 
GRANT SELECT, INSERT, DELETE ON public.saved_items TO authenticated; GRANT ALL ON public.saved_items TO service_role;
ALTER TABLE public.saved_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY saved_self ON public.saved_items FOR ALL TO authenticated USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());
CREATE TABLE public.messages (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), sender_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, receiver_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, content text NOT NULL, read_at timestamptz, created_at timestamptz NOT NULL DEFAULT now());
GRANT SELECT, INSERT, UPDATE ON public.messages TO authenticated; GRANT ALL ON public.messages TO service_role;
ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;
CREATE POLICY messages_parties_read ON public.messages FOR SELECT TO authenticated USING (sender_id = auth.uid() OR receiver_id = auth.uid());
CREATE POLICY messages_sender_insert ON public.messages FOR INSERT TO authenticated WITH CHECK (sender_id = auth.uid());
CREATE POLICY messages_receiver_update ON public.messages FOR UPDATE TO authenticated USING (receiver_id = auth.uid()) WITH CHECK (receiver_id = auth.uid());
CREATE TABLE public.notifications (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), user_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, message text NOT NULL, link text, read_at timestamptz, created_at timestamptz NOT NULL DEFAULT now());
GRANT SELECT, UPDATE ON public.notifications TO authenticated; GRANT ALL ON public.notifications TO service_role;
ALTER TABLE public.notifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY notifications_self_read ON public.notifications FOR SELECT TO authenticated USING (user_id = auth.uid());
CREATE POLICY notifications_self_update ON public.notifications FOR UPDATE TO authenticated USING (user_id = auth.uid()) WITH CHECK (user_id = auth.uid());
CREATE TABLE public.reviews (id uuid PRIMARY KEY DEFAULT gen_random_uuid(), project_id uuid NOT NULL REFERENCES public.projects(id) ON DELETE CASCADE, client_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, freelancer_id uuid NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE, rating integer NOT NULL CHECK (rating BETWEEN 1 AND 5), content text NOT NULL, created_at timestamptz NOT NULL DEFAULT now(), UNIQUE(project_id,freelancer_id));
GRANT SELECT ON public.reviews TO anon; GRANT SELECT, INSERT ON public.reviews TO authenticated; GRANT ALL ON public.reviews TO service_role;
ALTER TABLE public.reviews ENABLE ROW LEVEL SECURITY;
CREATE POLICY reviews_public_read ON public.reviews FOR SELECT TO anon, authenticated USING (true);
CREATE POLICY reviews_client_insert ON public.reviews FOR INSERT TO authenticated WITH CHECK (client_id = auth.uid() AND EXISTS (SELECT 1 FROM public.projects p WHERE p.id = project_id AND p.client_id = auth.uid() AND p.status = 'completed') AND EXISTS (SELECT 1 FROM public.proposals q WHERE q.project_id = project_id AND q.freelancer_id = freelancer_id AND q.status = 'accepted'));
CREATE OR REPLACE FUNCTION public.touch_updated_at() RETURNS trigger LANGUAGE plpgsql SET search_path = public AS $$ BEGIN NEW.updated_at = now(); RETURN NEW; END $$;
CREATE TRIGGER profiles_touch BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();
CREATE TRIGGER projects_touch BEFORE UPDATE ON public.projects FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();
CREATE TRIGGER proposals_touch BEFORE UPDATE ON public.proposals FOR EACH ROW EXECUTE FUNCTION public.touch_updated_at();
CREATE OR REPLACE FUNCTION public.create_member_profile() RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER SET search_path = public AS $$ BEGIN INSERT INTO public.profiles(id,full_name) VALUES (NEW.id,COALESCE(NEW.raw_user_meta_data->>'full_name','')); INSERT INTO public.user_roles(user_id,role) VALUES (NEW.id, CASE WHEN NEW.raw_user_meta_data->>'role' = 'client' THEN 'client' ELSE 'freelancer' END); RETURN NEW; END $$;
CREATE TRIGGER member_created AFTER INSERT ON auth.users FOR EACH ROW EXECUTE FUNCTION public.create_member_profile();
INSERT INTO public.projects (client_name,title,description,category,skills,budget_min,budget_max,budget_type,experience_level,deadline,created_at) VALUES
('Northstar Studio','Design a thoughtful fintech dashboard','We are looking for a product designer to create a clear, intuitive analytics dashboard for a growing financial platform. Deliverables include flows, high-fidelity screens, and a handoff-ready design system.','Design',ARRAY['Figma','UI/UX','Design Systems'],45000,75000,'fixed','Expert',CURRENT_DATE + 24,now() - interval '2 hours'),
('Arc & Co.','Build a modern e-commerce storefront','Create a fast, responsive shopping experience with product discovery, checkout integration, and a polished mobile experience.','Web Development',ARRAY['React','TypeScript','Shopify'],60000,110000,'fixed','Intermediate',CURRENT_DATE + 32,now() - interval '6 hours'),
('Goodkind Health','Create a brand identity for a wellness startup','Develop a versatile visual identity including logo direction, color system, typography, and social templates.','Design',ARRAY['Branding','Illustrator','Identity'],25000,45000,'fixed','Intermediate',CURRENT_DATE + 18,now() - interval '1 day'),
('Meridian Labs','Python automation for research workflows','Build reliable scripts to collect, clean, and report data from several internal sources. Documentation and clear handover required.','Data Science',ARRAY['Python','Pandas','Automation'],35000,65000,'fixed','Expert',CURRENT_DATE + 21,now() - interval '1 day'),
('Paperplane Media','Write compelling SaaS website copy','Help us sharpen our messaging across our homepage, product pages, and onboarding emails.','Writing',ARRAY['Copywriting','SaaS','SEO'],12000,28000,'fixed','Intermediate',CURRENT_DATE + 14,now() - interval '2 days'),
('Brightside Digital','Launch a performance marketing campaign','Plan and execute a measurable paid acquisition strategy for a new consumer brand.','Marketing',ARRAY['Google Ads','Analytics','Strategy'],30000,55000,'fixed','Expert',CURRENT_DATE + 30,now() - interval '3 days');