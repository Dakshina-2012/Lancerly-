import { createFileRoute } from '@tanstack/react-router';
import { NotificationsPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/notifications')({ head: () => ({meta:[{title:'Notifications | Lancerly'},{name:'description',content:'Explore notifications on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Notifications | Lancerly'},{property:'og:description',content:'Explore notifications on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <NotificationsPage/> }
