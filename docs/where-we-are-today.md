# Today's Backend Infrastructure

## Introduction

This document is intended to act as a starting place and template for describing the state of the world _as it is_ (around February 2020). We will create other documentation elsewhere to describe the world _as we hope it to be one day_. The term "backend" is intentionally vague, since Pariyatti's infrastructure involves bare-metal physical machines, virtual servers, SaaS providers, and more. This document need not be beautiful, but hopefully it will be thorough. :) If adding images to this document helps, save them in the same `docs/backend` directory and reference them from this document.

The structure of this template will break down all the major components of Pariyatti's infrastructure by `nouns` --- it's very likely that this isn't the best way to capture this information, so feel free to re-organize the document (or even pick a different document format entirely, if it's easier) where it makes sense.

Open questions not necessarily pertaining to infrastructure can be found in the `QUESTIONS.md` document at the root of this repository.


## People

`People` are points-of-contact (a human being) for the other `nouns` in this list. Pieces of backend infrastructure should be connected to a real human being(s). Wherever contact information is missing, assume Steve H is the point-of-contact.

### Internal

- Steven D: writing this template, volunteer helping with Pariyatti's backend and mobile app, new to Pariyatti; knows little
- Steve H: 8 years as Pariyatti staff and probably the person to fill out most of this template.
- Ankur N: Pariyatti staff; will help Steve H capture information in this doc
- Brihas S: Executive Director and longest-term staff member. Has been involved with the setup of all the backend systems that exist today.
- ???

### External

Example: Support staff from Dreamhost/3dcart/etc Pariyatti engages with individually

- ???
- ???


## Not People

`Not People` are points-of-contact Pariyatti regularly uses that obfuscate the humans behind it. For example, a `support@company.com` email address.

- ???@managed.com
- ???@3dcart.com
- ???@vidyamantra
- ???@dreamhost.com


## Pariyatti Services

`Pariyatti Services` are the high-level services Pariyatti owns and provides to its users, irrespective of where or how they are hosted.

1. pariyatti.org --- DotNetNuke (DNN) on managed.com (CMS)
2. store.pariyatti.org --- 3dcart (e-commerce)
3. learning.pariyatti.org --- moodle on VidyaMantra (e-learning)
4. downloads.pariyatti.org / host.pariyatti.org --- Dreamhost (generic web/file server)
5. ???


## Administration

`Administration` lists the entry points for admins to control the content available through Pariyatti's websites.

pariyatti.org - DNN admin is in-line / WYSIWYG
3DCart admin 
learning.pariyatti.oreg - moodle admin is in-line / WYSIWYG
Dreamhost is direct SFTP


## Data

`Data` lists which data formats and which content are stored on which servers/services.

All 3 major components (DNN, 3dcart, and Dreamhost) interact with one another. Thankfully, most integration happens at the URL level, so it should be easy to replace one component with another and not break the other two. Moodle on VidyaMantra is entirely isolated and it hosts its own files.

Integration Example: DNN might serve an image as part of the website which is a JPEG stored on Dreamhost and links to 3dcart. Because pariyatti.org and store.pariyatti.org have a similar look-and-feel, the website feels seamless on the surface.

- Free Resources:
  - audio: dreamhost
  - PDFs: dreamhost
- Daily Words of the Buddha, Pali Word of the Day, and the Dohas are feeds managed by a perl script on the Dreamhost SFTP server
- Word of the Day is an ASPX (web) and EXE (windows standalone) program; these programs are stored on Dreamhost
- podcasts are on Dreamhost, served from host.pariyatti.org
- Pali lessons:
  - Moodle lessons (HTML) and content (PDFs/mp3s) are stored in Moodle itself (not Dreamhost)
  - Quizlet content is stored in Quizlet; PDFs may be exported and uploaded to Moodle
  - Dynamic Pali content (ex. "Learn Devanagari") is HTML+Javascript stored in Moodle


## Hardware

`Hardware` could be any physical computer or device Pariyatti makes regular use of. "Physical" is important because it captures specific risks: the computer can break down in a way that requires a real-world replacement; the computer can be stolen causing a loss of data.

### Servers

- SFTP @ Dreamhost
- Azure virtual server

### Official Desktops/Laptops

"Official" here means that if the computer was lost/destroyed/stolen something saved on it (passwords, keys, data, etc.) would be impossible to recover. Desktops owned by Pariyatti but with no special significance need not be captured here.

- ???

### Devices (Phones, Yubikeys, etc.)

- ???


## Virtual Servers

Dreamhost servers come here. Mentioning which type of Dreamhost service would be helpful (VPS, shared, cloud, etc.)

- static IP? / hostname? / purpose?
- ??? / ??? / ???
- azure server? (ask Brihas)


## Software-as-a-Service (SaaS)

`SaaS` includes any servers or services over which Pariyatti has limited control. So we don't get too fancy, we'll lump all other `X-as-a-Service` categories under SaaS for now. Examples include `managed.com` for DNN, as well as the DNN instance itself, 3dcart, managed CDNs, etc. If you aren't sure whether or not something is SaaS, list it here and we'll discuss! :)

### Paid

- managed.com
- DotNetNuke on managed.com
- 3dcart
- dreamhost
- vidyamantra.com
- moodle on Vidya Mantra
- Quizlet.com

### Free

- GitHub


## Network Services

`Network Services` can be used to capture anything which isn't user-facing. These may include network layers like DNS but might also include things like web servers which can't be accessed by Pariyatti users directly.

- Domain Registrar?
- DNS / nameservers?
- SSL certificate service?
    => check with Brihas

- Load balancers?
- Servers without public URLs or interfaces?


## Shrink-Wrapped Software

`Shrink-Wrapped Software` includes anything that is essential to Pariyatti's operations but not necessarily hosted on the internet. Examples include offline desktop tools like Microsoft Office for spreadsheets and Inkscape for SVGs. Do not bother including specific tools for editing generic data, like text editors.

- ???
- ???


## Security Tools

`Security Tools` include password managers, SSL certificate management (if done locally), 2-Factor-Auth tools, etc.

- ???
- ???


## Licenses

`Licenses` includes any license required to run essential Pariyatti software and services. Paid, proprietary licenses in particular are worth mentioning.

- BSD License, DotNetNuke
- ???
- ???


## Logins

`Logins` captures a broad range of the previous categories. Obviously, do not write down usernames in this file unless those usernames are inherently public already (ex. GitHub). Without specifics, we can identify how many logins we have + the login URL for each of the different services/servers used.

If anyone feels uncomfortable with this approach, please leave this section blank and we can enter this data into a private document.

- ex: user1 @ panel.dreamhost.com
- ex: user2 @ panel.dreamhost.com
- ex: user1 @ support.dreamhost.com
- deobald @ github.com/login
- santumahapatra @ github.com/login
- ???
- ???


## Communication Tools

`Communication Tools` is a list of all the existing communication tools in use and their purpose.

- Email: Asynchronous messaging
- WhatsApp: Small asynchronous (and synchronous) messaging
- GoToMeeting: Video calls / screensharing
- Google Hangouts: Video calls / screensharing
- ???
- ???


## Project Management Tools

`Project Management Tools` includes anything used to track work items or tasks and share them between team members.

- Asana
- Google Docs
- ???


## Processes

`Processes` are how pariyatti.org and *.pariyatti.org change over time. When is content edited, and by whom? How often does this happen? What are the big events that signal a change is needed in the content, such as a new pilgrimage? What are the big events which signal a technical change, such as renewing an SSL certificate?

### Repeated Processes

- ???
- ???

### Ad-Hoc Processes

- ???
- ???


## New Category One

Feel free to add categories if you think of some information that doesn't fit into the categories above!


## New Category Two
