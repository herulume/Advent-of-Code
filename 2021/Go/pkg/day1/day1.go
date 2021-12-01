package day1

import (
	"bufio"
	"os"
	"strconv"
)

type pair struct {
	fst, snd int
}

func filterLess(done <-chan interface{}, valueStream <-chan pair) <-chan interface{} {
	filterStream := make(chan interface{})
	go func() {
		defer close(filterStream)
		for v := range valueStream {
			select {
			case <-done:
				return
			default:
				if v.fst < v.snd {
					filterStream <- v
				}
			}
		}
	}()
	return filterStream
}

func toWindow(done <-chan interface{}, numbers []int, n int) <-chan pair {
	dropped := numbers[n:]
	windowStream := make(chan pair)
	go func() {
		defer close(windowStream)
		for i, v := range dropped {
			windowStream <- pair{
				fst: numbers[i],
				snd: v,
			}
		}
	}()

	return windowStream

}

func input(path string) ([]int, error) {
	file, err := os.Open(path)
	if err != nil {
		return nil, err
	}
	defer file.Close()

	var lines []int
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		i, err := strconv.Atoi(scanner.Text())
		if err != nil {
			return nil, err
		}
		lines = append(lines, i)
	}
	return lines, scanner.Err()
}

func collapseBy(values []int, windowSize int) int {
	done := make(chan interface{})
	defer close(done)

	var counter int
	pipeline := filterLess(done, toWindow(done, values, windowSize))
	for p := range pipeline {
		_ = p //
		counter++
	}

	return counter
}

func Day1Part1() (int, error) {
	values, err := input("day1.txt")
	if err != nil {
		return 0, err
	}

	done := make(chan interface{})
	defer close(done)

	return collapseBy(values, 1), nil
}

func Day1Part2() (int, error) {
	values, err := input("day1.txt")
	if err != nil {
		return 0, err
	}

	done := make(chan interface{})
	defer close(done)

	return collapseBy(values, 3), nil
}
