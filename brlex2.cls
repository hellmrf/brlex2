%% brlex2.cls
%% Copyright 2023 Heliton Martins Reis Filho <helitonmrf@gmail.com>
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License, either version 1.3
% of this license or (at your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3c or later is part of all distributions of LaTeX
% version 2008 or later.
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Heliton Martins Reis Filho
%
% This work consists of the files brlex2.cls


%% Referências normativas:
% Manual de Compilação da Legislação Brasileira. Câmara dos Deputados. 2012;
% Decreto nº 9191/2017, de 1º de novembro de 2017;
% Lei Complementar nº 95, de 26 de fevereiro de 1998.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{brlex2}[2023/04/21 Classe para formatação de textos legais.]
\LoadClassWithOptions{article}
\PassOptionsToClass{12pt}{article}
% \ExplSyntaxOn

% Copied from br-lex.cls
\widowpenalty 1000
\clubpenalty  1000
\displaywidowpenalty 1000

\RequirePackage{iftex}
\ifxetex
\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setmainlanguage{brazil}
\else
\RequirePackage[utf8]{inputenc}
\RequirePackage[brazil]{babel}
\fi

\RequirePackage{textcase}
\RequirePackage{fmtcount}
\RequirePackage{geometry}
\RequirePackage{hyperref}

% End of copy

\def\ifempty#1{\def\temp{#1}\ifx\temp\empty}


% INDENT: se deve condensar o texto usando indentação em vez de linhas em branco.
\newif\ifindent
\DeclareOption{indent}{%
    \indenttrue
    \setlength{\parskip}{0pt}%
}
\ifindent\else
    \setlength{\parskip}{6pt}%
    \setlength{\parindent}{0pt}%
\fi

%% CALIBRI: usa a fonte calibri, conforme Decreto nº 9191/2017.
% Desativado por padrão pois não funciona com pdfLaTeX e exige a fonte instalada.
\DeclareOption{calibri}{%
    \ifpdftex
        \ExplSyntaxOn
        \PackageWarningNoLine{brlex2}{Para utilizar calibri, compile com XeLaTeX ou LuaLaTeX. Para continuar usando pdfLaTeX, retire a opção calibri.}
        \ExplSyntaxOff
        \RequireLuaTeX
    \fi
    \AtBeginDocument{\setmainfont{Calibri}}
}

%% ARTBOLD: coloca os artigos em negrito
\newif\ifartbold
\DeclareOption{artbold}{\artboldtrue}

%% USETITLE: coloca a epígrafe (ou \title) em negrito. útil para a redação de outras espécies, como estatutos, por exemplo.
\newif\ifusetitle
\DeclareOption{usetitle}{\usetitletrue}

%% USEITALIC: permite o uso padrão de \emph (como itálico).
% Desativado por padrão pois contraria o Decreto nº 9191/2017.
\DeclareTextFontCommand{\oldemph}{\em}
\let\emph\textbf\relax
\DeclareOption{useitalic}{\let\emph\relax\let\oldemph\relax \DeclareTextFontCommand{\emph}{\em}}


\ProcessOptions\relax














%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%
%%  PARTE PRELIMINAR %%
%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%



\def\@epigrafe{}
\newcommand{\epigrafe}[1]{ % LEI Nº XXX/XXXX ou Título geral do documento
    \def\@epigrafe{#1}
    \begin{center}
        \centering \large \ifusetitle\bfseries\fi \MakeUppercase{\@epigrafe}
    \end{center}
    \thispagestyle{plain}%
}

\renewcommand*{\title}[1]{\AtBeginDocument{\epigrafe{#1}}}

\def\@ementa{}
\newcommand{\ementa}[1]{\hfill% % Descreve o objeto do texto.
    \def\@ementa{#1}
    \begin{minipage}{9cm}
        \@ementa
    \end{minipage}
    \vspace{\baselineskip}\par
}

\def\@preambulo{}
\def\@enunciado{}
\newcommand{\preambulo}[2][]{%
    \def\@preambulo{#2}
    \def\@enunciado{#1}
    \ifempty{\@enunciado}%
        \noindent\@preambulo%
    \else%
        \noindent\textbf{\@enunciado}~~\@preambulo%
    \fi
    \vspace{2ex}
}



%%%%%
%%%%% DIVISÃO DO TEXTO: LIVROS, PARTES, TÍTULOS, CAPÍTULOS, SEÇÕES, SUBSEÇÕES
%%%%%

\newcounter{parte}
\newcounter{livro}[parte]
\newcounter{titulo}[livro]
\newcounter{capitulo}[titulo]
\newcounter{secao}[capitulo]
\newcounter{subsecao}[secao]

\newcommand*{\@parteromano}[1]{\refstepcounter{parte}
    \begin{center}
        PARTE \Roman{parte}\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}
\newcommand*{\@parteextenso}[1]{\refstepcounter{parte}
    \begin{center}
        PARTE \ORDINALstring{parte}[f]\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}
\newcommand*{\parte}{\@ifstar{\@parteextenso}{\@parteromano}}

\newcommand*{\partegeral}[1]{
    \begin{center}
        PARTE GERAL\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}

\newcommand*{\parteespecial}[1]{
    \begin{center}
        PARTE ESPECIAL\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}


\newcommand*{\livro}[1]{\refstepcounter{livro}
    \begin{center}
        LIVRO \Roman{livro}\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}

\newcommand*{\titulo}[1]{\refstepcounter{titulo}
    \begin{center}
        TÍTULO \Roman{titulo}\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}

\newcommand*{\capitulo}[1]{\refstepcounter{capitulo}
    \begin{center}
        CAPÍTULO \Roman{capitulo}\par
        \MakeUppercase{#1}\vspace{1ex}
    \end{center}
}

\newcommand*{\secao}[1]{\refstepcounter{secao}
    \begin{center}
        \bfseries
        Seção \Roman{secao}\par
        #1\vspace{1ex}
    \end{center}
}

\newcommand*{\subsecao}[1]{\refstepcounter{subsecao}
    \begin{center}
        \bfseries
        Subseção \Roman{subsecao}\par
        #1\vspace{1ex}
    \end{center}
}

\newcommand*{\tema}[1]{\par\noindent\textbf{#1} \par}










%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%
%%  PARTE NORMATIVA %%
%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%

% Adaptado de br-lex.cls

\newcounter{artigo}
\newcommand{\artigo}{\refstepcounter{artigo} % 
    \par
    \ifnum\theartigo<10%
        {\ifartbold\bfseries\fi Art.~\arabic{artigo}º~~}%
    \else%
        {\ifartbold\bfseries\fi Art.~\arabic{artigo}.~~}%
    \fi%
    \setcounter{inciso}{0}%
}
\newcounter{artigoletra}[artigo]
\newcommand{\artX}{\refstepcounter{artigoletra} % 
    \par%
    {%
        \ifartbold\bfseries\fi%
        {Art.~\arabic{artigo}-\Alph{artigoletra}.~~}%%
    }%
    \setcounter{inciso}{0}%
}

\newcounter{paragrafo}[artigo]
\newcommand{\paragrafo}{\refstepcounter{paragrafo}%
    \par%
    \ifindent\hangindent=2em \hangafter=0 \fi{%
        \ifartbold\bfseries\fi%
        \ifnum\theparagrafo<10%
            \S~\arabic{paragrafo}º~~%
        \else%
            \S~\arabic{paragrafo}.~~%
        \fi%
    }%
}

\newcommand{\paragrafounico}{\ifindent\hangindent=2em \hangafter=0 \fi {\ifartbold\bfseries\fi Parágrafo único.}~~}

\newcounter{inciso}[paragrafo]
\newcommand{\inciso}{\refstepcounter{inciso}% 
    \newlength{\tempincisomarginleftifparagrafo}%
    \par%
    \ifnum\theparagrafo=0%
        \setlength{\tempincisomarginleftifparagrafo}{2em}%
    \else%
        \setlength{\tempincisomarginleftifparagrafo}{3.5em}%
    \fi%
    \ifindent\hangindent=\tempincisomarginleftifparagrafo \hangafter=0 \fi%
    {\ifartbold\bfseries\fi\Roman{inciso}~---~}%
    \let\tempincisomarginleftifparagrafo\relax
}

\newcounter{alinea}[inciso]
\newcommand{\alinea}{\refstepcounter{alinea}%
    \par%
    \ifindent\hangindent=5em \hangafter=0 \fi%
    {\ifartbold\bfseries\fi\alph{alinea})~~}%
}

\newcounter{itens}[alinea]
\newcommand{\itens}{\refstepcounter{itens}% 
    \par%
    \ifindent\hangindent=6.5em \hangafter=0 \fi%
    {\ifartbold\bfseries\fi\arabic{itens}.~~}%
}













%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%
%% PDF SETUP %%
%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%

\newcommand*{\metadata}{
    \hypersetup{pdftitle={\@epigrafe},
        pdfauthor={\@author},
        pdfsubject={\@ementa},
        pdfproducer={LaTeX},
        pdfcreator={brlex2 with LaTeX}
    }
}
\geometry{a4paper, lmargin=3cm, rmargin=2cm, vmargin=2.5cm}

















%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%
%% UTILITÁRIOS %%
%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%

% risca partes do texto
\newcommand{\cortado}[1]{\sout{#1}}

% atalhos de comandos
\let\art\artigo\relax
\let\parag\paragrafo\relax
\let\so\paragrafo\relax
\let\parun\paragrafounico\relax
\let\inc\inciso\relax
\let\itm\itens\relax