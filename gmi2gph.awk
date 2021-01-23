#!/bin/awk -f
# Convert text/gemini links to gophermap links through the gate

BEGIN {
    FS = " "
    while (getline > 0) {
        if ($1 == "=>") {
            if (substr($2, 0, 7) == "gemini:") {
                #printf "GEMINI_LINK => "
                printf "[1|" 
                for (i = 3; i <= NF; i++)
                    printf $i " "
                # TODO: strip gemini:// from $2
                printf "|tannhauser.dcgi?astrogate/" $2 \
                    "|localhost|70]\n"
                #printf " (" $2 ")\n"
            } else if (!substr($2, 0, index($2, ":"))) {
                #printf "GEMINI_PATH => "
                # TODO: prepend /
                printf "[1|" 
                for (i = 3; i <= NF; i++)
                    printf $i " "
                # TODO: cat domain with the path
                printf "|tannhauser.dcgi?astrogate/" $2 \
                    "|localhost|70]\n"
                #printf " (" $2 ")\n"
            } else {
                #printf "NORMAL_LINK => "
                if (substr($2, 0, 4) == "http")
                    printf "[h|"
                for (i = 3; i <= NF; i++)
                    printf $i " "
                printf "|URL:" $2 "|localhost|70]\n"
                #printf " (" $2 ")\n"
            }
        } else {
            print $0
        }
    }
}
