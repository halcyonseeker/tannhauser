# The Tannhauser Gate

A proof-of-concept script to allow content in geminispace to be
accessed from any gopher browser.

**This site isn't live yet**

[gopher://tannhauser.ulthar.xyz](gopher://tannhauser.ulthar.xyz)

M$ Github doesn't hyperlink gopher urls, so here's a
[floodgap link](https://gopher.floodgap.com/gopher/gw.lite?gopher://tannhauser.ulthar.xyz:70/1)

## Dependencies
+ nmap, for ncat 
+ geomyidae

## Known Bugs
+ **Content-type handler is screwy**. The case statement always
  defaults, even when the content-type is `text/gemini`.
+ **Path and URL handling parsing is brittle**. The parsing logic in
  tannhauser.dcgi and the creation logic in gmi2gph.awk work about 90%
  of the time, but fail for relative links in the current directory
  and links to parent directories.

## TODO
+ We don't support any kind of Gemini user input yet.
+ Pass the torture test.
+ Figure out a portable way to removing nmap as a dependency.
+ Make this script server-agnostic.
+ Wrap lines at 72 columns.
+ Make sure there aren't any code-injection vulnerabilities (^_^;).
