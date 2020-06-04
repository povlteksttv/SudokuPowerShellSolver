#Soduku board
$row1 = 0,0,0,2,6,0,7,0,1
$row2 = 6,8,0,0,7,0,0,9,0 
$row3 = 1,9,0,0,0,4,5,0,0
$row4 = 8,2,0,1,0,0,0,4,0 
$row5 = 0,0,4,6,0,2,9,0,0
$row6 = 0,5,0,0,0,3,0,2,8 
$row7 = 0,0,9,3,0,0,0,7,4
$row8 = 0,4,0,0,5,0,0,3,6 
$row9 = 7,0,3,0,1,8,0,0,0 

$board = $row1,$row2,$row3,$row4,$row5,$row6,$row7,$row8,$row9

function printBoard {
    param ( $board )
    write-Host "-----------------"
    for ($i=0;$i -le 8;$i++) {
        $board[$i] -join " " 
    }
    write-Host "-----------------"
}

function isValid {
    param( $number, $row, $col, $board )
      
    #Check row
    If ( $board[$row] -contains $number ) {
        return $false
    }
    #check col 
    for ($i=0;$i -le 8;$i++) {
        if ( $board[$i][$col] -contains $number ) {
            return $false
        }
    }
    #check 3x3
    $r = $row - $row % 3
    $c = $col - $col % 3
    for ($i=$r;$i -lt $r+3; $i++) {
        for ($j=$c;$j -lt $c+3; $j++) {
            If ( $board[$i][$j] -contains $number ) {
                return $false
            }
        }
    }
    return $true
}

function solve {
    param( $board )
    For ($row = 0; $row -le 8; $row++) {
        For ($col = 0; $col -le 8; $col++) {
            if ($board[$row][$col] -eq 0) { ##if the next number is a zero = we make a move
                For ($number=1;$number -le 9; $number++) {
                    if (isValid $number $row $col $board) {
                        $board[$row][$col] = $number
                        if (solve $board) {
                            return $true
                        } else {
                            $board[$row][$col] = 0
                        }
                    } 
                }
                return $false
            }  
        }
    }
    return $true #Solved
}
Write-Host "Starting board"
printBoard $board
solve $board
Write-Host "Finished board"
printBoard $board
