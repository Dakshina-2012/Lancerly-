import { supabase } from '@/integrations/supabase/client';

export type Project = { id: string; client_id: string | null; client_name: string; title: string; description: string; category: string; skills: string[]; budget_min: number; budget_max: number; budget_type: string; experience_level: string; deadline: string | null; status: string; location: string; created_at: string };
export type Profile = { id: string; full_name: string; avatar_url: string | null; headline: string | null; bio: string | null; skills: string[]; hourly_rate: number | null; location: string | null; availability: string; company_name: string | null };
export type Proposal = { id: string; project_id: string; freelancer_id: string; cover_letter: string; proposed_budget: number; delivery_days: number; status: string; created_at: string };
export async function projects() { const { data, error } = await supabase.from('projects').select('*').order('created_at', { ascending: false }); if (error) throw error; return data as Project[]; }
export async function profiles() { const { data, error } = await supabase.from('profiles').select('*').not('headline','is',null).order('created_at', { ascending: false }); if (error) throw error; return data as Profile[]; }
export async function currentRole(id: string) { const { data } = await supabase.from('user_roles').select('role').eq('user_id',id).maybeSingle(); return data?.role || 'freelancer'; }
export const money = (amount: number) => `₹${amount.toLocaleString('en-IN')}`;
export const budget = (p: Project) => `${money(p.budget_min)} – ${money(p.budget_max)}${p.budget_type === 'hourly' ? '/hr' : ''}`;
export const categories = ['Web Development','Mobile Development','Design','Writing','Marketing','Data Science','AI/ML','Video','Business'];
