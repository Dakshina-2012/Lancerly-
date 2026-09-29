import { createFileRoute } from '@tanstack/react-router';
import { SavedPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/saved')({ head: () => ({meta:[{title:'Saved | Lancerly'},{name:'description',content:'Explore saved on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Saved | Lancerly'},{property:'og:description',content:'Explore saved on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <SavedPage/> }
