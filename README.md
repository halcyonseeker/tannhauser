# The Tannhauser Gate

A somewhat functional gopher script to allow content in geminispace to
be accessed from any gopher browser.

**This site isn't live yet**

[gopher://tannhauser.lagrangian.space](gopher://tannhauser.lagrangian.space)

Since M$ Github doesn't hyperlink gopher urls, here's a
[floodgap link](https://gopher.floodgap.com/gopher/gw.lite?gopher://tannhauser.lagrangian.space:70/1)

## Dependencies
+ nmap, for ncat 
+ geomyidae

## Bugs
+ **Geomyidae only sets search for selector 7**. This is really bad,
  as it means that the "astrogation" functionality that is this
  program's raison d'etre is impossible. I'll look into different
  servers (Gophernicus, etc) and the Gopher spec (RFC 1436) to see if
  there's a way around it. If not I'll probably have to shove this
  script into a minimal Gopher server.
+ **printf | ncat doesn't work with gus.guru**. The server doesn't
  return anything and the program dies with `$status`, which should be
  something like `20 text/gemini`, unset. I think `printf | ncat`
  doesn't properly adhere to the Gemini spec.
+ **Content-type handler is screwy**. The case statement always
  defaults, even when the content-type is `text/gemini`, except with
  the "astrogate" functionality . See the comment for more info.
+ **Broken hyperlink-generator**. gmi2gph.awk produces broken gopher
  and http(s) hyperlinks, learn more about AWK and fix them.

## TODO
+ Figure out a portable way to removing nmap as a dependency.
+ Investigate making this script server-agnostic.
+ We might have to URL-encode the query URL. Should be easy with AWK.
+ gmi2gph.awk needs to know the query url to build hyperlinks, figure
  out how to pass it from tannhauser.dcgi.
+ Decide what to do about gemini hyperlinks with unspecified protocols
