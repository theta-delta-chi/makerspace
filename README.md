# TDC Makerspace Emergency System
This code powers the server managing the Makerspace emergency system.  [Here's a demo](https://youtu.be/eXu26cHRDBs) of what the system does.

## Managing the Web Server
The Makerspace Rails server is hosted by MIT within the TDC locker.  Assuming you have access rights to said locker, these steps will get you into the environment.

1. SSH into Athena with `ssh <kerberos>@athena.dialup.mit.edu`
2. `cd /mit/tdc/web_scripts/makerspace`
3. `ssh -k tdc@scripts` - This step is necessary in order to get access to critical Rails commands like `rake`, which otherwise aren't available.

After following those steps, you'll be inside the repository and able to manage it.  Some useful commands:

- `bundle install --path vendor/bundle` - We're not allowed to install globally install packages on the MIT system (shocker), so this is the command used to install new Gems.  Whenever you modify the Gemfile, run this afterwards to actually bring in the new Gems.
- `git pull` - Deploy fresh code from this repo by pulling while ssh'd into the server.

## Setting Up Constants
The Dropbox and Twilio APIs have secret keys which need to be loaded into the environment.  That's being handled by [Figaro](https://github.com/laserlemon/figaro), a library which reads lines out of `config/application.yml` and turns them into environment variables.

Sample File:
```
TWILIO_NUMBER: "+1234567890"
TWILIO_ACCOUNT_SID: "XXX...XXX"
TWILIO_AUTH_TOKEN: "XXX...XXX"
DROPBOX_OAUTH_BEARER: "XXX...XXX"
```
