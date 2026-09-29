import { createFileRoute } from '@tanstack/react-router';
import { TalentPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/freelancers')({ head: () => ({meta:[{title:'Freelancers | Lancerly'},{name:'description',content:'Explore freelancers on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Freelancers | Lancerly'},{property:'og:description',content:'Explore freelancers on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <TalentPage/> }
