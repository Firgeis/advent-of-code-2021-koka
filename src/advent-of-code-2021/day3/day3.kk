import std/os/path
import std/os/file
import std/num/int32

type rating
  Oxygen
  CO2

pub fun main()
  val readings = get-file()
  val tall = readings.length
  val oxygen = parse-rating(readings, Oxygen).string-to-int(2).uint32
  val co2 = parse-rating(readings, CO2).string-to-int(2).uint32
  (oxygen * co2).show.println

fun parse-rating(readings: list<string>, rating: rating)
  fun aux(prfix: string, index: int, selected: list<string>)
        val current-char = 
          match rating
            Oxygen -> commons(selected, True)[index].string
            CO2 -> commons(selected, False)[index].string
        val new-prefix = prfix ++ current-char
        val filtered = selected.filter(fn (x) { if x.first.advance(index).string == current-char then True else False})
        if filtered.length > 1 then aux(new-prefix, index + 1, filtered) else filtered.head("Error")
  aux("", 0, readings)

fun commons(readings: list<string>, most: bool)
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
  if most then
    (!ones).map(fn (x) if float64(x) >= (float64(tall) / 2.0) then '1' else '0')
  else
    (!ones).map(fn (x) if float64(x) < (float64(tall) / 2.0) then '1' else '0')

fun gamma-epsilon-rates(most-commons: vector<char>)
  val wide = most-commons.length
  val gamma-rate = most-commons
  .string
  .truncate(wide)
  .string-to-int(2)
  .uint32
  val epsilon-rate = gamma-rate.not.and(uint32(2 ^ wide - 1))
  (gamma-rate, epsilon-rate)

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