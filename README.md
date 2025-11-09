# `brlex3` (formerly brlex2)

> Classe $\LaTeX$ para redação de textos jurídicos conforme legislação brasileira.

**🎉 Nova versão 3.0** - Agora com LaTeX3 (expl3)! Código completamente reescrito para maior qualidade, robustez e facilidade de manutenção.

![](img/exemplo0.png)

**Código:**
```latex
\documentclass[calibri]{brlex3}  % ou use brlex2 para a versão anterior

\begin{document}

\epigrafe{LEI COMPLEMENTAR Nº 95, DE 26 DE FEVEREIRO DE 1998}
\ementa{Dispõe sobre a elaboração, a redação, a alteração e a consolidação das leis, conforme determina o parágrafo único do art. 59 da Constituição Federal, e estabelece normas para a consolidação dos atos normativos que menciona.}
\preambulo[O PRESIDENTE DA REPÚBLICA]{Faço saber que  o Congresso Nacional decreta e eu sanciono a seguinte Lei Complementar:}
\metadata

\art A elaboração, a redação, a alteração e a consolidação das leis obedecerão ao disposto nesta Lei Complementar.

\parun As disposições desta Lei Complementar aplicam-se, ainda, às medidas provisórias e demais atos normativos referidos no art. 59 da Constituição Federal, bem como, no que couber, aos decretos e aos demais atos de regulamentação expedidos por órgãos do Poder Executivo.

\end{document}
```

## Novidades na Versão 3.0

🚀 **Grande atualização**: brlex3 é uma reescrita completa usando LaTeX3 (expl3)!

### Melhorias Principais

- ✅ **Código modernizado**: Implementação completa em expl3 (LaTeX3)
- ✅ **Mais robusto**: Melhor tratamento de erros e validação
- ✅ **Mensagens claras**: Avisos e erros mais úteis
- ✅ **Opções modernas**: Suporte para sintaxe chave-valor
- ✅ **Bem documentado**: Documentação inline completa
- ✅ **100% compatível**: Todos os comandos do brlex2 funcionam

### Migração do brlex2

Para a maioria dos documentos, basta mudar o nome da classe:

```latex
% Antes (brlex2)
\documentclass{brlex2}

% Agora (brlex3)
\documentclass{brlex3}
```

Veja [MIGRATION.md](MIGRATION.md) para detalhes completos.

## Recursos

Esta classe é capaz de formatar atos normativos (leis, decretos, etc) e também outros textos legais com a mesma divisão padrão (estatutos, resoluções, portarias, etc). 

As regras de formatação seguem as referências (1) e (3).

No geral, é possível:

- Numeração automática de todos os dispositivos e divisões;
- Indicar a epígrafe, ementa e preâmbulo;
- Dividir o texto em partes, livros, títulos, capítulos, seções e subseções;
- Dividir os dispositivos em artigos, parágrafos, incisos, alíneas e itens;
- Indicar o uso da fonte Calibri, cf. Decreto nº 9191/2017, (apenas XeLaTeX/LuaLaTeX e com a fonte instalada);
- Formatar o numerador do dispositivo em negrito (**Art. 1º** Texto normal);
- Usar partes específicas, gerais ou enumeradas em romanos (PARTE I) ou em ordinal por extenso (PARTE PRIMEIRA);
- Metadados do PDF;
- Índice nos bookmarks do PDF, permitindo fácil navegação pelo texto.


## Instalação

### Versão 3.0 (brlex3 - Recomendado)

Coloque o arquivo `brlex3.cls` no mesmo diretório do seu arquivo `.tex`.

### Versão 2.0 (brlex2 - Legado)

O arquivo `brlex2.cls` ainda está disponível para compatibilidade com documentos antigos.

## Uso
A utilização tem o foco em ser extremamente simplificada. 

Veja o [Exemplo 1]() para um exemplo completo.


### Opções do pacote

brlex3 suporta tanto a sintaxe legada quanto a moderna sintaxe chave-valor.

#### Sintaxe Legada (brlex2 e brlex3)
```latex
\documentclass[calibri,artbold,indent]{brlex3}
```

#### Sintaxe Moderna (somente brlex3)
```latex
\documentclass[
  font=calibri,
  article-bold=true,
  indent=true
]{brlex3}
```

As opções a seguir estão disponíveis:

| Opção Legada | Opção Moderna | Descrição |
|--------------|---------------|-----------|
| `calibri` | `font=calibri` | Usa a fonte Calibri (requer XeLaTeX/LuaLaTeX e fonte instalada) |
| `indent` | `indent=true` | Usa indentação em vez de espaçamento entre parágrafos |
| `artbold` | `article-bold=true` | Coloca as numerações em negrito (**Art. 15.** Texto normal) |
| `usetitle` | `title-bold=true` | Coloca a epígrafe em negrito (útil para estatutos) |
| `useitalic` | `emphasis=italic` | `\emph` usa itálico em vez de negrito |

### Comandos
Ao escrever o texto normativo, estão disponíveis os seguintes comandos:

**Dados gerais**
- `\epigrafe{...}` ou `\title{...}`: informa o identificador do ato ("Lei Nº 12/2023, de 12 de dezembro de 2023", por exemplo). Caso `usetitle` seja usado, será grafado em negrito.
- `\ementa{...}`: descreve sobre o que se trata o texto;
- `\preambulo{...}`
- `\preambulo[...]{...}`
- `\metadata`: deve ser usado após epígrafe e parágrafo, e os incluirá nos metadados do PDF.

**Separação do documento**
- `\parte{...}`: parte, com numeração romana;
- `\parte*{...}`: parte, com numeração ordinal por extenso;
- `\partegeral{...}`
- `\parteespecial{...}`
- `\livro{...}`
- `\titulo{...}`
- `\capitulo{...}`
- `\secao{...}`
- `\subsecao{...}`
- `\tema{...}` especificação temática do conteúdo de grupo de artigos ou de um artigo (grafada em letras minúsculas em negrito, alinhada à esquerda, sem numeração);

**Dispositivos**
- `\artigo ...`
- `\paragrafo ...`
- `\paragrafounico ...` 
- `\inciso ...`
- `\alinea ...`
- `\itens ...`


**Abreviações**
- `\art ...` em vez de `\artigo ...`
- `\so ...` ou `\parag ...` em vez de `\paragrafo ...`
- `\parun ...` em vez de `\paragrafounico ...` 
- `\inc ...` em vez de `\inciso ...`
- `\itm ...` em vez de `\itens ...`



## Referências normativas:

1. [Lei Complementar nº 95](https://www.planalto.gov.br/ccivil_03/leis/lcp/lcp95.htm), de 26 de fevereiro de 1998.
2. [Decreto nº 9191/2017](https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2017/decreto/d9191.htm), de 1º de novembro de 2017 **(REVOGADO)**;
3. [Manual de Compilação da Legislação Brasileira](https://bd.camara.leg.br/bitstreams/0ebe1f41-2826-428c-b4d5-d2f9b1c5b97a/download) (Câmara dos Deputados, 2012);


## Documentação Adicional

- **[CHANGELOG.md](CHANGELOG.md)** - Histórico detalhado de mudanças
- **[MIGRATION.md](MIGRATION.md)** - Guia completo de migração do brlex2 para brlex3
- **Exemplos**: Veja a pasta `examples/` para diversos exemplos de uso

## Versões

- **brlex3** (v3.0.0, 2025) - Versão atual, reescrita em LaTeX3 (expl3)
- **brlex2** (v2.0.0, 2023) - Versão legada, ainda disponível

## Autor
Desenvolvido e mantido por [Heliton Martins](https://github.com/hellmrf) (<helitonmrf@gmail.com>).

Esta classe foi largamente inspirada por [`br-lex`](https://ctan.org/pkg/br-lex), mas o código foi majoritariamente reescrito.

### Versão 3.0
Reescrita completa usando LaTeX3 (expl3) em 2025, mantendo compatibilidade total com a versão 2.0.

