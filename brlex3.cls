%% brlex3.cls
%% Copyright 2025 Heliton Martins Reis Filho <helitonmrf@gmail.com>
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
% This work consists of the files brlex3.cls and brlex2-compat.sty
%
% Version 3.0 - Complete rewrite using LaTeX3 (expl3)
%
%% Referências normativas:
% Manual de Compilação da Legislação Brasileira. Câmara dos Deputados. 2012;
% Decreto nº 9191/2017, de 1º de novembro de 2017 (REVOGADO);
% Lei Complementar nº 95, de 26 de fevereiro de 1998.
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesExplClass{brlex3}
  {2025/01/09}
  {3.0}
  {Classe para formatação de textos legais brasileiros (LaTeX3)}

%% =============================================================================
%% LOAD BASE CLASS AND PACKAGES
%% =============================================================================

\LoadClassWithOptions{article}
\PassOptionsToClass{12pt}{article}

%% Load required packages
\RequirePackage{iftex}
\ifxetex
  \RequirePackage{fontspec}
  \RequirePackage{polyglossia}
  \setmainlanguage{brazil}
\else
  \RequirePackage[utf8]{inputenc}
  \RequirePackage[brazil]{babel}
\fi

\RequirePackage{fmtcount}
\RequirePackage{geometry}
\RequirePackage{hyperref}

%% Typography settings from br-lex.cls
\widowpenalty 1000
\clubpenalty  1000
\displaywidowpenalty 1000

%% =============================================================================
%% EXPL3 CODE BEGINS
%% =============================================================================

\ExplSyntaxOn

%% -----------------------------------------------------------------------------
%% MESSAGE SYSTEM
%% -----------------------------------------------------------------------------

\msg_new:nnn { brlex } { calibri-requires-xetex }
  {
    A~opção~'calibri'~requer~XeLaTeX~ou~LuaLaTeX.~
    Para~continuar~usando~pdfLaTeX,~remova~a~opção~'calibri'.
  }

\msg_new:nnn { brlex } { deprecated-command }
  {
    O~comando~'#1'~está~obsoleto.~
    Use~'#2'~em~vez~disso.~
    A~sintaxe~antiga~será~removida~no~brlex4.
  }

%% -----------------------------------------------------------------------------
%% VARIABLES AND CONSTANTS
%% -----------------------------------------------------------------------------

%% Boolean options
\bool_new:N \l__brlex_indent_bool
\bool_new:N \l__brlex_calibri_bool
\bool_new:N \l__brlex_artbold_bool
\bool_new:N \l__brlex_usetitle_bool
\bool_new:N \l__brlex_useitalic_bool

%% Document metadata
\tl_new:N \l__brlex_epigrafe_tl
\tl_new:N \l__brlex_ementa_tl
\tl_new:N \l__brlex_preambulo_tl
\tl_new:N \l__brlex_enunciado_tl
\tl_new:N \l__brlex_autor_tl
\tl_new:N \l__brlex_data_tl

%% Dimensions
\dim_new:N \l__brlex_parskip_dim
\dim_new:N \l__brlex_parindent_dim
\dim_new:N \l__brlex_inciso_indent_dim
\dim_new:N \l__brlex_inciso_indent_after_par_dim
\dim_new:N \l__brlex_alinea_indent_dim
\dim_new:N \l__brlex_item_indent_dim

%% Set default dimensions
\dim_set:Nn \l__brlex_parskip_dim { 6pt }
\dim_set:Nn \l__brlex_parindent_dim { 0pt }
\dim_set:Nn \l__brlex_inciso_indent_dim { 2em }
\dim_set:Nn \l__brlex_inciso_indent_after_par_dim { 3.5em }
\dim_set:Nn \l__brlex_alinea_indent_dim { 5em }
\dim_set:Nn \l__brlex_item_indent_dim { 6.5em }

%% -----------------------------------------------------------------------------
%% OPTIONS SYSTEM
%% -----------------------------------------------------------------------------

\keys_define:nn { brlex }
  {
    %% Legacy boolean options
    indent .bool_set:N = \l__brlex_indent_bool,
    indent .initial:n = false,
    
    calibri .bool_set:N = \l__brlex_calibri_bool,
    calibri .initial:n = false,
    
    artbold .bool_set:N = \l__brlex_artbold_bool,
    artbold .initial:n = false,
    
    usetitle .bool_set:N = \l__brlex_usetitle_bool,
    usetitle .initial:n = false,
    
    useitalic .bool_set:N = \l__brlex_useitalic_bool,
    useitalic .initial:n = false,
    
    %% Modern key-value options (aliases)
    font .choice:,
    font / calibri .code:n = { \bool_set_true:N \l__brlex_calibri_bool },
    font / default .code:n = { \bool_set_false:N \l__brlex_calibri_bool },
    
    article-bold .bool_set:N = \l__brlex_artbold_bool,
    title-bold .bool_set:N = \l__brlex_usetitle_bool,
    
    emphasis .choice:,
    emphasis / bold .code:n = { \bool_set_false:N \l__brlex_useitalic_bool },
    emphasis / italic .code:n = { \bool_set_true:N \l__brlex_useitalic_bool },
  }

%% Process class options
\ProcessKeysOptions { brlex }

%% Apply indent option
\bool_if:NT \l__brlex_indent_bool
  {
    \dim_set:Nn \l__brlex_parskip_dim { 0pt }
  }

%% Apply calibri option
\bool_if:NT \l__brlex_calibri_bool
  {
    \ifpdftex
      \msg_warning:nn { brlex } { calibri-requires-xetex }
      \RequireLuaTeX
    \fi
    \AtBeginDocument { \setmainfont{Calibri} }
  }

%% Apply useitalic option
\bool_if:NF \l__brlex_useitalic_bool
  {
    % By default, \emph uses bold instead of italic
    \DeclareTextFontCommand{\emph}{\bfseries}
  }

%% Set paragraph formatting
\setlength{\parskip}{\l__brlex_parskip_dim}
\setlength{\parindent}{\l__brlex_parindent_dim}

%% -----------------------------------------------------------------------------
%% TEXT PROCESSING FUNCTIONS
%% -----------------------------------------------------------------------------

%% Make text uppercase (language-aware)
\cs_new:Npn \brlex_text_uppercase:n #1
  {
    \text_uppercase:n {#1}
  }

\cs_generate_variant:Nn \brlex_text_uppercase:n { V }

%% Check if token list is empty
\prg_new_conditional:Npnn \brlex_tl_if_empty:n #1 { p, T, F, TF }
  {
    \tl_if_empty:nTF {#1}
      { \prg_return_true: }
      { \prg_return_false: }
  }

%% -----------------------------------------------------------------------------
%% COUNTER MANAGEMENT
%% -----------------------------------------------------------------------------

%% Structure counters
\int_new:N \g__brlex_parte_int
\int_new:N \g__brlex_livro_int
\int_new:N \g__brlex_titulo_int
\int_new:N \g__brlex_capitulo_int
\int_new:N \g__brlex_secao_int
\int_new:N \g__brlex_subsecao_int

%% Dispositivos counters
\int_new:N \g__brlex_artigo_int
\int_new:N \g__brlex_artigoletra_int
\int_new:N \g__brlex_paragrafo_int
\int_new:N \g__brlex_inciso_int
\int_new:N \g__brlex_alinea_int
\int_new:N \g__brlex_item_int

%% Reset functions for hierarchical counters
\cs_new:Nn \brlex_reset_livro:
  {
    \int_gzero:N \g__brlex_livro_int
  }

\cs_new:Nn \brlex_reset_titulo:
  {
    \int_gzero:N \g__brlex_titulo_int
    \brlex_reset_livro:
  }

\cs_new:Nn \brlex_reset_capitulo:
  {
    \int_gzero:N \g__brlex_capitulo_int
    \brlex_reset_titulo:
  }

\cs_new:Nn \brlex_reset_secao:
  {
    \int_gzero:N \g__brlex_secao_int
    \brlex_reset_capitulo:
  }

\cs_new:Nn \brlex_reset_subsecao:
  {
    \int_gzero:N \g__brlex_subsecao_int
    \brlex_reset_secao:
  }

\cs_new:Nn \brlex_reset_paragrafo:
  {
    \int_gzero:N \g__brlex_paragrafo_int
  }

\cs_new:Nn \brlex_reset_inciso:
  {
    \int_gzero:N \g__brlex_inciso_int
  }

\cs_new:Nn \brlex_reset_alinea:
  {
    \int_gzero:N \g__brlex_alinea_int
  }

\cs_new:Nn \brlex_reset_item:
  {
    \int_gzero:N \g__brlex_item_int
  }

%% -----------------------------------------------------------------------------
%% FORMATTING FUNCTIONS
%% -----------------------------------------------------------------------------

%% Apply bold formatting conditionally
\cs_new:Nn \brlex_format_artbold:n
  {
    \bool_if:NTF \l__brlex_artbold_bool
      { \textbf{#1} }
      { #1 }
  }

%% Format hanging indent for dispositivos
\cs_new:Nn \brlex_format_hangindent:n
  {
    \bool_if:NT \l__brlex_indent_bool
      {
        \hangindent = #1
        \hangafter = 0
      }
  }

%% -----------------------------------------------------------------------------
%% DOCUMENT STRUCTURE COMMANDS
%% -----------------------------------------------------------------------------

%% Parte (Part)
\cs_new:Nn \brlex_parte_romano:n
  {
    \int_gincr:N \g__brlex_parte_int
    \begin{center}
      PARTE~\int_to_Roman:n { \g__brlex_parte_int } \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{part}
      {
        PARTE~\int_to_Roman:n { \g__brlex_parte_int }~--~
        \brlex_text_uppercase:n {#1}
      }
  }

\cs_new:Nn \brlex_parte_extenso:n
  {
    \int_gincr:N \g__brlex_parte_int
    \begin{center}
      PARTE~\ORDINALstring{\g__brlex_parte_int}[f] \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{part}
      {
        PARTE~\ORDINALstring{\g__brlex_parte_int}[f]~--~
        \brlex_text_uppercase:n {#1}
      }
  }

\NewDocumentCommand \parte { s m }
  {
    \IfBooleanTF {#1}
      { \brlex_parte_extenso:n {#2} }
      { \brlex_parte_romano:n {#2} }
  }

%% Parte Geral / Parte Especial
\NewDocumentCommand \partegeral { m }
  {
    \begin{center}
      PARTE~GERAL \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{part}
      { PARTE~GERAL~--~\brlex_text_uppercase:n {#1} }
  }

\NewDocumentCommand \parteespecial { m }
  {
    \begin{center}
      PARTE~ESPECIAL \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{part}
      { PARTE~ESPECIAL~--~\brlex_text_uppercase:n {#1} }
  }

%% Livro (Book)
\NewDocumentCommand \livro { m }
  {
    \int_gincr:N \g__brlex_livro_int
    \begin{center}
      LIVRO~\int_to_Roman:n { \g__brlex_livro_int } \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{chapter}
      {
        LIVRO~\int_to_Roman:n { \g__brlex_livro_int }~--~
        \brlex_text_uppercase:n {#1}
      }
  }

%% Título (Title)
\NewDocumentCommand \titulo { m }
  {
    \int_gincr:N \g__brlex_titulo_int
    \begin{center}
      TÍTULO~\int_to_Roman:n { \g__brlex_titulo_int } \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{section}
      {
        TÍTULO~\int_to_Roman:n { \g__brlex_titulo_int }~--~
        \brlex_text_uppercase:n {#1}
      }
  }

%% Capítulo (Chapter)
\NewDocumentCommand \capitulo { m }
  {
    \int_gincr:N \g__brlex_capitulo_int
    \begin{center}
      CAPÍTULO~\int_to_Roman:n { \g__brlex_capitulo_int } \par
      \brlex_text_uppercase:n {#1} \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{subsection}
      {
        CAPÍTULO~\int_to_Roman:n { \g__brlex_capitulo_int }~--~
        \brlex_text_uppercase:n {#1}
      }
  }

%% Seção (Section)
\NewDocumentCommand \secao { m }
  {
    \int_gincr:N \g__brlex_secao_int
    \begin{center}
      \bfseries
      Seção~\int_to_Roman:n { \g__brlex_secao_int } \par
      #1 \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{subsubsection}
      { Seção~\int_to_Roman:n { \g__brlex_secao_int }~--~#1 }
  }

%% Subseção (Subsection)
\NewDocumentCommand \subsecao { m }
  {
    \int_gincr:N \g__brlex_subsecao_int
    \begin{center}
      \bfseries
      Subseção~\int_to_Roman:n { \g__brlex_subsecao_int } \par
      #1 \vspace{1ex}
    \end{center}
    \addcontentsline{toc}{paragraph}
      { Subseção~\int_to_Roman:n { \g__brlex_subsecao_int }~--~#1 }
  }

%% Tema (Theme/Subject)
\NewDocumentCommand \tema { m }
  {
    \par\noindent\textbf{#1}\par
    \addcontentsline{toc}{subparagraph}{#1}
  }

%% -----------------------------------------------------------------------------
%% DISPOSITIVOS (LEGAL PROVISIONS)
%% -----------------------------------------------------------------------------

%% Artigo (Article)
\NewDocumentCommand \artigo { }
  {
    \int_gincr:N \g__brlex_artigo_int
    \int_gzero:N \g__brlex_artigoletra_int
    \brlex_reset_inciso:
    \par
    \int_compare:nNnTF { \g__brlex_artigo_int } < { 10 }
      {
        \brlex_format_artbold:n 
          { Art.~\int_use:N \g__brlex_artigo_int º~~ }
      }
      {
        \brlex_format_artbold:n 
          { Art.~\int_use:N \g__brlex_artigo_int .~~ }
      }
  }

%% Artigo com letra (Article with letter suffix)
\NewDocumentCommand \artX { }
  {
    \int_gincr:N \g__brlex_artigoletra_int
    \brlex_reset_inciso:
    \par
    \brlex_format_artbold:n
      {
        Art.~\int_use:N \g__brlex_artigo_int -
        \int_to_Alph:n { \g__brlex_artigoletra_int } .~~
      }
  }

%% Parágrafo (Paragraph)
\NewDocumentCommand \paragrafo { }
  {
    \int_gincr:N \g__brlex_paragrafo_int
    \par
    \brlex_format_hangindent:n { 2em }
    \int_compare:nNnTF { \g__brlex_paragrafo_int } < { 10 }
      {
        \brlex_format_artbold:n 
          { §~\int_use:N \g__brlex_paragrafo_int º~~ }
      }
      {
        \brlex_format_artbold:n 
          { §~\int_use:N \g__brlex_paragrafo_int .~~ }
      }
  }

%% Parágrafo único (Single paragraph)
\NewDocumentCommand \paragrafounico { }
  {
    \par
    \brlex_format_hangindent:n { 2em }
    \brlex_format_artbold:n { Parágrafo~único. }~~
  }

%% Inciso (Item/Clause)
\NewDocumentCommand \inciso { }
  {
    \int_gincr:N \g__brlex_inciso_int
    \brlex_reset_alinea:
    \par
    \int_compare:nNnTF { \g__brlex_paragrafo_int } = { 0 }
      {
        \brlex_format_hangindent:n { \l__brlex_inciso_indent_dim }
      }
      {
        \brlex_format_hangindent:n { \l__brlex_inciso_indent_after_par_dim }
      }
    \brlex_format_artbold:n 
      { \int_to_Roman:n { \g__brlex_inciso_int }~---~ }
  }

%% Alínea (Subitem)
\NewDocumentCommand \alinea { }
  {
    \int_gincr:N \g__brlex_alinea_int
    \brlex_reset_item:
    \par
    \brlex_format_hangindent:n { \l__brlex_alinea_indent_dim }
    \brlex_format_artbold:n 
      { \int_to_alph:n { \g__brlex_alinea_int } )~~ }
  }

%% Item (Sub-subitem)
\NewDocumentCommand \itens { }
  {
    \int_gincr:N \g__brlex_item_int
    \par
    \brlex_format_hangindent:n { \l__brlex_item_indent_dim }
    \brlex_format_artbold:n 
      { \int_use:N \g__brlex_item_int .~~ }
  }

%% -----------------------------------------------------------------------------
%% PRELIMINARY PART COMMANDS
%% -----------------------------------------------------------------------------

%% Epígrafe (Epigraph/Title)
\NewDocumentCommand \epigrafe { m }
  {
    \tl_gset:Nn \l__brlex_epigrafe_tl {#1}
    \begin{center}
      \centering \large
      \bool_if:NT \l__brlex_usetitle_bool { \bfseries }
      \brlex_text_uppercase:n {#1}
    \end{center}
    \thispagestyle{plain}
  }

%% Redefine \title to use \epigrafe
\RenewDocumentCommand \title { m }
  {
    \AtBeginDocument { \epigrafe{#1} }
  }

%% Ementa (Summary/Abstract)
\NewDocumentCommand \ementa { m }
  {
    \tl_gset:Nn \l__brlex_ementa_tl {#1}
    \hfill
    \begin{minipage}{9cm}
      #1
    \end{minipage}
    \vspace{\baselineskip}\par
  }

%% Preâmbulo (Preamble)
\NewDocumentCommand \preambulo { o m }
  {
    \tl_gset:Nn \l__brlex_preambulo_tl {#2}
    \IfNoValueTF {#1}
      {
        \tl_gclear:N \l__brlex_enunciado_tl
        \noindent #2
      }
      {
        \tl_gset:Nn \l__brlex_enunciado_tl {#1}
        \noindent\textbf{#1}~~#2
      }
    \vspace{2ex}
  }

%% -----------------------------------------------------------------------------
%% METADATA AND PDF SETUP
%% -----------------------------------------------------------------------------

%% Set PDF metadata
\NewDocumentCommand \metadata { }
  {
    \hypersetup
      {
        pdftitle = { \l__brlex_epigrafe_tl },
        pdfauthor = { \@author },
        pdfsubject = { \l__brlex_ementa_tl },
        pdfproducer = { LaTeX },
        pdfcreator = { brlex3~with~LaTeX3 }
      }
  }

%% Page geometry
\geometry{a4paper, lmargin=3cm, rmargin=2cm, vmargin=2.5cm}

%% -----------------------------------------------------------------------------
%% UTILITIES
%% -----------------------------------------------------------------------------

%% Strikethrough text (for revoked/vetoed provisions)
\RequirePackage{ulem}
\normalem % Prevent \emph from underlining

\NewDocumentCommand \cortado { m }
  {
    \sout{#1}
  }

%% -----------------------------------------------------------------------------
%% LEGACY COMMAND SHORTCUTS
%% -----------------------------------------------------------------------------

%% Maintain backward compatibility with brlex2
\cs_set_eq:NN \art \artigo
\cs_set_eq:NN \parag \paragrafo
\cs_set_eq:NN \so \paragrafo
\cs_set_eq:NN \parun \paragrafounico
\cs_set_eq:NN \inc \inciso
\cs_set_eq:NN \itm \itens

%% -----------------------------------------------------------------------------
%% SECTIONING DEPTH
%% -----------------------------------------------------------------------------

\setcounter{secnumdepth}{7}
\setcounter{tocdepth}{7}

\ExplSyntaxOff

%% =============================================================================
%% END OF CLASS
%% =============================================================================

\endinput
