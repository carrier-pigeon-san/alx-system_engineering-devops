#!/usr/bin/python3
"""This module contains the number_of_subscribers() function that queries
the Reddit API and returns the total number of sunscribers for a given
subreddit
"""

import requests


def number_of_subscribers(subreddit):
    """Queries the Reddit API and returns the total number of sunscribers for
    a given subreddit
    """
    base_url = 'https://www.reddit.com'
    endpoint = '/r/{}'.format(subreddit)
    category = '/about/.json'
    address = base_url + endpoint + category
    headers = {'User-Agent': '0-subs.py/1.0 by Near_East'}

    response = requests.get(address, allow_redirects=False, headers=headers)

    if (response.status_code == 200):
        try:
            about = response.json()
        except Exception as e:
            return 0
        else:
            return (about['data']['subscribers'])
    return 0
