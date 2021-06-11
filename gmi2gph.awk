# Convert text/gemini links to gophermap links through the gate

BEGIN {
    FS = " "
    while (getline > 0) {
        if ($1 == "=>") {                        # This line is a hyperlink
            if (substr($2, 0, 7) == "gemini:") {          # Gemini Link
                sub(/gemini:\/\//, "", $2)
                printf "[1|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf "|/tannhauser.dcgi?" $2 "|localhost|70]\n"

            } else if (!substr($2, 0, index($2, ":"))) {  # Gemini Path
                printf "[1|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf "|/tannhauser.dcgi?" path $2 "|localhost|70]\n"

            } else if (substr($2, 0, 7) == "gopher:") {   # Gopher Link
                printf "GOPHER_LINK => "
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf " (" $2 ")\n"

            } else if ((substr($2, 0, 5) == "http:") || \
                       (substr($2, 0, 6) == "https:")) {  # Web Link
                # FIXME: this is being mangled for some reason
                printf "[h|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf "|URL:" $2 "|localhost|70]\n"

            } else {                                      # Unspecified link
                # TODO: what should we assume?
                printf "UNSPECIFIED_LINK => "
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf " (" $2 ")\n"
            }
        } else {                                 # This line is not a hyperlink
            print $0
        }
    }
}
