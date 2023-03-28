#!/usr/bin/python3

from pydantic import BaseModel
from typing import Any, List, Dict

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
    configs: list[HostModel]


c = ConfigModel(configs=configs)
print("TYPE", type(c))
print(c)
j = c.json()
print("TYPE", type(j))
print(j)
config_rules = c.configs
print("TYPE", type(config_rules))
print(config_rules)

# print("first username in first host ", c[0].users[0].name)
# for host in c:
#     print(host.host)
#     for user in host.users:
#         print(user.name)
#         print(user.groups)
