import { createFileRoute } from '@tanstack/react-router';
import { InfoPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/about')({ head: () => ({meta:[{title:'About | Lancerly'},{name:'description',content:'Explore about on Lancerly, the independent work marketplace.'},{property:'og:title',content:'About | Lancerly'},{property:'og:description',content:'Explore about on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <InfoPage kind="about"/> }
