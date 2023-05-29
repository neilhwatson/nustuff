#!/usr/bin/python3

import datetime
from typing import Any
from pydantic import BaseModel

old_rules = [
    {'component': 'one', 'create_time': '2023-03-20T12:57:05Z', 'description':
     'testing', 'entry_scope': 'global', 'entry_value': None},
    {'component': 'two', 'create_time': '2023-03-20T13:57:05Z', 'description':
     'testing', 'entry_scope': 'global', 'entry_value': None},
    {'component': 'three', 'create_time': '2023-03-20T14:57:05Z',
     'description': 'testing', 'entry_scope': 'global', 'entry_value': None}
]

cooked_rules = []
cooked_rules.append({'component': 'one', 'create_time': datetime.datetime(2023, 3, 20, 12, 57, 5), 'description': 'testing', 'entry_scope': 'global', 'entry_value': None})

print("=== type cooked_rules ===", type(cooked_rules))
print("=== type cooked_rules[0] ===", type(cooked_rules[0]))
# class Rule(BaseModel):
#     component: str
#     create_time: datetime.datetime
#     description: str
#     entry_scope: str
#     entry_value: str | None


# class RuleItems(BaseModel):
#     '''How the existing rules are stored in the database'''
#     __root__: list[Rule]

#     def __iter__(self):
#         return iter(self.__root__)

#     def lod(self):
#         return [rule.dict() for rule in self.__root__]


class MyRule(BaseModel):
    component: str
    create_time: datetime.datetime
    description: str
    entry_scope: str
    entry_value: str | None

    @staticmethod
    def get_rules_from_raw_config(rules: Any) -> list["MyRule"]:
        class Rules(BaseModel):
            __root__: list[MyRule]
        return Rules.parse_obj(rules).__root__


# my_rules = RuleItems(__root__=old_rules).lod()
# my_rules = [rule.dict() for rule in RuleItems(__root__=old_rules)]
# print("my_rules ", my_rules)
# print("new rules type ", type(my_rules))
# print("my_rules[0] type ", type(my_rules[0]))


my_rules = MyRule.get_rules_from_raw_config(old_rules)
print("my_rules ", my_rules)
print("new rules type ", type(my_rules))

my_cooked = MyRule.get_rules_from_raw_config(cooked_rules)
print("my_cooked ", my_cooked)
