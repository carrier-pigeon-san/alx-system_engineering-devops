#!/usr/bin/python3
"""This module contains a script that return information about a given user's
TODO list progress from a REST API endpoint and exports it to a json file
"""
import json
import requests

if __name__ == "__main__":
    file = 'todo_all_employees.json'
    user_url = 'https://jsonplaceholder.typicode.com/users'
    todos_url = 'https://jsonplaceholder.typicode.com/todos'

    users = requests.get(user_url).json()
    todos = requests.get(todos_url).json()

    file_format = {}
    for user in users:
        uid = user.get('id')
        uname = user.get('username')

        user_todos = [
            dict(
                username=uname,
                task=todo.get('title'),
                completed=todo.get('completed')
            )
            for todo in todos if todo.get('userId') == uid
        ]

        file_format[uid] = user_todos

    with open(file, 'w') as jsonfile:
        json.dump(file_format, jsonfile)
