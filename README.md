# AstroVim-Config

<!--toc:start-->

- [AstroVim-Config](#astrovim-config)
  - [Important bindings](#important-bindings) - [nvim-surround bindings](#nvim-surround-bindings)
  <!--toc:end-->

My config for AstroNvim

## Important bindings

### nvim-surround bindings

| Example                       | Command     | Result                         |
| ----------------------------- | ----------- | ------------------------------ |
| surround line                 | yss)        | (surround line)
| surr\*ound_words              | ysiw)       | (surround_words)               |
| \*make strings                | ys$"        | "make strings"                 |
| \*line <br/> text\*           | yS2j}       | { <br/>line <br/> text <br/> } |
| [delete ar*ound me!]          | ds]         | delete around me!              |
| remove \<b\>HTML t\*ags\</b\> | dst         | remove HTML tags               |
| 'change quot\*es'             | cs'"        | "change quotes"                |
| \<b\>or tag\*types\</b\>      | csth1\<CR\> | \<h1\>or tag types\</h1\>      |
| delete(functi\*on calls)      | dsf         | function calls                 |

This shit be good
