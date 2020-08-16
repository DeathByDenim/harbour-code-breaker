var solution = [0,0,0,0]

function newGame() {
    solution.forEach(function(val, index) {
        solution[index] = Math.floor(Math.random() * (Constants.colors.length - 1)) + 1
    })
    movesModel.clear()
    movesModel.append({
        color1: 0,
        color2: 0,
        color3: 0,
        color4: 0,
        answer1: 0,
        answer2: 0,
        answer3: 0,
        answer4: 0,
        current: true
    })
    wonLabel.visible = false;
    guessmenu.enabled = true;
    guesspushmenu.visible = true;
}

function newGuess() {
    var last = movesModel.get(movesModel.count - 1)

    var next = {
        color1: last.color1,
        color2: last.color2,
        color3: last.color3,
        color4: last.color4,
        answer1: 0,
        answer2: 0,
        answer3: 0,
        answer4: 0,
        current: true
    }

    var num_correct_place = 0;
    var num_correct_color = 0;
    var guess = [last.color1, last.color2, last.color3, last.color4]
    var solcopy = [solution[0], solution[1], solution[2], solution[3]]

    for(var i = 0; i < guess.length; i++) {
        if(solcopy[i] === guess[i]) {
            num_correct_place++
            guess[i] = 0
            solcopy[i] = -1
        }
    }

    for(var i = 0; i < guess.length; i++) {
        for(var j = 0; j < solcopy.length; j++) {
            if(guess[i] === solcopy[j]) {
                num_correct_color++
                guess[i] = 0
                solcopy[j] = -1
            }
        }
    }

    last.current = false;
    last.correctplac = 2//num_correct_place;
    last.correctcolo = 2//num_correct_color;
    var count = 0
    for(var i = 0; i < num_correct_place; i++) {
        switch(count) {
        case 0:
            last.answer1 = 2
            break;
        case 1:
            last.answer2 = 2
            break;
        case 2:
            last.answer3 = 2
            break;
        case 3:
            last.answer4 = 2
            break;
        }
        count++
    }
    for(var i = 0; i < num_correct_color; i++) {
        switch(count) {
        case 0:
            last.answer1 = 1
            break;
        case 1:
            last.answer2 = 1
            break;
        case 2:
            last.answer3 = 1
            break;
        case 3:
            last.answer4 = 1
            break;
        }
        count++
    }

    if(num_correct_place < 4)
        movesModel.append(next);
    else {
        wonLabel.visible = true;
        guessmenu.enabled = false;
        save(movesModel.count)
    }
}

function save(numguesses) {
    var db = LocalStorage.openDatabaseSync("harbour-code-breaker", "1.0", "statistics", 100000);
    db.transaction(
        function(tx) {
            // Create the database if it doesn't already exist
            tx.executeSql('CREATE TABLE IF NOT EXISTS Statistics(guesses INT, occurences INT)')
            tx.executeSql('CREATE UNIQUE INDEX IF NOT EXISTS idx_statistics_guesses ON Statistics (guesses)')

            var rs = tx.executeSql('SELECT * FROM Statistics WHERE guesses = ' + numguesses)
            if(rs.rows.length === 0) {
                tx.executeSql('INSERT INTO Statistics VALUES(?, ?)', [ numguesses, 1 ])
            }
            else {
                var occ = rs.rows.item(0).occurences
                tx.executeSql('REPLACE INTO Statistics VALUES(?, ?)', [ numguesses, occ+1 ])
            }
        }
    )
}
