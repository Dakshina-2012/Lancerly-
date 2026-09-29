import { createFileRoute } from '@tanstack/react-router';
import { InfoPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/help')({ head: () => ({meta:[{title:'Help | Lancerly'},{name:'description',content:'Explore help on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Help | Lancerly'},{property:'og:description',content:'Explore help on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <InfoPage kind="help"/> }
