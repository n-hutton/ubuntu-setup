#!/usr/bin/env python3

import ipdb
import argparse
from github import Github


# First create a Github instance:

## using username and password
#g = Github("user", "password")

# or using an access token
token = ""
for line in open("/Users/nhutton/.ssh/github_tokens"):
    print("Found token")
    token = line.rstrip()
    break

#g = Github(base_url="https://github.com/api/v3", login_or_token=token)
g = Github(login_or_token=token)

#ipdb.set_trace(context=20)

# Github Enterprise with custom hostname
#g = Github(base_url="https://{hostname}/api/v3", login_or_token="access_token")

# Then play with your Github objects:
for repo in g.get_user("n-hutton").get_repos():
    print(repo.name)

ipdb.set_trace(context=20)
