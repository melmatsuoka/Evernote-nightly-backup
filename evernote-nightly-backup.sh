#!/bin/bash
#
# Updates evernote-backup database, then exports the database to .enex files in a date-stamped folder
# in "nightly-exports". The script limits the amount of export folders to the $maxbackups value,
# and purges old export folders.
#

maxbackups=2
backupdir="/path/to/evernote-backup-database-folder"
date=$(date +%Y%m%d-%H%M%S)
exports_basedir="$backupdir/nightly-exports"
dated_exportdir="$exports_basedir/$date"

cd "$backupdir"

evernote-backup sync

# Initialize an empty array
export_dirs=()

# List directories sorted by modification time (oldest first) and read into an array safely
while IFS= read -r dir; do
    export_dirs+=("$dir")  # Append to array safely
done < <(find "$exports_basedir" -type d -mindepth 1 -maxdepth 1 -exec stat -f "%m %N" {} + | sort -n | cut -d ' ' -f2-)

# If the number of directories exceeds $maxbackups, then delete the oldest ones
while [ "${#export_dirs[@]}" -ge "$maxbackups" ]; do
    oldest="${export_dirs[0]}"
    echo "Deleting old backup: $oldest"
    rm -rf "$oldest"
    export_dirs=("${export_dirs[@]:1}")  # Remove the first element from the array
done

mkdir -p "$dated_exportdir"

evernote-backup export "$dated_exportdir"
