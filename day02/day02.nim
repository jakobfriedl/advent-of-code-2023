import std/[
    strutils, sequtils, tables,
    algorithm, math,
    sugar, re
]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

var limits = {
    "red": 12,
    "green": 13,
    "blue": 14,
}.toTable() 

proc part_one(): int = 
    for l in lines: 
        let 
            id = l.replace("Game ", "").split(":")[0].parseInt()
            contents = l.split(":")[1].strip().split(" ")
        
        var 
            i = 0
            invalid = false
        while i < contents.len - 1: 
            let 
                count = contents[i].parseInt
                color = contents[i+1].replace(",", "").replace(";", "")
            
            if count > limits[color]:
                invalid = true
                break

            i.inc(2)
        
        if not invalid:
            result += id
            
proc part_two(): int =
    for l in lines: 
        let contents = l.split(":")[1].strip().split(" ")

        # Set fewest number of each color
        for color in limits.keys():
            limits[color] = 0

        var i = 0
        while i < contents.len - 1: 
            let 
                count = contents[i].parseInt
                color = contents[i+1].replace(",", "").replace(";", "")
            
            if count > limits[color]:
                limits[color] = count

            i.inc(2)
        
        result += limits["red"] * limits["green"] * limits["blue"]

echo "Part one: ", part_one()
echo "Part two: ", part_two()