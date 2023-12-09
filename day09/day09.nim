import std/[
    strutils, sequtils,
    algorithm, math,
    sugar
]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

func differences[T](seq: seq[T]): seq[T] = 
    var differences: seq[T] = @[]
    for i in 0..<seq.len-1: 
        differences.add(seq[i+1] - seq[i])
    return differences

proc extrapolate[T](seq: seq[T]): int = 
    if seq.all(_ => _ == 0): return 0
    return seq[^1] + extrapolate(differences(seq))

proc extrapolateBackwards[T](seq: seq[T]): int= 
    if seq.all(_ => _ == 0): return 0
    return seq[0] - extrapolateBackwards(differences(seq))

proc solve(): (int, int) = 
    var r1, r2: int = 0
    for l in lines: 
        r1 += extrapolate(l.split(" ").map(parseInt))
        r2 += extrapolateBackwards(l.split(" ").map(parseInt))
    return (r1, r2)

let (s1, s2) = solve()
echo "Part one: ", s1
echo "Part two: ", s2