package main

import "core:fmt"
import "core:terminal/ansi"

main :: proc() {
    fmt.println("Hello")
    b := create_chessboard()
    //print_chessboard(&b)
    p := get_square(&b, 5, 2)
    fmt.println(p)
}