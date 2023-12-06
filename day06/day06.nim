import std/[
    strutils, sequtils,
    algorithm, math,
    sugar
]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

proc part_one(): int =
    let 
        time = lines[0].split(":")[1].split(" ").filter(_ => _ != "").map(parseInt)
        distance = lines[1].split(":")[1].split(" ").filter(_ => _ != "").map(parseInt)

    result = 1 
    for race in 0..time.len - 1:
        var wins = 0
        for speed in 0..time[race]:
            if (speed * (time[race] - speed)) > distance[race]:
                inc wins
        result *= wins

proc part_two(): int =
    let 
        time = lines[0].split(":")[1].replace(" ", "").join("").parseInt()
        distance = lines[1].split(":")[1].replace(" ", "").join("").parseInt()
    
    for speed in 0..time:
        if (speed * (time - speed)) > distance:
            inc result

echo "Part one: ", part_one()
echo "Part two: ", part_two()