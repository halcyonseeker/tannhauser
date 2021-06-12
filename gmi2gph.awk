# Convert text/gemini links to gophermap links through the gate

BEGIN {
    FS = " "
    while (getline > 0) {
        if ($1 == "=>") {                        # This line is a hyperlink
            if (substr($2, 0, 7) == "gemini:") {          # Gemini Link
                sub(/gemini:\/\//, "", $2)
                printf("[1|")
                for (i = 3; i <= NF; i++)
                    printf("%s ", $i)
                printf("|/tannhauser.dcgi?%s|localhost|70]\n", $2)

            } else if (!substr($2, 0, index($2, ":"))) {  # Gemini Path
                printf("[1|")
                if (NF == 2)
                    printf("%s", $2)
                else
                    for (i = 3; i <= NF; i++)
                        printf("%s ", $i)
                printf("|/tannhauser.dcgi?%s%s|localhost|70]\n", path, $2)

            } else if (substr($2, 0, 7) == "gopher:") {   # Gopher Link
                sub(/gopher:\/\//, "", $2)
                gphhost = substr($2, 0, index($2, ":") - 1)
                gphport = substr($2, index($2, ":") + 1, length(index($2, "/") - 1))
                gphselector = substr($2, index($2, "/") + 1, 1)
                gphpath = substr($2, index($2, "/") + 2)

                printf("[%s|", gphselector)
                if (NF == 2)
                    printf("%s", $2)
                else
                    for (i = 3; i <= NF; i++)
                        printf("%s ", $i)
                printf("|%s|%s|%s]\n", gphpath, gphhost, gphport)

            } else if ((substr($2, 0, 5) == "http:") || \
                       (substr($2, 0, 6) == "https:")) {  # Web Link
                printf("[h|")
                if (NF == 2)
                    printf("%s", $2)
                else
                    for (i = 3; i <= NF; i++)
                        printf("%s ", $i)
                printf("|URL:%s|localhost|70]\n", $2)

            } else {                                      # Unspecified link
                # Assume Gemini
                printf("[1|")
                if (NF == 2)
                    printf("%s", $2)
                else
                    for (i = 3; i <= NF; i++)
                        printf("%s ", $i)
                printf("|/tannhauser.dcgi?%s%s|localhost|70]\n", path, $2)
            }
        } else {                                 # This line is not a hyperlink
            print $0
        }
    }
}
