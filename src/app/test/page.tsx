import { supabase } from '@/lib/supabase'

export default async function TestPage() {
  const { data: healthCheck } = await supabase
    .from('users')
    .select('*')
    .limit(1)
  return (
    <div>
      <h1>Test Page</h1>
      <pre>{JSON.stringify(healthCheck, null, 2)}</pre>
    </div>
  )
}
