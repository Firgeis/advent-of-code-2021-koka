import std/os/path
import std/os/file

pub fun main()
  get-file().directions-two.println

fun get-file()
  path("/workspaces/koka-env/src/advent-of-code-2021/day2/part1.txt")
  .read-text-file
  .lines

fun directions-two(l: list<string>)
  val commands = l
  .foldl((0,0,0), fn (acc: (int, int, int),x) {
    val parsed = split(x, " ")
    val command = parsed.head("0")
    val amount = parsed.last("0").parse-int-default(0)
    match command
      "forward" -> (acc.fst + amount, acc.snd + acc.thd * amount, acc.thd)
      "down" -> (acc.fst, acc.snd, acc.thd + amount)
      "up" -> (acc.fst, acc.snd, acc.thd - amount)
  })

  (commands.fst * commands.snd).show

fun directions-one(l: list<string>)
  val commands = l
  .foldl((0,0), fn (acc: (int, int),x) {
    val parsed = split(x, " ")
    val command = parsed.head("0")
    val amount = parsed.last("0").parse-int-default(0)
    match command
      "forward" -> (acc.fst + amount, acc.snd)
      "down" -> (acc.fst, acc.snd + amount)
      "up" -> (acc.fst, acc.snd - amount)
  })

  (commands.fst * commands.snd).show