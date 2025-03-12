# Evernote-nightly-backup
Syncs your Evernote notebook data and exports them to dated, local backup folders

Uses [evernote-backup](https://github.com/vzhd1701/evernote-backup) to automatically download your Evernote notebook data to a local database file, then exports the contents of database to dated backup folders containing .enex files for every notebook in your Evernote account.

This script is intended to be run from a cronjob or other scheduling mechanism, for automated daily backups of your Evernote data. You can limit the number of backup folders by changing the `maxbackups` parameter.

The script currently lacks extensive sanity checks and error handling, so please treat it as a proof of concept rather than production-ready code.


