# Scoby Analytics [UNOFFICIAL]
**Custom Tag Template for server-side Google Tag Manager**

Send pageviews to Scoby Analytics 

[![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-beta-orange)](https://tagmanager.google.com/gallery/#/owners/mbaersch/templates/scoby-tag-server) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/scoby-tag-server) ![License](https://img.shields.io/github/license/mbaersch/scoby-tag-server)
    
---

## Usage
Install the tag template and add a new *Scoby Analytics* tag. Enter your **Licence Key** (API Key). Per default, the tag sends ever event as page view when loaded. 

**NOTE**: Make sure to only fore on pageviews to avoid flooding your Scoby workspace with false pageview counts.   

### Client ID
pick a constant or changing **salt** value if you want the tag to determine a client id from ip address and user agent. You can also use the `client_id` from imcoming event data or any custom value.