# Migration Guide: brlex2 → brlex3

This guide helps you migrate your documents from brlex2 to brlex3. The good news: for most documents, migration is trivial!

## Table of Contents
- [Quick Start](#quick-start)
- [Why Upgrade?](#why-upgrade)
- [Basic Migration](#basic-migration)
- [Options Migration](#options-migration)
- [Command Reference](#command-reference)
- [Advanced Topics](#advanced-topics)
- [Troubleshooting](#troubleshooting)

---

## Quick Start

### Minimal Migration

For most documents, only one change is needed:

```latex
% Change this:
\documentclass{brlex2}

% To this:
\documentclass{brlex3}
```

That's it! Your document should compile exactly as before.

### Example

**Before (brlex2):**
```latex
\documentclass[calibri,artbold]{brlex2}

\begin{document}
\epigrafe{LEI Nº 123/2024}
\ementa{Dispõe sobre...}
\preambulo[O PRESIDENTE]{...}
\metadata

\art Este é o primeiro artigo.
\parun Este é o parágrafo único.
\end{document}
```

**After (brlex3):**
```latex
\documentclass[calibri,artbold]{brlex3}
% Everything else stays the same!

\begin{document}
\epigrafe{LEI Nº 123/2024}
\ementa{Dispõe sobre...}
\preambulo[O PRESIDENTE]{...}
\metadata

\art Este é o primeiro artigo.
\parun Este é o parágrafo único.
\end{document}
```

---

## Why Upgrade?

### Benefits of brlex3

1. **Better Code Quality**: Complete rewrite using modern LaTeX3 (expl3)
2. **More Robust**: Better error handling and validation
3. **Clearer Messages**: Helpful warnings and error messages
4. **Future-Proof**: Built on LaTeX3, the future of LaTeX
5. **Extensible**: Easier to add new features
6. **Well Documented**: Comprehensive inline documentation
7. **Better Maintained**: Cleaner code is easier to maintain

### What's the Same?

- ✓ All commands work exactly the same
- ✓ Output is visually identical
- ✓ PDF metadata works the same
- ✓ All options supported
- ✓ Same package dependencies

### What's Different?

- ✓ Internal implementation (users don't need to care)
- ✓ Better error messages
- ✓ Optional new key-value syntax for options

---

## Basic Migration

### Step 1: Change Class Name

```latex
\documentclass{brlex2}  % Old
↓
\documentclass{brlex3}  % New
```

### Step 2: Test Compilation

Compile your document. It should work without any other changes.

```bash
pdflatex your-document.tex
# or
xelatex your-document.tex
# or
lualatex your-document.tex
```

### Step 3: Check Output

Compare the PDF output with your previous version. They should be visually identical.

### Step 4: Done!

If everything looks good, you're done! Your document is now using brlex3.

---

## Options Migration

### Legacy Options (Still Work)

All brlex2 options work in brlex3:

```latex
\documentclass[indent]{brlex3}          % ✓ Works
\documentclass[calibri]{brlex3}         % ✓ Works
\documentclass[artbold]{brlex3}         % ✓ Works
\documentclass[usetitle]{brlex3}        % ✓ Works
\documentclass[useitalic]{brlex3}       % ✓ Works

% Multiple options
\documentclass[calibri,artbold,indent]{brlex3}  % ✓ Works
```

### New Key-Value Syntax (Optional)

brlex3 introduces a modern key-value syntax. You can choose to use it:

```latex
% Modern syntax (optional)
\documentclass[
  font = calibri,
  article-bold = true,
  indent = true,
  title-bold = true,
  emphasis = bold
]{brlex3}
```

### Option Mapping

| brlex2 Option | brlex3 Legacy | brlex3 Key-Value |
|--------------|---------------|------------------|
| `indent` | `indent` | `indent=true` |
| `calibri` | `calibri` | `font=calibri` |
| `artbold` | `artbold` | `article-bold=true` |
| `usetitle` | `usetitle` | `title-bold=true` |
| `useitalic` | `useitalic` | `emphasis=italic` |

### Choosing a Syntax

**Use legacy syntax if:**
- You want minimal changes
- You have many existing documents
- You prefer brevity

**Use key-value syntax if:**
- You're starting new documents
- You want self-documenting code
- You plan to use advanced features

**Recommendation**: Stick with legacy syntax for existing documents, use key-value for new ones.

---

## Command Reference

All brlex2 commands work in brlex3. Here's a complete reference:

### Document Structure

| Command | Description | Status |
|---------|-------------|--------|
| `\parte{...}` | Part (Roman numerals) | ✓ Works |
| `\parte*{...}` | Part (ordinal by extension) | ✓ Works |
| `\partegeral{...}` | General part | ✓ Works |
| `\parteespecial{...}` | Special part | ✓ Works |
| `\livro{...}` | Book | ✓ Works |
| `\titulo{...}` | Title | ✓ Works |
| `\capitulo{...}` | Chapter | ✓ Works |
| `\secao{...}` | Section | ✓ Works |
| `\subsecao{...}` | Subsection | ✓ Works |
| `\tema{...}` | Theme/subject | ✓ Works |

### Dispositivos (Legal Provisions)

| Command | Description | Status |
|---------|-------------|--------|
| `\artigo` | Article | ✓ Works |
| `\artX` | Article with letter | ✓ Works |
| `\paragrafo` | Paragraph | ✓ Works |
| `\paragrafounico` | Single paragraph | ✓ Works |
| `\inciso` | Item/clause | ✓ Works |
| `\alinea` | Subitem | ✓ Works |
| `\itens` | Sub-subitem | ✓ Works |

### Shortcuts

| Shortcut | Full Command | Status |
|----------|--------------|--------|
| `\art` | `\artigo` | ✓ Works |
| `\parag` | `\paragrafo` | ✓ Works |
| `\so` | `\paragrafo` | ✓ Works |
| `\parun` | `\paragrafounico` | ✓ Works |
| `\inc` | `\inciso` | ✓ Works |
| `\itm` | `\itens` | ✓ Works |

### Preliminary Parts

| Command | Description | Status |
|---------|-------------|--------|
| `\epigrafe{...}` | Epigraph/title | ✓ Works |
| `\title{...}` | Alternative to epigrafe | ✓ Works |
| `\ementa{...}` | Summary/abstract | ✓ Works |
| `\preambulo{...}` | Preamble | ✓ Works |
| `\preambulo[...]{...}` | Preamble with enunciation | ✓ Works |
| `\metadata` | Set PDF metadata | ✓ Works |

### Utilities

| Command | Description | Status |
|---------|-------------|--------|
| `\cortado{...}` | Strikethrough text | ✓ Works |

---

## Advanced Topics

### Custom Counter Access

**brlex2 approach (still works):**
```latex
\arabic{artigo}  % Current article number
```

**brlex3 internal (for advanced users):**

brlex3 uses expl3 integer variables internally. If you need to access them:

```latex
\ExplSyntaxOn
\int_use:N \g__brlex_artigo_int  % Current article number
\ExplSyntaxOff
```

⚠️ **Warning**: Using internal variables is not recommended. The public interface may change.

### Custom Formatting

If you were customizing brlex2 formatting:

**Example - Custom article bold format:**

```latex
% This worked in brlex2 and still works in brlex3:
\makeatletter
\renewcommand{\artigo}{%
  \refstepcounter{artigo}%
  \par\noindent\textit{Art. \arabic{artigo}.}~~%
}
\makeatother
```

However, in brlex3, if you want to work with the internal implementation:

```latex
\ExplSyntaxOn
% Redefine the article command using expl3
\RenewDocumentCommand \artigo { }
  {
    \int_gincr:N \g__brlex_artigo_int
    \par
    \textit{Art.~\int_use:N \g__brlex_artigo_int.}~~
  }
\ExplSyntaxOff
```

### Package Loading Order

brlex3 loads packages in the same order as brlex2. If you load conflicting packages, the same conflicts apply:

```latex
\documentclass{brlex3}
\usepackage{somepackage}  % Same compatibility as brlex2
```

### Font Setup with Calibri

The calibri option works the same:

```latex
\documentclass[calibri]{brlex3}
% Requires XeLaTeX or LuaLaTeX
% Requires Calibri font installed
```

If using pdfLaTeX, you'll get a helpful warning (improved in brlex3):

```
Package brlex3 Warning: A opção 'calibri' requer XeLaTeX ou LuaLaTeX.
(brlex3)                Para continuar usando pdfLaTeX, remova a 
(brlex3)                opção 'calibri'.
```

---

## Troubleshooting

### Common Issues

#### Issue 1: "Undefined control sequence \ExplSyntaxOn"

**Cause**: Your LaTeX distribution is too old.

**Solution**: Update to TeX Live 2020 or later:
```bash
# On most systems:
sudo tlmgr update --self --all
```

#### Issue 2: Different output than brlex2

**Cause**: Unlikely, but possible if using custom modifications.

**Solution**: 
1. Compare with vanilla brlex2 first
2. Check if you have custom redefinitions
3. Report as a bug if truly different

#### Issue 3: Options not recognized

**Cause**: Typo in option name with key-value syntax.

**Solution**: Check option spelling or use legacy syntax:
```latex
% Instead of:
\documentclass[font=calibre]{brlex3}  % Wrong!

% Use:
\documentclass[font=calibri]{brlex3}  % Correct
% Or legacy:
\documentclass[calibri]{brlex3}       % Also correct
```

#### Issue 4: Calibri warning even without option

**Cause**: Unlikely but could be a conflict.

**Solution**: Make sure you're not loading fontspec or polyglossia manually before the class.

### Getting Help

If you encounter issues:

1. **Check this guide** - Most issues are covered here
2. **Read the error message** - brlex3 has helpful error messages
3. **Check CHANGELOG.md** - See if your issue is a known limitation
4. **Minimal example** - Create the smallest document that shows the problem
5. **Report issue** - Open an issue on GitHub with your minimal example

### Reporting Bugs

When reporting bugs, include:

```latex
% Minimal example
\documentclass{brlex3}
\begin{document}
\art This demonstrates the problem.
% Describe what's wrong here
\end{document}
```

And provide:
- Your LaTeX distribution (e.g., TeX Live 2023)
- Your compiler (pdfLaTeX, XeLaTeX, or LuaLaTeX)
- The error message or unexpected output
- What you expected to happen

---

## Examples

### Complete Migration Example

**Original brlex2 document:**

```latex
\documentclass[calibri,artbold]{brlex2}

\begin{document}

\epigrafe{LEI Nº 12.345, DE 1º DE JANEIRO DE 2024}
\ementa{Dispõe sobre a organização administrativa 
        e estabelece outras providências.}
\preambulo[O PRESIDENTE DA REPÚBLICA]{Faço saber que 
           o Congresso Nacional decreta e eu sanciono 
           a seguinte Lei:}
\metadata

\titulo{DAS DISPOSIÇÕES GERAIS}

\art Esta Lei estabelece as normas gerais de 
organização administrativa.

\parun As disposições desta Lei aplicam-se aos 
órgãos da administração pública direta.

\art A estrutura organizacional compreende:

\inc os órgãos de direção superior;
\inc os órgãos de assistência;
\inc os órgãos executivos.

\end{document}
```

**Migrated to brlex3 (minimal changes):**

```latex
\documentclass[calibri,artbold]{brlex3}  % Only this line changed!

\begin{document}

\epigrafe{LEI Nº 12.345, DE 1º DE JANEIRO DE 2024}
\ementa{Dispõe sobre a organização administrativa 
        e estabelece outras providências.}
\preambulo[O PRESIDENTE DA REPÚBLICA]{Faço saber que 
           o Congresso Nacional decreta e eu sanciono 
           a seguinte Lei:}
\metadata

\titulo{DAS DISPOSIÇÕES GERAIS}

\art Esta Lei estabelece as normas gerais de 
organização administrativa.

\parun As disposições desta Lei aplicam-se aos 
órgãos da administração pública direta.

\art A estrutura organizacional compreende:

\inc os órgãos de direção superior;
\inc os órgãos de assistência;
\inc os órgãos executivos.

\end{document}
```

**Modern brlex3 style (optional):**

```latex
\documentclass[
  font = calibri,
  article-bold = true
]{brlex3}

% Everything else can stay the same,
% or you can modernize further if you prefer
\begin{document}
% ... rest of document unchanged ...
\end{document}
```

---

## Conclusion

Migration from brlex2 to brlex3 is designed to be painless. For most documents, changing the class name is sufficient. The new version provides better code quality, improved error messages, and a foundation for future enhancements, all while maintaining complete backward compatibility.

**Recommendation**: 
- ✓ Migrate existing documents by just changing the class name
- ✓ Use legacy option syntax for existing documents
- ✓ Consider modern syntax for new documents
- ✓ Report any issues you encounter

Happy legal document writing with brlex3! 📜⚖️
