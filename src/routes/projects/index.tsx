import { createFileRoute } from '@tanstack/react-router';
import { ProjectsPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/projects/')({ head: () => ({meta:[{title:'Projects | Lancerly'},{name:'description',content:'Explore projects on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Projects | Lancerly'},{property:'og:description',content:'Explore projects on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <ProjectsPage initialQuery={(Route.useSearch() as {q?:string}).q || ""} initialCategory={(Route.useSearch() as {category?:string}).category || ""}/> }
