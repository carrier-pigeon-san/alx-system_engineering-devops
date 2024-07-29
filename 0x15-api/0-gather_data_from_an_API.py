#!/usr/bin/python
"""This module contains a python script that return information about a given
user's TODO list progress from a REST API endpoint
"""
from sys import argv
import requests
from requests import exceptions

if __name__ == '__main__':
    user_id = argv[1]
    user_url = f'https://jsonplaceholder.typicode.com/users/{user_id}'
    todos_url = f'{user_url}/todos'

    u = requests.get(user_url)
    t = requests.get(todos_url)

    try:
        user = u.json()
        todos = t.json()
    except exceptions.JSONDecodeError:
        pass
    else:
        done = [i for i in todos if i.get('completed') is True]
        print('Employee {} is done with tasks ({}/{}):'.format(
            user.get('name'), len(done), len(todos)))
        for i in done:
            print(f"\t {i.get('title')}")
