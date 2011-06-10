// ---------------------------------------------------------------------------
// gindent options
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// -bad, --blank-lines-after-declarations
// Force blank lines after the declarations.
// See  BLANK LINES.
-bad

// -nbad, --no-blank-lines-after-declarations
// Do not force blank lines after declarations.
// See  BLANK LINES.

// ---------------------------------------------------------------------------
// -bap, --blank-lines-after-procedures
// Force blank lines after procedure bodies.
// See  BLANK LINES.
-bap

// -nbap, --no-blank-lines-after-procedures
// Do not force blank lines after procedure bodies.
// See  BLANK LINES.

// ---------------------------------------------------------------------------
// -bbb, --blank-lines-before-block-comments
// Force blank lines before block comments.
// See  BLANK LINES.

// ---------------------------------------------------------------------------
// -bbo, --break-before-boolean-operator
// Prefer to break long lines before boolean operators.
// See  BREAKING LONG LINES.

// -nbbo, --break-after-boolean-operator
// Do not prefer to break long lines before boolean operators.
// See  BREAKING LONG LINES.
-nbbo

// ---------------------------------------------------------------------------
// -bc, --blank-lines-after-commas
// Force newline after comma in declaration.
// See  DECLARATIONS.

// -nbc, --no-blank-lines-after-commas
// Do not force newlines after commas in declarations.
// See  DECLARATIONS.
-nbc

// ---------------------------------------------------------------------------
// -bl, --braces-after-if-line
// Put braces on line after if, etc.
// See  STATEMENTS.

// -blin, --brace-indentn
// Indent braces n spaces.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -br, --braces-on-if-line
// Put braces on line with if, etc.
// See  STATEMENTS.
-br

// ---------------------------------------------------------------------------
// -brs, --braces-on-struct-decl-line
// Put braces on struct declaration line.
// See  DECLARATIONS.

// -bls, --braces-after-struct-decl-line
// Put braces on the line after struct declaration lines.
// See  DECLARATIONS.
-bls

// ---------------------------------------------------------------------------
// -bs, --Bill-Shannon, --blank-before-sizeof
// Put a space between sizeof and its argument.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -cn, --comment-indentationn
// Put comments to the right of code in column n.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -cdn, --declaration-comment-columnn
// Put comments to the right of the declarations in column n.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -cdb, --comment-delimiters-on-blank-lines
// Put comment delimiters on blank lines.
// See  COMMENTS.

// -ncdb, --no-comment-delimiters-on-blank-lines
// Do not put comment delimiters on blank lines.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -cdw, --cuddle-do-while
// Cuddle while of do {} while; and preceeding `}'.
// See  COMMENTS.
-cdw

// -ncdw, --dont-cuddle-do-while
// Do not cuddle } and the while of a do {} while;.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -ce, --cuddle-else
// Cuddle else and preceeding `}'.
// See  COMMENTS.

// -nce, --dont-cuddle-else
// Do not cuddle } and else.
// See  STATEMENTS.
-nce

// ---------------------------------------------------------------------------
// -cin, --continuation-indentationn
// Continuation indent of n spaces.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -clin, --case-indentationn
// Case label indent of n spaces.
// See  STATEMENTS.
-cli0

// ---------------------------------------------------------------------------
// -cbin, --case-brace-indentationn
// Indent braces after a case label N spaces.
// See  STATEMENTS.
-cbi0

// ---------------------------------------------------------------------------
// -cpn, --else-endif-columnn
// Put comments to the right of #else and #endif statements in  column
// n.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -cs, --space-after-cast
// Put a space after a cast operator.
// See  STATEMENTS.

// -ncs, --no-space-after-casts
// Do not put a space after cast operators.
// See  STATEMENTS.
-ncs

// ---------------------------------------------------------------------------
// -dn, --line-comments-indentationn
// Set indentation of comments not to the right of code to n spaces.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -bfda, --break-function-decl-args
// Break the line before all arguments in a declaration.
// See  DECLARATIONS.

// -bfde, --break-function-decl-args
// Break the line after the last argument in a declaration.
// See  DECLARATIONS.

// -nbfda, --dont-break-function-decl-args
// Don't  put  each  argument  in a function declaration on a seperate
// line.
// See  DECLARATIONS.

// ---------------------------------------------------------------------------
// -din, --declaration-indentationn
// Put variables in column n.
// See  DECLARATIONS.
-di8

// ---------------------------------------------------------------------------
// -fc1, --format-first-column-comments
// Format comments in the first column.
// See  COMMENTS.

// -nfc1, --dont-format-first-column-comments
// Do not format comments in the first column as normal.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -fca, --format-all-comments
// Do not disable all formatting of comments.
// See  COMMENTS.

// -nfca, --dont-format-comments
// Do not format any comments.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -hnl, --honour-newlines
// Prefer  to  break  long  lines  at  the position of newlines in the
// input.
// See  BREAKING LONG LINES.

// -nhnl, --ignore-newlines
// Do not prefer to break long lines at the position  of  newlines  in
// the input.
// See  BREAKING LONG LINES.
-nhnl

// ---------------------------------------------------------------------------
// -gnu, --gnu-style
// Use GNU coding style.  This is the default.
// See  COMMON STYLES.

// -kr, --k-and-r-style
// Use Kernighan & Ritchie coding style.
// See  COMMON STYLES.

// -orig, --original
// Use the original Berkeley coding style.
// See  COMMON STYLES.

// ---------------------------------------------------------------------------
// -in, --indent-leveln
// Set indentation level to n spaces.
// See  INDENTATION.
-i4

// ---------------------------------------------------------------------------
// -ipn, --parameter-indentationn
// Indent parameter types in old-style function definitions by n  spa-
// ces.
// See  INDENTATION.
-ip0

// -nip, --no-parameter-indentation
// Zero width indentation for parameters.
// See  INDENTATION.
// jeffhung.20040429: do not supported by gindent
//-nip

// ---------------------------------------------------------------------------
// -ln, --line-lengthn
// Set maximum line length for non-comment lines to n.
// See  BREAKING LONG LINES.

// ---------------------------------------------------------------------------
// -lcn, --comment-line-lengthn
// Set maximum line length for comment formatting to n.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -lp, --continue-at-parentheses
// Line up continued lines at parentheses.
// See  INDENTATION.
-lp

// -nlp, --dont-line-up-parentheses
// Do not line up parentheses.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -lps, --leave-preprocessor-space
// Leave space between `#' and preprocessor directive.
// See  INDENTATION.
// jeffhung.20040429: -nlps, -ppi
-lps

// ---------------------------------------------------------------------------
// -npro, --ignore-profile
// Do not read `.indent.pro' files.
// See  INVOKING INDENT.

// ---------------------------------------------------------------------------
// -pcs, --space-after-procedure-calls
// Insert a space between the name of the procedure being  called  and
// the `('.
// See  STATEMENTS.

// -npcs, --no-space-after-function-call-names
// Do not put space after the function in function calls.
// See  STATEMENTS.
-npcs

// ---------------------------------------------------------------------------
// -pin, --paren-indentationn
// Specify  the  extra  indentation  per  open  parentheses '(' when a
// statement is broken.See  STATEMENTS.

// ---------------------------------------------------------------------------
// -pmt, --preserve-mtime
// Preserve access and modification times on output files.See  MISCEL-
// LANEOUS OPTIONS.

// ---------------------------------------------------------------------------
// -prs, --space-after-parentheses
// Put a space after every '(' and before every ')'.
// See  STATEMENTS.

// -nprs, --no-space-after-parentheses
// Do not put a space after every '(' and before every ')'.
// See  STATEMENTS.
-nprs

// ---------------------------------------------------------------------------
// -psl, --procnames-start-lines
// Put the type of a procedure on the line before its name.
// See  DECLARATIONS.

// -npsl, --dont-break-procedure-type
// Put the type of a procedure on the same line as its name.
// See  DECLARATIONS.
-npsl

// ---------------------------------------------------------------------------
// -saf, --space-after-for
// Put a space after each for.
// See  STATEMENTS.
-saf

// -nsaf, --no-space-after-for
// Do not put a space after every for.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -sai, --space-after-if
// Put a space after each if.
// See  STATEMENTS.
-sai

// -nsai, --no-space-after-if
// Do not put a space after every if.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -saw, --space-after-while
// Put a space after each while.
// See  STATEMENTS.
-saw

// -nsaw, --no-space-after-while
// Do not put a space after every while.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -sbin, --struct-brace-indentationn
// Indent braces of a struct, union or enum N spaces.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -sc, --start-left-side-of-comments
// Put the `*' character at the left of comments.
// See  COMMENTS.
-sc

// -nsc, --dont-star-comments
// Do not put the `*' character at the left of comments.
// See  COMMENTS.

// ---------------------------------------------------------------------------
// -sob, --swallow-optional-blank-lines
// Swallow optional blank lines.
// See  BLANK LINES.
-sob

// -nsob, --leave-optional-blank-lines
// Do not swallow optional blank lines.
// See  BLANK LINES.

// ---------------------------------------------------------------------------
// -ss, --space-special-semicolon
// On one-line for and while statments, force a blank before the semi-
// colon.
// See  STATEMENTS.
-ss

// -nss, --dont-space-special-semicolon
// Do not force a space before the semicolon after certain statements.
// Disables `-ss'.
// See  STATEMENTS.

// ---------------------------------------------------------------------------
// -st, --standard-output
// Write to standard output.
// See  INVOKING INDENT.

// ---------------------------------------------------------------------------
// -T  Tell indent the name of typenames.
// See  DECLARATIONS.

// ---------------------------------------------------------------------------
// -tsn, --tab-sizen
// Set tab size to n spaces.
// See  INDENTATION.
-ts4

// ---------------------------------------------------------------------------
// -ut, --use-tabs
// Use tabs. This is the default.
// See  INDENTATION.
-ut

// -nut, --no-tabs
// Use spaces instead of tabs.
// See  INDENTATION.

// ---------------------------------------------------------------------------
// -v, --verbose
// Enable verbose mode.
// See  MISCELLANEOUS OPTIONS.
-v

// -nv, --no-verbosity
// Disable verbose mode.
// See  MISCELLANEOUS OPTIONS.

// ---------------------------------------------------------------------------
// -version
// Output the version number of indent.
// See  MISCELLANEOUS OPTIONS.



// ---------------------------------------------------------------------------
// freebsd indent options
// ---------------------------------------------------------------------------

// -bap -br -nce -di8 -ei -nip -lp

