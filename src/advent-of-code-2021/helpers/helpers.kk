module helpers
import std/os/file
import std/os/path
import std/text/regex

pub fun print-string-list(list: list<string>)
  print("[")
  foreach(list, fn(x)
    print(x ++ " ")
  )
  println("]")

pub fun print-int-list(list: list<int>)
  print("[")
  foreach(list, fn(x)
    print(x.show ++ " ")
  )
  println("]")