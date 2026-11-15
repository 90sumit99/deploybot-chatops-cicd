function page(version, hostname, startedAt) { let hash=0; for (const c of version) hash=((hash<<5)-hash)+c.charCodeAt(0); const hue=Math.abs(hash)%360; return `<!doctype html><html><body style="font-family:Arial;background:hsl(${hue},70%,90%);padding:4rem"><h1>Hello from DeployBot ${version}</h1><p>Host: ${hostname}</p><p>Started: ${startedAt}</p></body></html>`; }
module.exports = { page };
