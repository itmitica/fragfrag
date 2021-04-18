# fragfrag
A utility to cut a file into fragments, modify some of the fragments and/or add new fragments at a new location and then reassemble into a new file at the new location.

## Phase one
Add new fragmentation points to a file located in the `template` directory, e.g. `fragfrag(100_some_description)` to `index.html`.

## Phase two
Cut the file into fragments based on those fragmentation points, e.g. `100_some_description.html` in `template\_fragfrag` directory.

## Phase three
Copy and modify some of the fragments into a new `_fragfrag` location in the `files\src` directory, e.g. `files\src\about\_fragfrag\100_some_description.html`.

Optionally, add new fragments in the new `_fragfrag` location in the `files` directory, e.g. `files\src\about\_fragfrag\110_additional_description.html`.

## Phase four
Reassemble fragments from the `template\_fragfrag` directory and fragments from each `_fragfrag` location in `files\src` directory, into a new file in the `files\dist` location, e.g. `files\dist\about\index.html`.
