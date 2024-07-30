#!/usr/bin/python3
"""This module contains a script that return information about a given user's
TODO list progress from a REST API endpoint and exports it to a csv file
"""
import csv
import requests
import sys

if __name__ == "__main__":
    user_id = sys.argv[1]
    file = f'{user_id}.csv'
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
        with open(file, 'w', newline='') as csvfile:
            todo_writer = csv.writer(csvfile, delimiter=',',
                                     quotechar='"', quoting=csv.QUOTE_ALL)
            for task in todos:
                todo_writer.writerow(
                    [
                        task.get('userId'),
                        user.get('username'),
                        task.get('completed'),
                        task.get('title')
                        ]
                    )
