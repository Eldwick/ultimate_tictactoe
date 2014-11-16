class BoardController < ApplicationController
  def new
  end

  def create
    board = Board.initialize_board
    redirect_to board_path(board)
  end

  def player_one
    @board = Board.find(params[:id])
    @player = params[:player]
    respond_to do |format|
      format.html { render "show"}
      format.json { render json: @board.complete_tree}
    end
  end

  def show
    @board = Board.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @board.complete_tree}
    end
  end

  def update_tile
    tile = Tile.find(params[:id])
   
    tile.update(tile_params)

    miniboard_status = tile.miniboard.checkComplete

    tile.miniboard.board.update(active_row: tile.row+1)
    tile.miniboard.board.update(active_col: tile.column+1)
    tile.miniboard.board.update(x_turn: params[:x_turn])

    activeMini = Miniboard.find_by(row:tile.row, column:tile.column, board_id: tile.miniboard.board.id)
    response = {
      activeRow: activeMini.row,
      activeCol: activeMini.column
    }
    
    if (activeMini.mark)
      tile.miniboard.board.update(open_pick: true)
      response[:openPick] = true
    else
      tile.miniboard.board.update(open_pick: false)
      response[:openPick] = false
    end

    if miniboard_status
      response[:mark] = miniboard_status
    end
    
    respond_to do |format|
      format.json { render json:response }
    end
    
  end

  def tile_params
    params.require(:tile).permit(:mark)
  end
end
