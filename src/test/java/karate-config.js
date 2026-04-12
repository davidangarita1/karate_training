function fn() {
  var DotEnv = Java.type('io.github.cdimascio.dotenv.Dotenv');
  var dotenv = DotEnv.configure().ignoreIfMissing().load();
  
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    env: env,
    myVarName: 'someValue',
    apiKey: java.lang.System.getenv('API_KEY') || dotenv.get('API_KEY') || 'default-key'
  }
  if (env == 'dev') {
    // customize
    // e.g. config.foo = 'bar';
  } else if (env == 'e2e') {
    // customize
  }
  return config;
}