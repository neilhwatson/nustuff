#!/usr/bin/python3

import datetime
from pydantic import BaseModel

old_rules = [
    {'component': 'one', 'create_time': '2023-03-20T12:57:05Z', 'description':
     'testing', 'entry_scope': 'global', 'entry_value': None},
    {'component': 'two', 'create_time': '2023-03-20T13:57:05Z', 'description':
     'testing', 'entry_scope': 'global', 'entry_value': None},
    {'component': 'three', 'create_time': '2023-03-20T14:57:05Z',
     'description': 'testing', 'entry_scope': 'global', 'entry_value': None}
]

class Rule(BaseModel):
    component: str
    create_time: datetime.datetime
    description: str
    entry_scope: str
    entry_value: str | None


class RuleItems(BaseModel):
    '''How the existing rules are stored in the database'''
    __root__: list[Rule]

    def __iter__(self):
        return iter(self.__root__)

my_rules = RuleItems(__root__=old_rules)
new_rules = [rule.dict() for rule in my_rules]

print("object ", my_rules)
print("dict ", my_rules.dict())

print("new_rules ", new_rules)
print("new rules type ", type(new_rules))
print("new_rules[0] type ", type(new_rules[0]))

rules_list = [Rule(**rule) for rule in old_rules]
print("ruules_list ", rules_list)
print("rules type ", type(rules_list))
