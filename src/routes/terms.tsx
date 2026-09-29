import { createFileRoute } from '@tanstack/react-router';
import { InfoPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/terms')({ head: () => ({meta:[{title:'Terms | Lancerly'},{name:'description',content:'Explore terms on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Terms | Lancerly'},{property:'og:description',content:'Explore terms on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <InfoPage kind="terms"/> }
