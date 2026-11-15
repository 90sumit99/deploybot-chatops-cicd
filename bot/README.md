# DeployBot Telegram bot

Copy `.env.example` to `.env`, fill the Telegram token, authorised chat ID, and Jenkins API token. Run `npm ci && npm test`, then `npm start`. For offline REST-client development, run `npm run mock-jenkins` and point `JENKINS_URL` to `http://localhost:8089`.
