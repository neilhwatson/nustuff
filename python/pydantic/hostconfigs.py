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
    __root__: list[HostModel]


    def __iter__(self):
        return iter(self.__root__)

    def __getitem__(self, item):
        return self.__root__[item]


c = ConfigModel.parse_obj(configs)
print("TYPE", type(c))
print(c)

print("First host config is", c[0])
print("First host config hostname is", c[0].host)

d = c.dict()
print("TYPE", type(d))
print(d)

j = c.json()
print("TYPE", type(j))
print(j)

for host in c:
    print("host ",host.host)
    for user in host.users:
        print("username ",user.name)
        print("groups ", user.groups)

# config_rules = c.configs
# print("TYPE", type(config_rules))
# print("TYPE 0", type(config_rules[0]))
# print(config_rules)

# print("first username in first host ", c[0].users[0].name)
# for host in c:
#     print(host.host)
#     for user in host.users:
#         print(user.name)
#         print(user.groups)
