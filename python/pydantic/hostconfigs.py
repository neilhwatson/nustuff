#!/usr/bin/python3

from pydantic import BaseModel
from typing import List, Dict

configs = [
    {
        "host": "mars",
        "packages": ["vim", "git", "tmux"],
        "users": [
            {
                "name": "neil",
                "groups": ["wheel", "docker"],
            }
        ]
    },
    {
        "host": "venus",
        "packages": ["apache", "php"],
        "users": [
            {
                "name": "httpd",
                "groups": ["httpd"],
            }
        ]
    }
]

class UserModel(BaseModel):
    name: str
    groups: List[str]


class HostModel(BaseModel):
    host: str
    users: list[UserModel]
    packages: list[str]

class ConfigModel(BaseModel):
    hosts: list[HostModel]

c = ConfigModel(hosts=configs)

print(c)
print("first username in first host ", c.hosts[0].users[0].name)
print("hosts ", c.hosts)
for host in c.hosts:
    print(host.host)
    for user in host.users:
        print(user.name)
        print(user.groups)
