import { createFileRoute } from '@tanstack/react-router';
import { AuthPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/login')({ head: () => ({meta:[{title:'Login | Lancerly'},{name:'description',content:'Explore login on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Login | Lancerly'},{property:'og:description',content:'Explore login on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <AuthPage mode="login"/> }
