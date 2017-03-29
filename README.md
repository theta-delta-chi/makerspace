# TDC Makerspace Emergency System
TDC at MIT recently built a Makerspace in their basement and decided to add an emergency system.  This Rails server runs on MIT systems to power that emergency button. [Click here](https://youtu.be/eXu26cHRDBs) for a campy demonstration of the system in action.

## How It Works
The Makerspace already had two cameras set up inside of it.  They were hooked up to a Raspberry Pi, set to take a picture whenever they detected motion and then upload the picture to Dropbox.  

We added [a big button](docs/fuck_it.jpg) on the wall and hooked it up to yet another Raspberry Pi o that when the button gets pressed, a POST request gets sent to `tdc.mit.edu/makerspace/emergency`.  This triggers the server to request the most recent images from the Dropbox API and then send them to a list of emergency numbers via Twilio. The application also provides a simple dashboard at `tdc.mit.edu/makerspace` which lets users update the listed contacts, see the most recent images, and test the system. 

One implementation detail to note: the pre-existing system uploaded images using a naming scheme such that normal alphanumeric sort is also chronologically ordered.  We therefore find the most recent image by just grabbing the last one off the list.  Take care to follow the same pattern if using this code directly.

## Managing the Web Server
The Makerspace Rails server is hosted by MIT within the TDC locker.  Assuming you have access rights to said locker, these steps will get you into the environment.

1. SSH into Athena with `ssh <kerberos>@athena.dialup.mit.edu`
2. `cd /mit/tdc/web_scripts/makerspace`
3. `ssh -k tdc@scripts` - This step is necessary in order to get access to critical Rails commands like `rake`, which otherwise aren't available.

After following those steps, you'll be inside the repository and able to manage it.  Some useful commands:

- `bundle install --path vendor/bundle` - We're not allowed to install globally install packages on the MIT system (shocker), so this is the command used to install new Gems.  Whenever you modify the Gemfile, run this afterwards to actually bring in the new Gems.
- `git pull` - Deploy fresh code from this repo by pulling while ssh'd into the server. Be careful to check the `.gitignore` and not accidentally push secret keys to this repo.

## Setting Up Constants
The Dropbox and Twilio APIs have secret keys which need to be loaded into the environment.  That's being handled by [Figaro](https://github.com/laserlemon/figaro), a library which reads lines out of `config/application.yml` and turns them into environment variables.

Sample File:
```
TWILIO_NUMBER: "+1234567890"
TWILIO_ACCOUNT_SID: "XXX...XXX"
TWILIO_AUTH_TOKEN: "XXX...XXX"
DROPBOX_OAUTH_BEARER: "XXX...XXX"
```
