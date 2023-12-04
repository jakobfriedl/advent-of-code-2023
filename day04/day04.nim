import std/[
    strutils, sequtils, tables, strformat,
    algorithm, math,
    sugar
]

const file = "./input.txt"
let lines = readFile(file).strip().splitLines()

var cardCount: Table[int, int] = initTable[int, int]()
var points: Table[int, int] = initTable[int, int]()

proc solve(): (int, int) =
    var resultOne = 0
    var resultTwo = 0

    # Calculate the total number of scratchcards
    for l in lines: 
        let card = l.split(":")[0].split(" ")[^1].parseInt 

        cardCount[card] = cardCount.getOrDefault(card, 0) + 1

        let winningNumbers = l.split(":")[1].split(" | ")[0].split(" ").filter(_ => _ != "").map(parseInt)
        let numbers = l.split(":")[1].split(" | ")[1].split(" ").filter(_ => _ != "").map(parseInt)

        points[card] = points.getOrDefault(card, 0) + pow(2.0, float((winningNumbers.filter(_ => numbers.contains(_)).len) - 1)).floor.toInt
        resultOne += points[card]

        for i in 0..cardCount[card] - 1:
            for w in 1..(winningNumbers.filter(_ => numbers.contains(_)).len):
                cardCount[card+w] = cardCount.getOrDefault(card+w, 0) + 1

    for v in cardCount.values:
        resultTwo += v

    return (resultOne, resultTwo)

let (partOne, partTwo) = solve()
echo "Part one: ", partOne
echo "Part two: ", partTwo