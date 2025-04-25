import { createClient } from '@/utils/supabase/server'

export default async function TestPage() {
  const supabase = createClient()

  const { data: healthCheck } = await supabase.from('_health').select('*')

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold mb-4">Supabase Connection Test</h1>
      <pre className="bg-gray-100 p-4 rounded">
        {JSON.stringify(healthCheck, null, 2)}
      </pre>
    </div>
  )
}
