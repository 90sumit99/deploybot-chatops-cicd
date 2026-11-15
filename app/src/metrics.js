const client = require('prom-client');
function createMetrics(version) {
  const registry = new client.Registry(); client.collectDefaultMetrics({ register: registry });
  const requests = new client.Counter({ name: 'http_requests_total', help: 'HTTP requests', labelNames: ['method','route','status'], registers: [registry] });
  const duration = new client.Histogram({ name: 'http_request_duration_seconds', help: 'HTTP request duration', labelNames: ['method','route','status'], registers: [registry] });
  new client.Gauge({ name: 'app_info', help: 'Application info', labelNames: ['version'], registers: [registry] }).set({ version }, 1);
  return { registry, requests, duration };
}
module.exports = { createMetrics };
