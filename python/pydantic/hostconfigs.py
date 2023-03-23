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
    print("class")

    @staticmethod
    def get_hosts(hosts: Any) -> list["HostModel"]:
        print("get_hosts")
        class ConfigModel(BaseModel):
            __root__: list[HostModel]
        return ConfigModel.parse_obj(hosts).__root__


c = HostModel.get_hosts(hosts=configs)
print(c)
print("first username in first host ", c[0].users[0].name)
for host in c:
    print(host.host)
    for user in host.users:
        print(user.name)
        print(user.groups)
