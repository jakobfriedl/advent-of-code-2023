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
            foundNum1, foundNum2 = false
            i = 0
            j = l.len - 1

        while i < l.len: 

            if foundNum1 and foundNum2: break

            # Search from the left
            if not foundNum1:
                if l[i].isDigit:
                    digits[0] = l[i]
                    foundNum1 = true
                else: 
                    for n in Number.low .. Number.high:
                        if l[i..l.high].startsWith($n):
                            digits[0] = ($n.ord)[0]
                            foundNum1 = true
                            break
            
            # Search from the right
            if not foundNum2:
                if l[j].isDigit:
                    digits[1] = l[j]
                    foundNum2 = true
                else: 
                    for n in Number.low .. Number.high:
                        if l[j..l.high].startsWith($n):
                            digits[1] = ($n.ord)[0]
                            foundNum2 = true
                            break

            inc i 
            dec j

        result += digits.parseInt

echo "Part one: ", part_one()
echo "Part two: ", part_two()