VERSION_FILE = ./VERSION
pkgver = $(shell cat $(VERSION_FILE))
version = $(firstword $(subst -, ,$(pkgver)))
release = $(lastword $(subst -, ,$(pkgver)))

default: clean

deb:
	./bin/make_deb.sh $(version) $(release)

rpm:
	./bin/make_rpm.sh $(version) $(release)

bake = docker buildx bake --progress plain -f docker/docker-bake.hcl --provenance=false

docker-build-rpm:
	$(call bake) rpm

docker-build-deb:
	$(call bake) deb

docker-build:: docker-build-rpm docker-build-deb

clean:
	rm -rf ec2-instance-connect*
	rm -rf ./rpmbuild/SOURCES
	rm -rf ./deb-src
	rm -rf ./srpm_results
	rm -rf ./rpm_results
	rm -rf ./out
