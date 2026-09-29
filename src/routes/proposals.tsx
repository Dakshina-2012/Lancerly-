import { createFileRoute } from '@tanstack/react-router';
import { ProposalsPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/proposals')({ head: () => ({meta:[{title:'Proposals | Lancerly'},{name:'description',content:'Explore proposals on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Proposals | Lancerly'},{property:'og:description',content:'Explore proposals on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <ProposalsPage/> }
