#!/usr/bin/python3
"""This module contains a script that return information about a given user's
TODO list progress from a REST API endpoint and exports it to a json file
"""
import json
import requests
import sys

if __name__ == "__main__":
    user_id = sys.argv[1]
    file = f'{user_id}.json'
    user_url = f'https://jsonplaceholder.typicode.com/users/{user_id}'
    todos_url = f'{user_url}/todos'

    u = requests.get(user_url)
    t = requests.get(todos_url)

    try:
        user = u.json()
        todos = t.json()
    except requests.exceptions.JSONDecodeError:
        pass
    else:
        file_format = {}
        todo_list = [
            dict(task=i.get('title'),
                 completed=i.get('completed'),
                 username=user.get('username')
                 ) for i in todos
        ]
        file_format.update({user.get('id'): todo_list})

        with open(file, 'w') as jsonfile:
            json.dump(file_format, jsonfile)
