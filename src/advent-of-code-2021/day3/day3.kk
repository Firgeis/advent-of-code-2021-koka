import std/os/path
import std/os/file
import std/num/int32

pub fun main()
  val readings = get-file()
  val wide = readings.head("").slice.count
  val tall = readings.length
  val ones = ref(vector(wide, 0))
  readings.foreach(fn (x: string) {
    val chars = vector(x)
    for(0,wide - 1) fn (i) {
      ones.modify(fn (o) {
        if chars[i] == '1' then o[i] := o[i] + 1
      })
    }
  })
  val gamma-rate = (!ones).map(fn (x) if x > (tall / 2) then '1' else '0')
  .string
  .truncate(wide)
  .string-to-int(2)
  .uint32
  val epsilon-rate = gamma-rate.not.and(uint32(2 ^ wide - 1))
  (gamma-rate * epsilon-rate).show.println

fun get-file()
  path("/workspaces/koka-env/src/advent-of-code-2021/day3/part1.txt")
  .read-text-file
  .lines

fun string-to-int(str: string, base: int)
  var value := 0
  str.foreach( fn(c) {
    if !c.is-digit then throw("Tried to parse non digit")
    value := value * 2 + (c - '0').int
  })
  value