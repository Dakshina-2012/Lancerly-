import { createFileRoute } from '@tanstack/react-router';
import { Dashboard } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/my-projects')({ head: () => ({meta:[{title:'My Projects | Lancerly'},{name:'description',content:'Explore my projects on Lancerly, the independent work marketplace.'},{property:'og:title',content:'My Projects | Lancerly'},{property:'og:description',content:'Explore my projects on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <Dashboard/> }
