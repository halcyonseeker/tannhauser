# The Tannhauser Gate

A somewhat functional gopher script to allow content in geminispace to
be accessed from any gopher browser.

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
+ **Code 40 on torture test**. We're not passing any of the torture
  tests lol.

## TODO
+ Pass torture test.
+ Support selector 7 and Gemini response code 10 for searching
+ Figure out a portable way to removing nmap as a dependency.
+ Make this script server-agnostic.
+ Wrap lines at 72 columns
+ Make sure there aren't any code-injection vulnerabilities (^_^;)
