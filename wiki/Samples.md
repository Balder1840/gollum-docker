---
title: Samples
header_enum: true
---

[[_TOC_]]
# Markdown samples

## List
### Normal
- Hallo
- hello
- Hi

### Ordered
1. Hallo
2. hello
3. Hi

### Checked
- [x] checked me
- [x] checked me
- [ ] bad luck

## Emphasis

***strong emph***

***strong** in emph*

***emph* in strong**

**in strong *emph***

*in emph **strong***

internal emphasis: foo*bar*baz

no emphasis: foo_bar_baz

## Strikethrough

~~Hi~~ Hello, world!

This ~~has a

new paragraph~~.

## Tables

| foo | bar |
| --- | --- |
| baz | bim |

| abc | defghi |
:-: | -----------:
bar | baz

## Code blocks
### Javascript
```javascript
console.log('Hi, Javascript!')
```
### C<span>#<span>
```csharp
Console.Writeline("Hi, C#!");
```
### Java
```java
System.out.println("Hello Java");
```

### Ruby
~~~~ruby startline=3 $%@#$
def foo(x)
  return 3
end
~~~~~~~

## PlantUML
@startuml
Alice -> Bob: Authentication Request
Bob --> Alice: Authentication Response
Alice -> Bob: Another authentication Request
Alice <-- Bob: another authentication Response
@enduml

## Math
$$
\begin{aligned}
  & \phi(x,y) = \phi \left(\sum_{i=1}^n x_ie_i, \sum_{j=1}^n y_je_j \right)
  = \sum_{i=1}^n \sum_{j=1}^n x_i y_j \phi(e_i, e_j) = \\
  & (x_1, \ldots, x_n) \left( \begin{array}{ccc}
      \phi(e_1, e_1) & \cdots & \phi(e_1, e_n) \\
      \vdots & \ddots & \vdots \\
      \phi(e_n, e_1) & \cdots & \phi(e_n, e_n)
    \end{array} \right)
  \left( \begin{array}{c}
      y_1 \\
      \vdots \\
      y_n
    \end{array} \right)
\end{aligned}
$$

## Note & Warn Macro

<<Note("Did you know?")>>

<<Warn("Careful, changing that file could be dangerous")>>

## Octicon Macro

<<Octicon("globe", 64, 64)>>

## A collapsible section
<details>
  <summary>Click to expand!</summary>

  ### Heading
  1. A numbered
  2. list
     * With some
     * Sub bullets
</details>

## Reference
see [kramdown syntax](https://kramdown.gettalong.org/syntax.html)

This is some text.[^1]. Other text.[^footnote].

[^1]: Some *crazy* footnote definition.
[^footnote]:
    > Blockquotes can be in a footnote.

        as well as code blocks

    or, naturally, simple paragraphs.