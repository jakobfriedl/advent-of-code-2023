import std/[
    strutils, sequtils, tables,
    algorithm, math,
    sugar, re
]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

type Number = enum 
    one = 1, two, three, four, five, six, seven, eight, nine

proc part_one(): int = 
    result = 0
    for l in lines:
        # Remove all non-digit characters
        let digits = l.toSeq.filter(_ => _.isDigit).join
        result += (digits[0] & digits[len(digits) - 1]).parseInt

proc part_two(): int =
    result = 0
    for l in lines: 
        var 
            digits: string = "XX"
            i = 0
            j = l.len - 1

        while i < l.len: 
            # Search from the left
            if digits[0] == 'X':
                if l[i].isDigit:
                    digits[0] = l[i]
                else: 
                    for n in Number.low .. Number.high:
                        if l[i..l.high].startsWith($n):
                            digits[0] = ($n.ord)[0]
                            break
            
            # Search from the right
            if digits[1] == 'X':
                if l[j].isDigit:
                    digits[1] = l[j]
                else: 
                    for n in Number.low .. Number.high:
                        if l[j..l.high].startsWith($n):
                            digits[1] = ($n.ord)[0]
                            break

            inc i 
            dec j
        result += digits.parseInt

echo "Part one: ", part_one()
echo "Part two: ", part_two()