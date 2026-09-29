import { createFileRoute } from '@tanstack/react-router';
import { SettingsPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/settings')({ head: () => ({meta:[{title:'Settings | Lancerly'},{name:'description',content:'Explore settings on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Settings | Lancerly'},{property:'og:description',content:'Explore settings on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <SettingsPage/> }
