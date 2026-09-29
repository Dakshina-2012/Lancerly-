import { createFileRoute } from '@tanstack/react-router';
import { Dashboard } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/dashboard')({ head: () => ({meta:[{title:'Dashboard | Lancerly'},{name:'description',content:'Explore dashboard on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Dashboard | Lancerly'},{property:'og:description',content:'Explore dashboard on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <Dashboard/> }
