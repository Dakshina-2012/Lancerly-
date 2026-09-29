import { createFileRoute } from '@tanstack/react-router';
import { SubmitProposal } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/submit-proposal/$projectId')({ head: () => ({meta:[{title:'Submit Proposal | Lancerly'},{name:'description',content:'Explore submit proposal on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Submit Proposal | Lancerly'},{property:'og:description',content:'Explore submit proposal on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <SubmitProposal id={Route.useParams().projectId}/> }
