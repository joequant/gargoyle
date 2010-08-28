GARGOYLE_VERSION:=1.3.X (Built $(shell date -u))
V=99
FULL_BUILD=false

ALL: all
all:
	( \
		targets=`ls targets | sed 's/custom//g' ` ;\
		for t in $$targets ; do \
			if [ ! -d "$$t-src" ] || [ "$(FULL_BUILD)" = "1" -o "$(FULL_BUILD)" = "true" -o "$(FULL_BUILD)" = "TRUE" ] ; then \
				sh full-build.sh "$$t" "$(GARGOYLE_VERSION)" "$(V)" ;\
			else \
				sh rebuild.sh "$$t" "$(GARGOYLE_VERSION)" "$(V)" ;\
			fi ;\
		done ;\
	)

%: targets/%
	( \
		if [ ! -d "$@-src" ] || [ "$(FULL_BUILD)" = "1" -o "$(FULL_BUILD)" = "true" -o "$(FULL_BUILD)" = "TRUE" ] ; then \
			sh full-build.sh "$@" "$(GARGOYLE_VERSION)" "$(V)" ;\
		else \
			sh rebuild.sh "$@" "$(GARGOYLE_VERSION)" "$(V)" ;\
		fi ;\
	)

prepare:
	if [ -d "../downloaded" ] ; then cp -r ../downloaded . ; fi
	if [ -d "../backfire-src" ] ; then cp -r ../backfire-src . ; fi
	if [ -e "./backfire-src/dl" ] ; then rm -rf "./backfire-src/dl" ; fi

cleanup:
	find . -name ".svn" | xargs rm -rf
	find . -name "*~" | xargs rm -rf
	find . -name ".*sw*" | xargs rm -rf
