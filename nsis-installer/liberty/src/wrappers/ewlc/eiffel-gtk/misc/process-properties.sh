#!/bin/sh

(for doc in /usr/share/doc/libgtk2.0-doc/gtk/Gtk*.html; do
    class=$(basename $doc)
    class=${class%.html}
    links -dump -no-numbering $doc | 
	egrep "\"[a-z-]+\"[[:space:]]*[A-Za-z]+[[:space:]]*:.*" |
	sed "s/$/ $class/"
    done
) | uniq | sort