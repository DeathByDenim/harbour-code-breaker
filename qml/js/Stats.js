function reset() {
    var db = LocalStorage.openDatabaseSync("harbour-code-breaker", "1.0", "statistics", 100000);
    db.transaction(
        function(tx) {
            tx.executeSql('DROP TABLE IF EXISTS Statistics')
        }
    )
}

function load() {
    var stats = []

    var db = LocalStorage.openDatabaseSync("harbour-code-breaker", "1.0", "statistics", 100000);
    db.transaction(
        function(tx) {
            try {
                var rs = tx.executeSql('SELECT * FROM Statistics ORDER BY guesses');
                for (var i = 0; i < rs.rows.length; i++) {
                    stats.push({x: rs.rows.item(i).guesses, y: rs.rows.item(i).occurences})
                }
            }
            catch(e) {}
        }
    )

    return stats
}
