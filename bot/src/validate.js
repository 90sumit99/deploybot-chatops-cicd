const VERSION_RE=/^v[0-9]+(\.[0-9]+){0,2}$/;
function isValidVersion(value){return VERSION_RE.test(value||'');}
function parseDeploy(text){const [version,flag]=text.trim().split(/\s+/);return {version,simulateFailure:flag==='broken',valid:isValidVersion(version) && (!flag || flag==='broken')};}
module.exports={VERSION_RE,isValidVersion,parseDeploy};
