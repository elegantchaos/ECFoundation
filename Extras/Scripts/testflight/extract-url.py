#!/usr/bin/env python

import json
import sys

result = json.load(sys.stdin)
url = result['config_url']

print url
