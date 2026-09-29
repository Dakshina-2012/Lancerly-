import { createFileRoute } from '@tanstack/react-router';
import { InfoPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/contact')({ head: () => ({meta:[{title:'Contact | Lancerly'},{name:'description',content:'Explore contact on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Contact | Lancerly'},{property:'og:description',content:'Explore contact on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <InfoPage kind="contact"/> }
