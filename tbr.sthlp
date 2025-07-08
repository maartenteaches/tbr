{smcl}
{* *! version 0.1.0  07Jul2025}{...}
{vieweralsosee "" "--"}{...}
{vieweralsosee "[R] summarize" "help summarize"}{...}
{viewerjumpto "Syntax" "tbr##syntax"}{...}
{viewerjumpto "Description" "tbr##description"}{...}
{viewerjumpto "Options" "tbr##options"}{...}
{viewerjumpto "Remarks" "tbr##remarks"}{...}
{viewerjumpto "Examples" "tbr##examples"}{...}
{title:Title}

{phang}
{bf:tbr} {hline 2} Calculate the top-bottom ratio


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
{cmdab:tbr}
[{varname}]
{ifin}
{weight}
{cmd:,} {opt income(inc_var)} [{opt over(over_var)}]

{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opt inc:ome(inc_var)}}{cmd:tbr}computes the ratio of the mean of 
        {it:varname} of the top decile of {it:inc_var} over the mean of 
		{it:varname} of the bottom decile of {it:inc_var}{p_end}
{synopt:{opt over(over_var)}}compute top-bottom ratios for subpopulations 
        defined by {it:over_var}{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{cmd:aweight}s are allowed; see {help weight}.


{marker description}{...}
{title:Description}

{pstd}
{cmd:tbr} calculates the top-bottom ratio for {it:varname}. This is the ratio of
the mean of {it:varname} for the top decile of {it:inc_var} over the mean of {it:varname}
for the bottom decile of {it:inc_var}.


{marker options}{...}
{title:Options}

{phang}
{opt inc:ome(inc_var)} specifies the variable that defines the rich (top decile
of {it:inc_var}) and the poor (bottom decile of {it:inc_var}).

{phang}
{opt over(over_var)} specifies that the tbr is to be computed for each 
sub-population defined by {it:over_var}.


{marker remarks}{...}
{title:Remarks}

{pstd}
The top-bottom ratio has been used in Young et al. 2025.


{marker examples}{...}
{title:Example}

{phang}{cmd:. tbr friends [aw=weight], income(hhinc) over(country)}{p_end}


{title:References}

{p 4 8 2}
C. Young, B. Cornwell, B. Park, N. Feng (2025) Inequality and Social Ties:
Evidence from 15 U.S. Data Sets, {it:Sociological Science}, {bf:12}(14):294-321.


{title:Author}

{pstd}Maarten L. Buis{p_end}
{pstd}maarten.buis@uni-konstanz.de{p_end}