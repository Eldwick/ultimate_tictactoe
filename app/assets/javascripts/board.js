function refreshBoard(data) {

  turnX = data.turnX
  activeRow = data.activeRow 
  activeCol = data.activeCol
  miniBoard = $("tr:nth-of-type("+activeRow+") .miniBoard:nth-of-type("+activeCol+")")
  var completedMinis = $(".miniBoard").has(".complete")
  if(openPick){
    $(".miniBoard").not(completedMinis).addClass("active")
    completedMinis.removeClass("active")
  } else {
    miniBoard.addClass('active')
    $(".miniBoard").not(miniBoard).removeClass("active")
  }

  if (data.turnX) {
    $(".turn").text("X Turn")
  } else {
    $(".turn").text("O Turn")
  }

  for(var i = 0; i < 3; i++) {
    for(var j = 0; j < 3; j++) {
      for(var k = 0; k < 3; k++) {
        for(var l = 0; l < 3; l++) {
          var mark = data["grid"][i][j][k][l]
          if (mark == null){
            mark = ''
          }          
          $("tr:nth-of-type("+(i+1)+") .miniBoard:nth-of-type("+(j+1)+") tr:nth-of-type("+(k+1)+") .boardTile:nth-of-type("+(l+1)+")").text(mark)
        }
      }
    }
  }
}

var ready = function() {
  var completedMinis = $(".miniBoard").has(".complete")
  initActiveMini = $("tr:nth-of-type("+activeRow+") .miniBoard:nth-of-type("+activeCol+")")
  if(openPick){
    $(".miniBoard").not(completedMinis).addClass("active")
  } else {
    initActiveMini.addClass('active')
  }

  setInterval(function() {
    $.getJSON("/board/"+gameID, function(data) {
      refreshBoard(data)
    })
  },1000)

  $(".boardTile").click(function(){
    var tile = $(this)
    var mark = tile.data("mark")
    var tileID = tile.data("tileid")
    var miniBoard = tile.closest(".miniBoard")

    var active = miniBoard.hasClass("active")
    if (turnX && !mark && active) {
      tile.text("X")
      tile.data("mark", "X")
      $(".turn").text("O Turn")
      turnX = false;
      $.post("/update_tile/"+tileID, {tile: {mark: "X"}, x_turn: turnX}, function(data) {
        if(data.mark){
          $(".miniMark", miniBoard).text(data.mark).addClass("complete")
        }
        activeRow = data.activeRow + 1
        activeCol = data.activeCol + 1
        activeMiniBoard = $("tr:nth-of-type("+activeRow+") .miniBoard:nth-of-type("+activeCol+")")
        if(data.openPick) {
          openPick = true
          var completedMinis = $(".miniBoard").has(".complete")
          $(completedMinis).removeClass("active")
          $(".miniBoard").not(completedMinis).addClass("active")
        } else {
          openPick = false
          activeMiniBoard.addClass("active")
          $(".miniBoard").not(activeMiniBoard).removeClass("active")
        }
      })
    } else if (!mark && active) {
      tile.text("O")
      tile.data("mark", "O")
      $(".turn").text("X Turn")
      turnX = true
      $.post("/update_tile/"+tileID, {tile: {mark: "O"}, x_turn: turnX}, function(data) {
        if(data.mark){
          $(".miniMark", miniBoard).text(data.mark).addClass("complete")
        }
        activeRow = data.activeRow + 1
        activeCol = data.activeCol + 1
        activeMiniBoard = $("tr:nth-of-type("+activeRow+") .miniBoard:nth-of-type("+activeCol+")")
        if(data.openPick) {
          openPick = true
          var completedMinis = $(".miniBoard").has(".complete")
          $(completedMinis).removeClass("active")
          $(".miniBoard").not(completedMinis).addClass("active")
        } else {
          openPick = false
          activeMiniBoard.addClass("active")
          $(".miniBoard").not(activeMiniBoard).removeClass("active")
        }
      })
      
    }

  })
  
}

$(document).ready(ready);
$(document).on('page:load', ready);