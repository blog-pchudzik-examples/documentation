ROOT_DIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
clean:
	rm -f "$(ROOT_DIR)/docs/docker_out.html" || true
	rm -f "$(ROOT_DIR)/docs/architecture_diagram.svg" || true

diagram:
	cat $(ROOT_DIR)/architecture_diagram.puml | docker run --rm -i think/plantuml -tpng > architecture_diagram.png

docs: clean
	docker run \
		--rm \
		-v $(ROOT_DIR):/documents/ \
		asciidoctor/docker-asciidoctor \
		asciidoctor \
			-r asciidoctor-diagram \
			-o docs/docker_out.html docs/index.adoc
