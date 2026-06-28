export default { fetch: async (request, env, ctx) => {
  const url = new URL(request.url)
  const respond = async (body, init = 200, headers = {}) => new Response(JSON.stringify(body), { status: init, headers: { 'content-type': 'application/json', 'access-control-allow-origin': '*', 'access-control-allow-methods': 'GET,POST,OPTIONS', 'access-control-allow-headers': 'content-type,authorization', ...headers } })
  if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: { 'access-control-allow-origin': '*', 'access-control-allow-methods': 'GET,POST,OPTIONS', 'access-control-allow-headers': 'content-type,authorization' } })
  if (/^\/health$/.test(url.pathname)) return await respond({ status: 'ok', app: env.APP_NAME || 'api-changelog-radar' })
  if (/^\/api\/v1\/plans$/.test(url.pathname)) return await respond({ plans: [{ key: 'starter', name: 'Starter', price_monthly: 39, max_sources: 5, retention_days: 30 }, { key: 'growth', name: 'Growth', price_monthly: 149, max_sources: 25, retention_days: 90 }, { key: 'scale', name: 'Scale', price_monthly: 499, max_sources: 200, retention_days: 365 }] })
  return await respond({ error: 'Not found' }, 404)
} }
