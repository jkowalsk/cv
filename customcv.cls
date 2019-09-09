%%
%% @author: Julien Kowalski.
%%
%% largely inspired by https://github.com/spagnuolocarmine/TwentySecondsCurriculumVitae-LaTex/ :


\ProvidesClass{customcv}[2019/03/13 CV class]
\LoadClass{article}
\NeedsTeXFormat{LaTeX2e}

%----------------------------------------------------------------------------------------
%	 REQUIRED PACKAGES
%-----------------------------------------------------------------------	-----------------

\RequirePackage[quiet]{fontspec}
\RequirePackage[sfdefault]{roboto}

\RequirePackage{pstricks}
\RequirePackage{fontawesome}
\RequirePackage{tikz}
\RequirePackage{xcolor}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{ifthen}
\RequirePackage{parskip}
\RequirePackage{titlesec}


\RequirePackage[hidelinks]{hyperref}
\RequirePackage{pbox}

\RequirePackage[french]{babel}
\RequirePackage{csquotes}
\RequirePackage{biblatex}
\RequirePackage{multicol}

%----------------------------------------------------------------------------------------
%	 MARGINS AND LINKS
%----------------------------------------------------------------------------------------

\RequirePackage[left=0.34\paperwidth,top=0.1cm,right=1cm,bottom=0.1cm,nohead,nofoot]{geometry}


\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax


%----------------------------------------------------------------------------------------
%	 COLOURS
%----------------------------------------------------------------------------------------
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{cvblue}{HTML}{0E5484}

%% program skills colors
\definecolor{skillgray}{HTML}{B9B9B9}
\colorlet{skillblue}{cvblue}
%% icons colors
\definecolor{linkedin}{HTML}{0085AE}
\definecolor{site}{HTML}{0077be}
\definecolor{mail}{HTML}{c71610}

%----------------------------------------------------------------------------------------
%	 MISC CONFIGURATIONS
%----------------------------------------------------------------------------------------
\hypersetup{
  colorlinks=true,           % no lik border color
  allbordercolors=white,      % white border color for all
  urlcolor=cvblue,
  citecolor=black,
}

\setfontfamily{\FA}{[FontAwesome.otf]}

%----------------------------------------------------------------------------------------
%	 FANCIER 
%----------------------------------------------------------------------------------------
\RequirePackage[]{enumitem}
\setlist[itemize,1]{label={\color{cvblue}$\bullet$}}
\setlist[itemize,2]{label={\color{cvblue}$\circ$}}
\setlist[itemize,3]{label={\color{cvblue}$\triangleright$}}
%\renewcommand{\labelitemi}{}
%\renewcommand{\labelitemii}{\color{cvblue}$\circ$}

\AtBeginDocument{
  \pagestyle{empty}
  \setlength{\parindent}{0pt} % Disable paragraph indentation
}

\AtEndDocument{
  \vfill
  \renewcommand*{\bibfont}{\footnotesize}
  \printbibliography
}

%----------------------------------------------------------------------------------------
%	 SIDEBAR DEFINITIONS
%----------------------------------------------------------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

% Define custom commands for CV info
\newcommand{\cvdate}[1]{\renewcommand{\cvdate}{#1}}
\newcommand{\cvlinkedin}[1]{\renewcommand{\cvlinkedin}{#1}}
\newcommand{\cvgithub}[1]{\renewcommand{\cvgithub}{#1}}
\newcommand{\cvmail}[1]{\renewcommand{\cvmail}{#1}}
\newcommand{\cvnumberphone}[1]{\renewcommand{\cvnumberphone}{#1}}
\newcommand{\cvaddress}[1]{\renewcommand{\cvaddress}{#1}}
\newcommand{\cvsite}[1]{\renewcommand{\cvsite}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\cvname}[1]{\renewcommand{\cvname}{#1}}
\newcommand{\cvjobtitle}[1]{\renewcommand{\cvjobtitle}{#1}}

\newcommand{\skillinternal}{}
\newcommand{\skills}[1]{\renewcommand{\skillinternal}{#1}}


% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=cvblue,cvblue,text=white] (char) {#1};}}

% Command for printing skill progress bars
\newcommand{\skillbarsinternal}{}
\newcommand\skillbars[1]{
  \renewcommand{\skillbarsinternal}{
    \begin{tikzpicture}
      \foreach [count=\i] \x/\y in {#1}{
          \draw[fill=skillgray,skillgray] (0,\i) rectangle (6,\i+0.4);
          \draw[fill=white,skillblue](0,\i) rectangle (\y,\i+0.4);
          \node [above right] at (0,\i+0.35) {\x};
        }
    \end{tikzpicture}
  }
}

\newcommand{\educationinternal}{}
\newcommand\education[1]{
  \renewcommand{\educationinternal}{
    {#1}
  }
}

%----------------------------------------------------------------------------------------
%  SIDEBAR LAYOUT
%----------------------------------------------------------------------------------------

%% arg1: icon ; arg2 : text
\newcommand{\printuserinfo}[2]{
   \item[#1]  #2
}

\newcommand{\printphone}{
  \ifthenelse{\equal{\cvnumberphone}{}}{}{
    \printuserinfo{\large \faMobile}{\href{tel:\cvnumberphone}{\cvnumberphone}}
  }
}

\newcommand{\printsite}{
  \ifthenelse{\equal{\cvsite}{}}{}{
    \printuserinfo{\color{site} \faGlobe}{\href{http://\cvsite}{\cvsite}}
  }
}

\newcommand{\printmail}{
  \ifthenelse{\equal{\cvmail}{}}{}{
    \printuserinfo{\color{mail} \faEnvelopeO}{\href{mailto:\cvmail}{\cvmail}}
  }
}

\newcommand{\printlinkedin}{
  \ifthenelse{\equal{\cvlinkedin}{}}{}{
    \printuserinfo{\color{linkedin} \faLinkedin}{\href{https://www.linkedin.com/in/\cvlinkedin}{\cvlinkedin}}
  }
}

\newcommand{\printgithub}{
  \ifthenelse{\equal{\cvgithub}{}}{}{
    \printuserinfo{\faGithub}{ \href{https://www.github.com/\cvgithub}{github.com/\cvgithub}}
  }
}

\newcommand{\sectrule}[2][0pt]{\leavevmode \leaders \hbox to 1pt{\rule[#1]{1pt}{#2}} \hfill \kern 0pt}
\newcommand{\profilesection}[1]{\vspace{8pt}{\color{black!70} \Large #1 \sectrule[1pt]{0.15\baselineskip}}\\}

\setlength{\TPHorizModule}{\paperwidth}
\setlength{\TPVertModule}{\paperheight}

\newcommand{\makeprofile}{
  \begin{tikzpicture}[remember picture,overlay]
    \node [rectangle, fill=sidecolor, anchor=north west, minimum width=0.33\paperwidth, minimum height=\paperheight] (box) at (current page.north west){};
  \end{tikzpicture}
  \begin{textblock}{0.3}(0.02, 0.02)
    \vbox to .97\textheight{
      {\Huge\color{cvblue}\textsc{\cvname}}\\
      {\Large\color{black!80}\cvjobtitle}
      %------------------------------------------------
      \vspace{3mm}
      {\footnotesize 
        \begin{itemize}[noitemsep,topsep=0pt,parsep=0pt,partopsep=0pt]
          \printphone
          \printmail
          \printsite
          \printgithub
          \printlinkedin
        \end{itemize}
      }
      %------------------------------------------------
      \par\vspace{3mm}
      \profilesection{Compétences}
      \skillinternal
      %------------------------------------------------
      \par\vspace{3mm}
      \skillbarsinternal
      %------------------------------------------------
      \ifthenelse{\equal{\educationinternal}{}}{}{
        \vfill
        \profilesection{Formation}
        \educationinternal
      }
    }
  \end{textblock}
}


%----------------------------------------------------------------------------------------
%	 COLOURED SECTION TITLE
%----------------------------------------------------------------------------------------
\newcommand{\formatsection}[1]{
  \rule[0.8pt]{1.5cm}{4pt}~#1~\sectrule[0.8pt]{4pt}
}

% \titleformat{〈command〉}[〈shape〉]{〈format〉}{〈label〉}{〈sep〉}{〈before-code〉}[〈after-code〉]
\titleformat{\section}
{\Large\scshape\bfseries\color{cvblue}}
{}{-0.8em}
{\formatsection}

\titleformat{\subsection}
{\large\color{gray}}
{}
{1em}
{}


\RequirePackage{smartdiagram}
\smartdiagramset{
  % set center bubble color
  bubble center node color = cvblue!80!sidecolor,
  % define the list of colors usable in the diagram
  %set color list = {lightgray, materialcyan, orange, green, materialorange, materialteal, materialamber, materialindigo, materialgreen, materiallime},
  % sets the opacity at which the bubbles are shown
  bubble fill opacity = 0.6,
  % sets the opacity at which the bubble text is shown
  bubble text opacity = 1,
}


\RequirePackage{tcolorbox}
\tcbuselibrary{skins,listings,xparse}

%----------------------------------------------------------------------------------------
%	 CV ENTRIES
%----------------------------------------------------------------------------------------

%% date ; job title ; company
\newcommand{\cvtitleformat}[3]{%
  \begin{tabular}{@{\extracolsep{4pt}}p{0.2\textwidth}p{0.7\textwidth}}
  #1 & \textbf{#2} \hfill {\footnotesize #3} \\
  \end{tabular}

}

%\newtcolorbox{cventry}[3]{%
%  sharp corners,
%  width=\textwidth,
%  coltitle=black,
%  colbacktitle=sidecolor!80,
%  colback=white,
%  title={\cvtitleformat{#1}{#2}{#3}},
%  colframe=cvblue,
%  leftrule=0mm, rightrule=0mm, toprule=0mm, bottomrule=0mm, titlerule=0mm,
%  left=0pt,
%  leftupper=0.05\textwidth,
%}

\newcommand{\cventrynobody}[3]{
  \par\colorbox{sidecolor!80}{
    \cvtitleformat{#1}{#2}{#3}
  }
}

\newenvironment{cventry}[3]{
	\par\cventrynobody{#1}{#2}{#3}
	\par
}{}
  