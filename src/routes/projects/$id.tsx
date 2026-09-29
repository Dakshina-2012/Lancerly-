import { createFileRoute } from '@tanstack/react-router';
import { ProjectDetail } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/projects/$id')({ head: () => ({meta:[{title:'Projects | Lancerly'},{name:'description',content:'Explore projects on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Projects | Lancerly'},{property:'og:description',content:'Explore projects on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <ProjectDetail id={Route.useParams().id}/> }
