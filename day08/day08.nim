import std/[
    strutils, sequtils, tables,
    algorithm, math,
    sugar
]

const file = "./input.txt"
let blocks = readFile(file).strip().split("\n\n")

var desert = initTable[string, tuple[l,r: string]]()
let directions = blocks[0]
for m in blocks[1].splitLines().mapIt(it.split(" = ")): 
    let left = m[1].split(", ")[0][1..^1]
    let right = m[1].split(", ")[1][0..^2]
    desert[m[0]] = (left, right)

proc part_one(start: string = "AAA"): int = 
    var current = start
    while true: 
        # repeat until the destination is reached
        for dir in directions: 
            if dir == 'L':
                # walk left
                current = desert[current].l
            elif dir == 'R':
                # walk right
                current = desert[current].r

            inc result 
            if current.endsWith("Z"): 
                return

proc part_two(): int =
    var paths: seq[int]
    for key, value in desert: 
        if key.endsWith("A"):
            # If key ends with A, save the number of steps it takes to reach "..Z"
            paths.add(part_one(key))

    # calculate largest common multiple 
    # this is the point where paths are end up at "..Z" at the same time
    return lcm(paths) 
    

echo "Part one: ", part_one()
echo "Part two: ", part_two()