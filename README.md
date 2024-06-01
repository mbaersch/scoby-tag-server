# Scoby Analytics [UNOFFICIAL]
**Custom Tag Template for server-side Google Tag Manager**

Send pageviews to Scoby Analytics 

![Template Status](https://img.shields.io/badge/Community%20Template%20Gallery%20Status-submitted-orange) ![Repo Size](https://img.shields.io/github/repo-size/mbaersch/scoby-tag-server) ![License](https://img.shields.io/github/license/mbaersch/scoby-tag-server)

---

## Usage
Install the tag template and add a new *Scoby Analytics* tag. Enter your [**Licence Key**](https://docs.scoby.io/getting-started/obtain-license-key) and choose a proper value for your [Secret Salt](https://docs.scoby.io/getting-started/generating-salt-value). Per default, the tag sends every event as page view when loaded. 

**NOTE**: Make sure to only fire on pageviews to avoid flooding your Scoby workspace with false pageview counts.   

### Client ID
Pick a constant or changing **Salt** value if you want the tag to determine a client id from ip address and user agent. You can also use the `client_id` from imcoming event data or any custom value.

### Advanced Settings
You can optionally send visitor **Segment** information as a string. Send multiple values as comma-separated list. Example: `Checkout Process v2, Women, Age 35-50`
