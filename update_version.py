#!/usr/bin/python3

import os
import re
import fileinput
from github import Github

file="Formula/neomutt.rb"

token = os.getenv('GITHUB_TOKEN')

if token == None:
    print('Using anonymous connection to GitHub')
    print('Try getting a personal authentication token from GitHub')
    print('Then set $GITHUB_TOKEN')
else:
    print('Using token to connect to GitHub')

g = Github(token)

org = g.get_organization('neomutt')
print('Got neomutt')

repo = org.get_repo('neomutt')
print('Got neomutt/neomutt')

rels = repo.get_releases()
print('Got releases')

latest = rels[0].tag_name
print('Latest release:', latest)

tag = repo.get_git_ref('tags/' + latest)
print('Tag SHA:', tag.object.sha)

tags = repo.get_tags()
for t in tags:
    if t.name == latest:
        break;

if t == None:
    print("Couldn't find tag")
    exit

commit = t.commit
print('Commit SHA:', commit.sha)

print('Editing file:', file)

rx1 = re.compile(r"neomutt-[0-9]{8}")
rx2 = re.compile(r"[0-9a-f]{40}")

with fileinput.FileInput(file, inplace=True) as file:
    for line in file:
        line = rx1.sub(latest, line)
        line = rx2.sub(commit.sha, line)
        print(line, end='')

print('done')

