package main

import (
	"fmt"
	"strconv"

	"github.com/herulume/Advent-of-Code/pkg/day1"
)

func main() {
	d1p1, err := day1.Day1Part1()
	if err != nil {
		fmt.Print(err)
	}

	d1p2, err := day1.Day1Part2()
	if err != nil {
		fmt.Print(err)
	}

	fmt.Println("Day 1 solutions")
	fmt.Println("Part 1: " + strconv.Itoa(d1p1))
	fmt.Println("Part 2: " + strconv.Itoa(d1p2))
}
