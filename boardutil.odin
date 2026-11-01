package main

import "core:fmt"
Piece :: enum u8 {None, Pawn, Rook, Bishop, Knight, Queen, King}
Side :: enum u8 {None, White, Black}

create_chessboard :: proc() -> (board: matrix[8,8]complex64){
    pieces := [8]Piece{.Rook, .Knight, .Bishop, .Queen, .King, .Bishop, .Knight, .Rook}
    for i:=0; i<8; i+=1 {
        for j:=2; j<6; j+=1{
            board[j,i] = complex(f32(Piece.None),f32(Side.None))
        }
        board[1,i] = complex(f32(Piece.Pawn),f32(Side.White))
        board[6,i] = complex(f32(Piece.Pawn),f32(Side.Black))
        board[0,i] = complex(f32(pieces[i]),f32(Side.White))
        board[7,i] = complex(f32(pieces[i]),f32(Side.Black))
    }
    return
}

print_chessboard :: proc(board: ^matrix[8,8]complex64){
    for i:=0; i<8; i+=1 {
        for j:=0; j<8; j+=1 {
            b: complex64 = board[i,j]
            fmt.print(Piece(real(b)),Side(imag(b)), "; ")
        }
        fmt.println()
    }
}

valid_position :: proc(nums: ..int) -> bool {
    for n in nums {
        if n < 0 || n > 8{
            return false
        }
    }
    return true
}