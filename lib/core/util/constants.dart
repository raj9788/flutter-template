enum Environment {
  dev,
  qa,
  prod,
}

String getAccessTokenUrl(Environment env) {
  switch (env) {
    case Environment.dev:
      return '';
    case Environment.qa:
      return '';
    case Environment.prod:
      return '';
  }
}

String getResetPasswordUrl(Environment env) {
  switch (env) {
    case Environment.dev:
      return '';
    case Environment.qa:
      return '';
    case Environment.prod:
      return '';
  }
}

String getBaseUrl(Environment env) {
  switch (env) {
    case Environment.dev:
      return '';
    case Environment.qa:
      return '';
    case Environment.prod:
      return '';
  }
}

String getdeployEnv(Environment env) {
  switch (env) {
    case Environment.dev:
      return 'DEV';
    case Environment.qa:
      return 'QA';
    case Environment.prod:
      return 'PROD';
  }
}

String getVapidKey(Environment env) {
  switch (env) {
    case Environment.dev:
      return '';
    case Environment.qa:
      return '';
    case Environment.prod:
      return '';
  }
}

const Environment env = Environment.dev;

final baseUrl = getBaseUrl(env);

final accessTokenUrl = getAccessTokenUrl(env);

final resetPasswordUrl = getResetPasswordUrl(env);

const String appVersion = '0.0.1';
final String deployEnv = getdeployEnv(env);

final String vapidKey = getVapidKey(env);
