package main

Square :: struct {
    piece: Piece,
    side: Side,
    row, col: int
}

get_square :: proc(board: ^matrix[8,8]complex64, row, col: int) -> (square: Square){
    representation := board[row,col]
    piece := Piece(real(representation))
    side := Side(imag(representation))

    square = Square{piece,side, row, col} // use new() ??
    return
}

Move :: struct {
    //starting position, so i can later recreate a game from only an Array of moves
    start_row, start_col, end_row, end_col: int,
    opponent_on_end: bool
}
@(private="file")
Pattern :: struct {
    right, up: int
}

get_possible_moves :: proc(board: ^matrix[8,8]complex64, square: Square) -> (moves: [dynamic]Move){
    switch square.piece {
        case .Pawn:
            return calculate_pawn_moves(board, square)
        case .Knight:
        // TODO
        case .King:
        
        case .Rook:

        case .Bishop:
        
        case .Queen:
        
        case .None:
            return
    }

    return
}

@(private="file")
calculate_pawn_moves :: proc(board: ^matrix[8,8]complex64, square1: Square) -> (moves: [dynamic]Move){         
    my_side : Side = square1.side
    if my_side == Side.None{
        // should never happen
        return moves
    }
    row1 : int = square1.row
    col1 : int = square1.col

    starting_pos : bool = ((my_side==Side.White && row1==1) || 
                           (my_side==Side.Black && row1==6))
    direction : int = my_side==Side.White ? 1 : -1

    one_forward: int = row1+direction
    two_forward: int = row1+(2*direction)

    forward_free: bool = get_square(board, one_forward, col1).piece == Piece.None
    if valid_position(one_forward) && forward_free{
        append(&moves, Move{row1, col1, one_forward, col1, false})
    }
    if valid_position(two_forward) && starting_pos && forward_free && 
                     (get_square(board, two_forward, col1).piece == Piece.None){
        append(&moves, Move{row1, col1, two_forward, col1, false}) 
    }

    opponent_color : Side = my_side==Side.White ? Side.Black : Side.White
    if valid_position(one_forward, col1+1) && (get_square(board, one_forward, col1+1).side == opponent_color){
        append(&moves, Move{row1, col1, one_forward, col1+1, true})
    }
    if valid_position(one_forward, col1-1) && (get_square(board, one_forward, col1-1).side == opponent_color) {
        append(&moves, Move{row1, col1, one_forward, col1-1, true})    
    }
    // left is decrease in row, right means increase

    return moves
}

calculate_moves :: proc(board: ^matrix[8,8]complex64, patterns: []Pattern, steps: int, side: Side) {

}

