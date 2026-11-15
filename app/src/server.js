const { createApp }=require('./app'); const port=Number(process.env.PORT||3000); const server=createApp().listen(port,()=>console.log(`DeployBot app listening on ${port}`));
function stop(){server.close(()=>process.exit(0));setTimeout(()=>process.exit(1),5000).unref();} process.on('SIGTERM',stop);process.on('SIGINT',stop);
