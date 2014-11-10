#! /usr/bin/python

from impala.dbapi import connect

conn = connect(host='a1730.abcde.example.com', port=21050)
try:
  cur = conn.cursor()
  try:
    cur.execute('show tables in default')
    tables_in_default_db = cur.fetchall()
    print tables_in_default_db
    for table in tables_in_default_db:
      print "Table: " + table[0]
      try:
        cur.execute('describe `%s`' % (table[0]))
        table_layout = cur.fetchall()
        for row in table_layout:
          print "Column: " + row[0] + ", type: " + row[1] + ", comment: " + row[2]
      except:
        print "Error describing table " + table[0]
      cur.execute('select count(*) from `%s`' % (table[0]))
      result = cur.fetchall()
      count = str(result[0][0])
      print "Rows = " + count
  except:
    print "Error getting list of tables."
  cur.close()
except:
  print "Error establishing connection to Impala."
