PROJECT = emq-relx
PROJECT_DESCRIPTION = Release Project for the Housing EMQ Broker
PROJECT_VERSION = 2.1

DEPS = emqttd emq_dashboard
# all the build and runtime deps
dep_emqttd = git https://github.com/emqtt/emqttd.git master
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard master

# COVER = true
BUILD_DEPS = elixir_build_plugin #only load the private repo so that the plugin can be loaded below
DEP_PLUGINS = elixir_build_plugin #pick plugins.mk from the dependency
dep_elixir_build_plugin = cp ./priv/emq_housing_build

ELIXIR_DEPS = emqttd_plugin_housing #Specify dependency to be compiled using elixir
dep_emqttd_plugin_housing = cp /home/dev/workspace/public_repo/housing.iris.auth

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			echo "Skipping emq.conf file from dep"; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done
	@cp ./etc/emq.conf rel/conf/
	@rm rel/schema/emq.schema
	@cp ./etc/emq.schema rel/schema/

app:: plugins

