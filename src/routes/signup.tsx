import { createFileRoute } from '@tanstack/react-router';
import { AuthPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/signup')({ head: () => ({meta:[{title:'Signup | Lancerly'},{name:'description',content:'Explore signup on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Signup | Lancerly'},{property:'og:description',content:'Explore signup on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <AuthPage mode="signup"/> }
