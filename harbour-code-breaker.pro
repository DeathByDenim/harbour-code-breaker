# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-code-breaker

CONFIG += sailfishapp_qml

DISTFILES += qml/harbour-code-breaker.qml \
    qml/cover/CoverPage.qml \
    rpm/harbour-code-breaker.changes.in \
    rpm/harbour-code-breaker.changes.run.in \
    rpm/harbour-code-breaker.spec \
    rpm/harbour-code-breaker.yaml \
    translations/*.ts \
    harbour-code-breaker.desktop \
    qml/pages/GamePage.qml \
    qml/pages/ColourLine.qml \
    qml/js/Game.js \
    qml/js/Constants.js \
    qml/pages/Statistics.qml \
    qml/js/Stats.js \
    qml/pages/ResetStatsDialog.qml

SAILFISHAPP_ICONS = 86x86 108x108 128x128 172x172

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-code-breaker-de.ts translations/harbour-code-breaker-fr.ts translations/harbour-code-breaker-nl.ts
