import { createFileRoute } from '@tanstack/react-router';
import { InfoPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/privacy')({ head: () => ({meta:[{title:'Privacy | Lancerly'},{name:'description',content:'Explore privacy on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Privacy | Lancerly'},{property:'og:description',content:'Explore privacy on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <InfoPage kind="privacy"/> }
