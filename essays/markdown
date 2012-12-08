#!/bin/zsh

markedjs="js/marked.js"
mathjax=$(</home/ross/documents/Programming/Web/Snippets/mathjax.html)
markd=`js -f $markedjs -e "var text = read(\"$1\"); print(marked(text));"`

echo "<html><head>"
echo "<title>$2</title>"
echo $mathjax
echo "<link rel=\"stylesheet\" href=\"markdown.css\">"
echo "</head><body>"
echo $markd
echo "</body></html>"
