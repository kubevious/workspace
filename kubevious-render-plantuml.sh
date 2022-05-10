#!/bin/bash

echo "*** Kubevious Render PlantUML Diagrams" 

echo '*************************************'
echo '*************************************'
echo '*************************************'

for filename in *.plantuml; do
  echo '*************************************'
  echo "*** Diagram >> ${filename}"

  docker run -u $(id -u):$(id -g) --rm -v $(pwd):/data -it hrektts/plantuml plantuml ${filename}

  echo ""
  echo ""
done

rm -rf "?"