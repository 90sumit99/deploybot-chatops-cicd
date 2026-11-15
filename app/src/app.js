const express = require('express'); const os = require('os'); const { page } = require('./views/page'); const { createMetrics } = require('./metrics');
function createApp(config = {}) {
  const version = config.version || process.env.APP_VERSION || 'dev'; const failHealth = config.failHealth ?? (process.env.FAIL_HEALTH === 'true'); const startedAt = config.startedAt || new Date().toISOString(); const hostname = config.hostname || os.hostname(); const app = express(); const metrics = createMetrics(version);
  app.use((req,res,next)=>{ const start=process.hrtime.bigint(); res.on('finish',()=>{const ms=Number(process.hrtime.bigint()-start)/1e6; const route=req.route?.path || req.path; metrics.requests.inc({method:req.method,route,status:String(res.statusCode)}); metrics.duration.observe({method:req.method,route,status:String(res.statusCode)},ms/1000); console.log(JSON.stringify({ts:new Date().toISOString(),method:req.method,path:req.path,status:res.statusCode,ms:Math.round(ms)}));}); next(); });
  app.get('/',(req,res)=>res.type('html').send(page(version,hostname,startedAt)));
  app.get('/health',(req,res)=>res.status(failHealth?503:200).json({status:failHealth?'unhealthy':'ok',version}));
  app.get('/version',(req,res)=>res.json({version,startedAt,uptimeSeconds:Math.floor(process.uptime()),hostname}));
  app.get('/metrics',async(req,res)=>{res.set('Content-Type',metrics.registry.contentType);res.send(await metrics.registry.metrics());});
  app.use((req,res)=>res.status(404).json({error:'not found'})); return app;
}
module.exports={createApp};
