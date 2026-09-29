import { createFileRoute } from '@tanstack/react-router';
import { SettingsPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/profile')({ head: () => ({meta:[{title:'Profile | Lancerly'},{name:'description',content:'Explore profile on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Profile | Lancerly'},{property:'og:description',content:'Explore profile on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <SettingsPage/> }
