#!/bin/awk -f
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
                # TODO: get domain from cgi script and cat it with $url below
                printf "|/tannhauser.dcgi?astrogate/" $2 "|localhost|70]\n"

            } else if (!substr($2, 0, index($2, ":"))) {  # Gemini Path
                printf "[1|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                # TODO: get domain from cgi script and cat it with $url below
                printf "|/tannhauser.dcgi?astrogate/" $2 "|localhost|70]\n"

            } else if (substr($2, 0, 7) == "gopher:") {   # Gopher Link
                # FIXME: this produces mangled links
                sub(/gopher:\/\//, "", $2) # Strip protocol
                domain = substr($2, 0, index($2, ":"))
                sub(/:/, "", $2)           # Strip host
                port = substr($2, 0, index($2, "/"))
                sub(/\//, "", $2)          # Strip port
                selector = substr($2, 0, index($2, "/"))
                sub(/\//, "", $2)          # Strip selector
                path = "/" $2
                printf "[" $selector "|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf "|" $path "|" $domain "|" $port "]\n"

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
