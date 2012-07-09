#!/usr/bin/perl
my $sep = '========================================================================';
my $chap= '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^';

while(<>){
    s{\s+$}{\n}; # Trim trailing whitespace for clean matches below
    s{<span lang=EN-GB>}{}gi;
    s{</span>}{}gi;
    s{</?center>}{}gi;

    # italic sometimes breaks at one of these spots. We will begin on next line.
    s{\s+style='mso-bidi-font-style:normal'>}{>}gi; # remove attrs so <i> will match
    s{<i style='mso-bidi-font-style:$}{}gi;
    s{<i$}{}i;
    s{^normal'>}{*}gi;
    s{^style='mso-bidi-font-style:normal'>}{*}gi;
    s{\S<i>\s+}{ <i>}gi; # spaces in wrong place
    s{\s+</i>\S}{</i> }gi; # spaces in wrong place
    s{</?i>}{*}gi;

    # headings
    s{<h4>(\d\d\.0)}{\n$1\n$chap\n}gi;
    s{<h4>}{\n}gi;
    s{</h4>}{\n$sep}gi;

    # paragraphs
    s{\s+class=MsoNormal>}{>}gi; # remove para attrs so <p> will match
    s{<p id="fn(\d+)"[^>]*>\s*\[\d+\]}{.. [#fn$1] }gi;
    s{^<p>}{}i;
    s{</?p>}{\n}gi;
    s{<br>}{\n}gi;

    # Footnotes
    s{<a href="#fn\d+" class="footnote">(.*?)</a>}{$1}gi;
    s{\s*\[(\d+)\]}{\\ [#fn$1]_ }gi;

    # citiations
    s{<cite>}{:t:\`}gi;
    s{</cite>}{\`}gi;
    
    # Special date tables for timeline
    s{\s+<TR>}{}gi;
    s{\s+<TD vAlign=top>(\d+)}{$1}gi;
    s{\s+<TD vAlign=top>(\D+)}{    $1}gi;
    s{</TD>}{}gi;
    s{</TR>}{}gi;
    
    print;
}
