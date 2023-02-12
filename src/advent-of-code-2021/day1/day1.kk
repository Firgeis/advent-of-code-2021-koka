import src/advent-of-code-2021/helpers/helpers
import std/os/path
import std/os/file
pub fun main()
  get-file().depths.count

fun get-file()
  path("/workspaces/koka-env/src/advent-of-code-2021/day1/part1.txt")
  .read-text-file
  .lines
  .map(fn (x) parse-int(x))
  .filter-map(fn (x) x)

fun count(list: list<int>)
  list.foldl((-1,0), fn (state: (int, int), x)
    if x > state.snd then
      (state.fst + 1, x)
    else
      (state.fst, x)
  )
  .fst
  .show
  .println

fun depths(readings: list<int>)
  val vec = readings.vector
  list(0,vec.length - 3).map-indexed(fn (i, x) vec[i] + vec[i+1] + vec[i+2])
