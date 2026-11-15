function result(build,url,tail=''){return `${build.result==='SUCCESS'?'✅':'❌'} build #${build.number}: ${build.result} (${Math.round(build.duration/1000)}s)\n${url}${tail?`\n${tail}`:''}`;}
module.exports={result};
