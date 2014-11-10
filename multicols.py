#! /usr/bin/python

"""
multicols.py: Generate an arbitrary number of rows with random values.
"""

import sys
from random import *

# ---
# Load a list of the biggest US cities (289 of them),
# to pick a random city/state combination for an address.

usa_cities = []

def load_cities():
  global usa_cities
  lines = [line.rstrip() for line in open("usa_cities.lst").readlines()]
  usa_cities = [line.split(",") for line in lines]

def random_city():
  if usa_cities == []:
    load_cities()
  which = randint(0,len(usa_cities)-1)
  return usa_cities[which]

if __name__ == '__main__':

# Produce text format data with different kinds of separators.
  possible_separators = { "pipe": "|", "comma": ",", "csv": ",",
    "ctrl-a": "<xref href="01", "hash": "#", "bang": "!", "tab": "\t",
    "tsv": "\t" }

# Accept number of rows to generate as command-line argument.
  try:
    count = int(sys.argv[1])
  except:
    count = 1

# For random numeric values, define upper bound as another command-line argument.
# By default, values are 0-99999.
  try:
    upper = int(sys.argv[2])
  except:
    upper = 99999

# Accept mnemonic for separator characters as command-line argument.
  try:
    sep_arg = sys.argv[3]
    sep = possible_separators[sep_arg]
  except:
#    If no separator is specified, fall back to the Impala default.
    sep = "<xref href="01"

# Generate requested number of rows of data.
  for i in xrange(count):

# Column 1 is a sequential integer, starting from 1.
    c1 = str(i+1)

# Column 2 is a random integer, from 0 to the specified upper bound.
# 10% of the time, we substitute a NULL value instead of a number.
    chance = randint(1,10) % 10;
    if chance == 0:
      c2 = r"\N"
    else:
      c2 = str(randint(0,upper))

# Column 3 is another random integer, but formatted with leading
# zeroes to exactly 6 characters.
    c3 = str(randint(0,upper)).zfill(6)

# Column 4 is a random string, from 4-22 characters.
# It is an initial capital letter, followed by 3 sequences of repeating letters.
# 1% of the time, we substitute a NULL value instead of a string.
    chance = randint(1,100) % 100;
    if chance == 0:
      c4 = r"\N"
    else:
      cap = chr(randint(65,90))
      string1 = chr(randint(97,122)) * randint(1,7)
      string2 = chr(randint(97,122)) * randint(1,7)
      string3 = chr(randint(97,122)) * randint(1,7)
      c4 = cap + string1 + string2 + string3

# Column 5 is a random Boolean value.
# It's true 2/3 of the time, false 1/3 of the time.
    bool = randint(0,2)
    if bool == 0:
      c5 = "false"
    else:
      c5 = "true"

# We figure out a random city and state to use for a location field.
    (city,state) = random_city()
    c6 = city
    c7 = state

# Concatenate all the fields and print.
    row = (c1 + sep + c2 + sep + c3 + sep + c4 +
      sep + c5 + sep + c6 + sep + c7)
    print row
