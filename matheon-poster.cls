%
% Version: $Id: matheon-poster.cls,v 4.0 2009/11/16 $
%
% LaTeX class matheon-poster
%
% for the
%          DFG Research Center Matheon
%          Mathematics for Key Technologies
%
% Please send corrections and suggestions to webmaster@matheon.de
% ----------------------------------------------------------------------
%
% Previous versions:
%
% - Version 1.1  04/28/2003
%   (C) 2003 S. O. Krumke
%
%   based on the poster class poster.cls
%   (c) 1998-2001 O. Karch, S. O. Krumke, H.-C. Wirth
%
% - Version 2.1  06/18/2004
%   updated 11/22/2004 - adaption to Matheon requirements
%   The Matheon logo is set to the left side of the poster
%   and the logo of the institute to the right
%
% - Version 2.2  11/17/2005 (Volker Kaibel, Marc Pfetsch)
%   + renamed to matheon-poster*
%   + replaced "fzt" by "matheon"
%   + changed the FU logos
%
%   + added reiterboxes with tabs on the right
%
% - Version 2.3   01/2006 (Volker Kaibel, Marc Pfetsch)
%   + titlebox currently has 5 Parameter
%     project id, project duration, project title, authors, web-adress
%   + \bgpic corrected with "\vspace{-4mm}" (should be solved more cleanly).
%
% - Version 3.0 06/2006 (Marc Pfetsch)
%   + changed comment language to English
%   + using Helvetia fonts (package helvet)
%     The fonts are slightly down-scaled in order to have about equal
%     sizes in normal and mathematical formulae.
%   + using the geometry package
%   + outsourced definition of boxes to package poster-boxes
%   + complete rewrite of the titlebox
%   + added options that select the language and institutions
%   + separate titlebox for application area posters
%
% - Version 3.1 06/2007 (Marc Pfetsch)
%   + added command \bgpicD
%   + do not typeset 'project' if the corresponding argument is empty
%   + decrease size of indentation for itemize, enumerate, etc.
%   + changed logo names
%   + set 'application area' in application area titlebox
%
% - Version 3.2 06/2007 (Max Wardetzky)
%   + changed fu logo
%
% - Version 3.3 06/2007 (Max Wardetzky)
%   + fixed size of titlebox 
%
% - Version 4.0 11/2009 (Steffen Siering)
%   + support for up to four institutions
%   + added domain of expertise to \titlebox to project posters (needs four arguments)
%
% ----------------------------------------------------------------------
% The options for this class are:
% + FU      - select FU as the institution
% + HU      - select HU as the institution
% + TU      - select TU as the institution
% + WIAS    - select Wias as the institution
% + ZIB     - select ZIB as the institution
% + appl    - selects the title for an application areas
% ----------------------------------------------------------------------
%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{matheon-poster}[2009/11/16 v4.0]
%
\RequirePackage{ifthen}
%
% ----------------------------------------------------------------------
% ---------------------- Handle Options --------------------------------
% ----------------------------------------------------------------------
% @germanlanguage stores whether we use german as the language
% for titles etc.
%\newboolean{@germanlanguage}
%\setboolean{@germanlanguage}{false}
%
%\DeclareOption{german}{%
%  \setboolean{@germanlanguage}{true}%
%}
%\DeclareOption{english}{}  % do nothing since default is english
%
% Define option for application area posters
\newboolean{@applareaposter}
\setboolean{@applareaposter}{false}
%
\DeclareOption{appl}{%
  \setboolean{@applareaposter}{true}%
}
%
% We keep track of the number of institutions:
\newcounter{@numinst}
\setcounter{@numinst}{0}

\newcommand{\@defInstituteOption}[3] {%
  \DeclareOption{#1} {%
    \stepcounter{@numinst}%
    \ifthenelse{\value{@numinst}=1} {%
      \newcommand{\@insttext}{#2}%
      \newcommand{\@instlogo}{#3}%
    }{%
      \ifthenelse{\value{@numinst}=2}{%
        \newcommand{\@insttextTwo}{#2}%
        \newcommand{\@instlogoTwo}{#3}%
      }{%
        \ifthenelse{\value{@numinst}=3}{%
          \newcommand{\@insttextThree}{#2}%
          \newcommand{\@instlogoThree}{#3}%
        }{%
          \ifthenelse{\value{@numinst}=4}{%
            \newcommand{\@insttextFour}{#2}%
            \newcommand{\@instlogoFour}{#3}%
          }{}%
        }%
      }%
    }%
  }%
}

% Declare options for each institution
\@defInstituteOption{FU}
    %{Freie Universit\"at Berlin\\\@matheonurl{www.fu-berlin.de}}
    {Royal Institute of Technology \\ Stockholm}
    {\includegraphics[width=\linewidth]{SSC_Delft_new}}

\@defInstituteOption{HU}
%    {Humboldt-Universit\"at zu Berlin\\\@matheonurl{www.hu-berlin.de}}
    {Humboldt-Universit\"at zu Berlin}
    {\includegraphics[width=0.7\linewidth]{FAU}}
	
\@defInstituteOption{TU}
%    {Technische Universit\"at Berlin\\\@matheonurl{www.tu-berlin.de}}
    {Technische Universit\"at Berlin}
    {\includegraphics[width=0.7\linewidth]{TUBerlin}}


\ProcessOptions*\relax
%
% check whether the combination of options is valid
%
\newboolean{@twoinst}
\setboolean{@twoinst}{false}
\ifthenelse{\boolean{@applareaposter}}
{%
  \ifthenelse{\the@numinst>0}{%
    \ClassError{matheon-poster}{Selected application area poster, but supplied an institution!}{}%
  }{}%
}%
{%
  \ifthenelse{\value{@numinst}=0}{%
    \ClassError{matheon-poster}{No institution selected!}{Please choose FU,
      HU, TU, WIAS, or ZIB as an option to the class matheon-poster.}%
  }{%
    \ifthenelse{\value{@numinst}>4} {%
        \ClassError{matheon-poster}{This class can only handle at most four instiutions!}{}%
    }{ %
      \ifthenelse{\value{@numinst}>1}{\setboolean{@twoinst}{true} }{}%
    }%
  }%
}
%
% ----------------------------------------------------------------------
% ---------------------- Load Packages ---------------------------------
% ----------------------------------------------------------------------
%
% The following is based on the article class.  Maybe this dependence
% should be removed, but the article class defines many usefull commands
% that we otherwise would have to define newly.
\LoadClass[10pt,a4paper]{article}
%
%\if@germanlanguage
%  \RequirePackage[ngerman]{babel}
%\fi
%
% DIN-ISO-convertion (for german umlaute)
\RequirePackage[latin1]{inputenc}
%
% New font encoding (for hyphenization with umlaute)
\RequirePackage[T1]{fontenc}
%
% Use scalable postscript helvetica fonts
% We use the scaling in order to make characters in math mode
% and text mode about equal in size.
\RequirePackage[scaled=0.92]{helvet}
%
% URLs
\RequirePackage{url}
%
% For calculations within this class
\RequirePackage{calc}
%
% For including graphics
\RequirePackage[dvips]{graphicx}
%
% For colored text, background, etc.
\RequirePackage[dvips]{xcolor}
%
% We use the geometry package to set the size of the text etc.
\RequirePackage[a4paper,totalwidth=\paperwidth,totalheight=\paperheight]{geometry}
%
% For including the background picture
\RequirePackage[dvips,pscoord]{eso-pic}
%
% Turn on helvetica font
\AtBeginDocument{\sffamily}
%
% ----------------------------------------------------------------------
% ---------------------- Other Definitions -----------------------------
% ----------------------------------------------------------------------
%
% Turn of indentation of paragraphs
\setlength{\parindent}{0mm}
% modify the left margins for itemize, enumerate, etc.
\setlength{\leftmargini}{1.1em}
\setlength{\leftmarginii}{1em}
\setlength{\leftmarginiii}{0.9em}
\setlength{\leftmarginiv}{0.9em}
\setlength{\labelsep}{.25em}
%
% turn off page numbers
\pagestyle{empty}
%
% Define usefull font commands
\newcommand{\@matheontextfont}{\fontfamily{phv}\fontseries{m}\fontshape{n}\fontsize{7pt}{9pt}\selectfont}
\newcommand{\@matheonwwwfont}{\fontfamily{phv}\fontseries{m}\fontshape{n}\fontsize{7pt}{9pt}\selectfont}
\newcommand{\@matheonurl}[1]{{\@matheonwwwfont\bfseries\url{#1}}}
%
% Define the macro for including a background picture:
\newcommand{\bgpic}[1]{%
  \AddToShipoutPicture{%
    \setlength{\unitlength}{1mm}%
    \put(0,0){%
      \parbox[b][\paperheight][b]{\paperwidth}{%
       \vfill\centering
       \includegraphics[width=\paperwidth,height=\paperheight]{#1}%
       \vfill
     }%
   }%
  }%
}
% Same macro, put allow to change dimensions
\newcommand{\bgpicD}[3]{%
  \AddToShipoutPicture{%
    \setlength{\unitlength}{1mm}%
    \put(0,0){%
      \parbox[b][\paperheight][b]{\paperwidth}{%
       \vfill\centering
       \includegraphics[width=#1,height=#2]{#3}%
     }%
   }%
  }%
}
%
% Define some useful lengths
%
% \contentswidth and \contentsheight store the width and height,
% respectively, of the remaining space (i.e, without titlebox)
% on the poster.
%
% \@logotitleboxwidth is the width of the logo part in the title
\newlength{\@logotitleboxwidth}
\setlength{\@logotitleboxwidth}{0.15\textwidth}

\newlength{\@logotitleboxwidtha}
\setlength{\@logotitleboxwidtha}{0.25\textwidth}

\ifthenelse{\boolean{@applareaposter}} {
  \newlength{\@titleboxheight}
  \setlength{\@titleboxheight}{5cm}

  \newlength{\contentsheight}
  \setlength{\contentsheight}{\textheight}
  \addtolength{\contentsheight}{-\@titleboxheight}  % subtract titleheight
  \addtolength{\contentsheight}{-3pt}               % subtract white %separator line
}{
  % \@titleboxheight is the height of the title
  \newlength{\@totaltitleboxheight}
  \setlength{\@totaltitleboxheight}{5.6cm}
  \newlength{\@domainboxheight}
  \setlength{\@domainboxheight}{0.1\@totaltitleboxheight}
  \newlength{\@titleboxheight}
  % \setlength{\@titleboxheight}{5cm}
  \setlength{\@titleboxheight}{0.85\@totaltitleboxheight}
  
  \newlength{\contentsheight}
  \setlength{\contentsheight}{\textheight}
  \addtolength{\contentsheight}{-\@totaltitleboxheight}  % subtract totaltitleheight
  \addtolength{\contentsheight}{-4pt}               % subtract white separator lines
}

\newlength{\contentswidth}
\setlength{\contentswidth}{\textwidth}
\addtolength{\contentswidth}{-1.25pt}      % subtract small margin on the right
%
%
%
% ----------------------------------------------------------------------
% ---------------------- Color Definitions -----------------------------
% ----------------------------------------------------------------------
% Matheon blues
\definecolor{matheonblue}{rgb}{0.0,0.2,0.4}
\definecolor{matheonlightblue}{rgb}{0.15,0.35,0.55}
\definecolor{matheonlightestblue}{rgb}{0.48,0.7,1.000}
\definecolor{matheondomainblue}{rgb}{0.0,0.2,0.4}
%
\definecolor{matheondarkgray}{rgb}{0.85,0.85,0.85}
\definecolor{matheonlightgray}{rgb}{0.94,0.94,0.94}
%
% set page color
\pagecolor{matheonlightestblue}
%
% Set tab colors
\definecolor{tabcolor}{named}{matheonblue}
\definecolor{tabtextcolor}{named}{white}
%
% other useful colors
% Einige Farbdefinitionen, inclusive der Farbdefinitionen aus XFig
\definecolor{gray2}{gray}{0.85}
\definecolor{dimgray}{gray}{0.65}
\definecolor{light-gray}{gray}{0.79}
\definecolor{dark-gray}{gray}{0.1}
%
\definecolor{cyan}{rgb}{0.000,1.000,1.000}
\definecolor{magenta}{rgb}{1.000,0.000,1.000}
%
\definecolor{blue4}{rgb}{0.000,0.000,0.560}
\definecolor{blue3}{rgb}{0.000,0.000,0.690}
\definecolor{blue2}{rgb}{0.000,0.000,0.820}
\definecolor{ltblue}{rgb}{0.530,0.810,1.000}
%
\definecolor{green4}{rgb}{0.000,0.560,0.000}
\definecolor{green3}{rgb}{0.000,0.690,0.000}
\definecolor{green2}{rgb}{0.000,0.820,0.000}
%
\definecolor{cyan4}{rgb}{0.000,0.560,0.560}
\definecolor{cyan3}{rgb}{0.000,0.690,0.690}
\definecolor{cyan2}{rgb}{0.000,0.820,0.820}
%
\definecolor{red4}{rgb}{0.560,0.000,0.000}
\definecolor{red3}{rgb}{0.690,0.000,0.000}
\definecolor{red2}{rgb}{0.820,0.000,0.000}
%
\definecolor{magenta4}{rgb}{0.560,0.000,0.560}
\definecolor{magenta3}{rgb}{0.690,0.000,0.690}
\definecolor{magenta2}{rgb}{0.820,0.000,0.820}
%
\definecolor{brown4}{rgb}{0.500,0.190,0.000}
\definecolor{brown3}{rgb}{0.630,0.250,0.000}
\definecolor{brown2}{rgb}{0.750,0.380,0.000}
%
\definecolor{pink4}{rgb}{1.000,0.500,0.500}
\definecolor{pink3}{rgb}{1.000,0.630,0.630}
\definecolor{pink2}{rgb}{1.000,0.750,0.750}
\definecolor{pink}{rgb}{1.000,0.880,0.880}
%
\definecolor{gold}{rgb}{1.000,0.840,0.000}
%
% ----------------------------------------------------------------------
% ------------- Setting the Title - Project Variant --------------------
% ----------------------------------------------------------------------
%
% Sets up the texts for the titlebox depending on the language
%\ifthenelse{\boolean{@germanlanguage}}{%
%  \newcommand{\@MatheonText}{%
%    \@matheontextfont
%    DFG-Forschungszentrum\\
%    \textsc{Matheon}\\
%    Mathematik f\"ur Schl\"usseltechnologien\\
%    \@matheonurl{www.matheon.de}
%  }%
%}{%
  \newcommand{\@MatheonText}{%
    \centering
    \@matheontextfont
    %Sponsored by:
    %\\ \vspace{0.2cm}
    \includegraphics[scale=0.6]{TU_d_line_P1_full_color}\\
    \includegraphics[scale=0.3]{SIAM_blueRGB}
    %\@matheontextfont
    %\\ \vspace{0.2cm}
    %Project Course in\\
    %Scientific Computing\\
    %\vspace{0.2cm}
    %Supervised by J. Oppelstrup
    %\vspace{0.8cm}
    %\@matheonurl{DN 2295}
  }
%}
%
% \@titlebox{ domain of expertise }{ project name }{ title }{ list of persons }
% prints the titlebox of the poster
\newcommand{\@titlebox}[4]{%
  % prepare the sizes
  \newlength{\@texttitleboxwidth}%
  \setlength{\@texttitleboxwidth}{\textwidth}%
  % subtract space needed for the logos
  \ifthenelse{\value{@numinst}<3}%
    {\addtolength{\@texttitleboxwidth}{-2.25\@logotitleboxwidth}}%
    {\addtolength{\@texttitleboxwidth}{-2.75\@logotitleboxwidth}}%
  % subtract space needed for the vertical rules
  \addtolength{\@texttitleboxwidth}{-4pt}%
  % ---------------------------------------------------------------
 \parbox[b]{\textwidth}{%
   \color{white}%
   % set Matheon logo on the left
   \setlength{\fboxsep}{0ex}%
   \setlength{\fboxrule}{0pt}%
   \colorbox{matheonlightblue}{%
     \parbox[t][\@titleboxheight][c]{0.9\@logotitleboxwidth}{%
       \centering
       % set Matheon logo
       %\includegraphics[width=0.7\linewidth]{matheon_logo}\\
       \vspace{1.5ex}
       % set text
       \@MatheonText
     }%
   }%
   \vrule width 2pt%
    %
    % set text in the middle
    \colorbox{matheonblue}{%
      \parbox[t][\@titleboxheight][c]{\@texttitleboxwidth}{%
        \centering
        % set project number (if not empty)
        \ifthenelse{\equal{#2}{}}{%
          \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{\small \mbox{}}
        }{%
          %\ifthenelse{\boolean{@germanlanguage}}{%
           % \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{\small \textbf{Projekt #2}}
          %}{%
           % \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{\small \textbf{Project #2}}
		     \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{\small \textbf{#2}}
          %}
        }
        % set project title
        \parbox[t][0.65\@titleboxheight][c]{0.96\linewidth}{%
          \LARGE
          \begin{flushleft}\textbf{#3}\end{flushleft}
        }
        % set persons
        \parbox[t][0.2\@titleboxheight][c]{0.96\linewidth}{%
          \normalsize%
          \begin{flushleft}#4\end{flushleft}%
        }%
      }%
    }%
    \vrule width 2pt%
    %
    % set logo(s) on the right    
    \colorbox{white}{%
      \ifthenelse{\value{@numinst}=1}{%
        \parbox[t][\@titleboxheight][t]{1.35\@logotitleboxwidth}{%
          % set institution logo
          \parbox[t][\@titleboxheight][c]{\linewidth}{%
            \centering
            \@instlogo \\
             %\vspace{1cm}
            %\@matheontextfont 
            www.tudelft.nl
               
          }
        }%
      }{%
        \ifthenelse{\value{@numinst}=2}{%
          \parbox[t][\@titleboxheight][t]{\@logotitleboxwidth}{%
            \centering%
            \parbox[t][\@titleboxheight][t]{0.75\@logotitleboxwidth}{%
              % set first institution logo
              \parbox[t][0.5\@titleboxheight][c]{\linewidth}{%
                \centering
                \@instlogo
              }\\%
              \parbox[t][0.5\@titleboxheight][c]{\linewidth}{%
                \centering
                \@instlogoTwo
              }%
            }%
          }%
        }{%
          \ifthenelse{\value{@numinst}=3}{%
            \parbox[t][\@titleboxheight][c]{1.5\@logotitleboxwidth}{ % 
               \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                 \centering
                 \@instlogo
               }%
               \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                 \centering
                 \@instlogoTwo
               }\\
               \centering
               \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                 \centering
                 \@instlogoThree
               }%
            }%
          }{%
            %set all four instituion logos
            \parbox[t][\@titleboxheight][c]{1.5\@logotitleboxwidth}{ % 
              \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                \centering
                \@instlogo
              }%
              \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                \centering
                \@instlogoTwo
              }\\
              \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                \centering
                \@instlogoThree
              }%
              \parbox[t][0.5\@titleboxheight][c]{0.75\@logotitleboxwidth}{%
                \centering
                \@instlogoFour
              }%
            }%
          }%
        }%
      }%
    }%
    \hrule height 1.5pt%
   % set DoE
   \colorbox{matheondomainblue}{%
     \parbox[t][\@domainboxheight][c]{\textwidth}{%
      \centering
        \parbox{0.95\textwidth}{%
	\textbf{Keywords: \ SIAM, \ TU Delft, \ Applied Mathematics, \ Computer Science, \ Social Activities, \ Interdisciplinary}
        }%
     }%
   }%
   \hrule height 2pt
  }
  \par
}
%
%
% ----------------------------------------------------------------------
% ------------- Setting the Title - Application Areas Variant ----------
% ----------------------------------------------------------------------
%
% \@titleboxAppl{ AA }{ titel }{ list of persons }
% prints the titlebox for an application area
\newcommand{\@titleboxAppl}[3]{%
  % prepare the sizes
  \newlength{\@texttitleboxwidth}%
  \setlength{\@texttitleboxwidth}{\textwidth}%
  % subtract space needed for the logos
  \addtolength{\@texttitleboxwidth}{-1.5\@logotitleboxwidth}%
  % subtract space needed for the vertical rules
  \addtolength{\@texttitleboxwidth}{-2pt}%
  % ---------------------------------------------------------------
  \parbox[b]{\textwidth}{%
    \color{white}%
    % set Matheon logo on the left
    \setlength{\fboxsep}{0ex}%
    \setlength{\fboxrule}{0pt}%
    \colorbox{matheonlightblue}{%
      \parbox[t][\@titleboxheight][c]{1.5\@logotitleboxwidth}{%
         \centering
         % set Matheon logo
         \includegraphics[height=0.5\@titleboxheight]{matheon_logo}\\
         \vspace{2ex}
         % set text
         \@MatheonText
      }%
    }%
    \vrule width 2pt%
    %
    % set text in the middle
    \colorbox{matheonblue}{%
      \parbox[t][\@titleboxheight][c]{\@texttitleboxwidth}{%
        \centering
        % set application area (no german version needed)
        \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{\small \textbf{Application Area #1}}
        % set project title
        \parbox[t][0.7\@titleboxheight][c]{0.96\linewidth}{%
          \ifthenelse{\value{@numinst}=2}{\LARGE}{\Huge}
          \begin{flushleft}\textbf{#2}\end{flushleft}
        }
        % set persons
        \parbox[t][0.15\@titleboxheight][c]{0.96\linewidth}{%
          \normalsize
          \begin{flushleft}#3\end{flushleft}%
        }%
      }%
    }%
    \hrule height 2pt
  }
  \par
}
%
\ifthenelse{\boolean{@applareaposter}}{%
  \newcommand{\titlebox}[3]{\@titleboxAppl{#1}{#2}{#3}}
}{%
  \newcommand{\titlebox}[4]{\@titlebox{#1}{#2}{#3}{#4}}
}
%
%
% ----------------------------------------------------------------------
% -------------------- Commands for Backward Compability ---------------
% ----------------------------------------------------------------------
%
\newcommand{\bghoffset}{%
  \ClassError{matheon-poster}{The command \protect\bghoffset\space is inactivated.\MessageBreak%
    It is not needed anymore.}{}%
}
\newcommand{\bgvoffset}{%
  \ClassError{matheon-poster}{The command \protect\bgvoffset\space is inactivated.\MessageBreak%
    It is not needed anymore.}{}%
}
\newcommand{\insttext}{%
  \ClassError{matheon-poster}{The command \protect\instext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\instlogo}{%
  \ClassError{matheon-poster}{The command \protect\inslogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\futext}{%
  \ClassError{matheon-poster}{The command \protect\futext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\fulogo}{%
  \ClassError{matheon-poster}{The command \protect\fulogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\hutext}{%
  \ClassError{matheon-poster}{The command \protect\hutext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\hulogo}{%
  \ClassError{matheon-poster}{The command \protect\hulogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\tutext}{%
  \ClassError{matheon-poster}{The command \protect\tutext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\tulogo}{%
  \ClassError{matheon-poster}{The command \protect\tulogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\zibtext}{%
  \ClassError{matheon-poster}{The command \protect\zibtext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\ziblogo}{%
  \ClassError{matheon-poster}{The command \protect\ziblogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\newcommand{\wiastext}{%
  \ClassError{matheon-poster}{The command \protect\wiastext\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}%
}
\newcommand{\wiaslogo}{%
  \ClassError{matheon-poster}{The command \protect\wiaslogo\space is inactivated.\MessageBreak%
    Please pass the institution in the class options.}{}%
}
\endinput
%%
%% End of file `matheon-poster.sty'.
