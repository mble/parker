# Parker

## What is Parker?

Parker is a lightweight HipChat notifier for priority bugs.

I intend to expand this into something a bit more meaty in the near
future. Right now it serves only to solve a particular problem.

It utilises [hipchat-rb](https://github.com/hipchat/hipchat-rb) for the [Hipchat API](https://www.hipchat.com/docs/apiv2) and [Octokit](https://github.com/octokit/octokit.rb) for the [Github API](https://developer.github.com/v3/).

## What do I need?

Clone the repo and `bundle install`

You'll need to set some environment variables in `.env` for now. They
are:

```
BUG_LABEL=Bug
P1_LABEL="Priority 1"
P2_LABEL="Priority 2"
REPO=org/your-repo
GITHUB_TOKEN=yourghtoken
HIPCHAT_TOKEN=yourhipchattoken
HIPCHAT_ROOM="Some Room"
```

Then just execute `bin/parker`. The output will be something like this:

![Imgur](http://i.imgur.com/SefzCoD.png)
