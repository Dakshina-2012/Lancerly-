import { createFileRoute } from '@tanstack/react-router';
import { MessagesPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/messages')({ head: () => ({meta:[{title:'Messages | Lancerly'},{name:'description',content:'Explore messages on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Messages | Lancerly'},{property:'og:description',content:'Explore messages on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <MessagesPage/> }
