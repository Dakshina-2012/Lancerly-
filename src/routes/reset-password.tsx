import { createFileRoute } from '@tanstack/react-router';
import { AuthPage } from '@/components/marketplace/Pages';
export const Route = createFileRoute('/reset-password')({ head: () => ({meta:[{title:'Reset Password | Lancerly'},{name:'description',content:'Explore reset password on Lancerly, the independent work marketplace.'},{property:'og:title',content:'Reset Password | Lancerly'},{property:'og:description',content:'Explore reset password on Lancerly.'},{property:'og:type',content:'website'},{name:'twitter:card',content:'summary_large_image'}]}), component: Page });
function Page() { return <AuthPage mode="reset"/> }
