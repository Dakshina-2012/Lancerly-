import { createFileRoute } from '@tanstack/react-router';
import { PostProject } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/post-project')({ head: () => ({meta:[{title:'Post Project | Lancerly'},{name:'description',content:'Explore post project on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Post Project | Lancerly'},{property:'og:description',content:'Explore post project on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <PostProject/> }
