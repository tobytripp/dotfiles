#!/usr/bin/env sh

### Java Environment Functions ###
# http://homepage.mac.com/shawnce/misc/java_functions_bashrc.txt

J_VERSIONS_DIRECTORY="/System/Library/Frameworks/JavaVM.framework/Versions"
J_COMMANDS_SUBPATH="Commands"
J_HOME_SUBPATH="Home"

function availableJVMs()
{
	ls -1 $J_VERSIONS_DIRECTORY | grep ^[0-9].[0-9]
}

function listJava()
{
	local jvms=$(availableJVMs)
	echo "Available JVMs: "$jvms
	
	echo "Current Java:"
	java -version
}

function setJava()
{
	local target_jvm=""
	local jvms=$(availableJVMs)
	
	# Validate that the user requested an available JVM present on the system

	for jvm in $jvms ; do
		if [ "$jvm" == "$@" ]; then
			target_jvm=$@	
		fi
	done

	if [ "$target_jvm" == "" ]; then
		echo "Unsupported Java version requested"
		return;
	fi
	
	# If we get here the user asked for a valid JVM, so configure it

	echo "Configuring Shell Environment for Java "$@

	# First unset any current set java, back to default before doing configuration
	_unsetJava

	# Generate the paths needed for the JVM requested
	local jcmd="${J_VERSIONS_DIRECTORY}/$@/${J_COMMANDS_SUBPATH}"
	local jhome="${J_VERSIONS_DIRECTORY}/$@/${J_HOME_SUBPATH}"

	# We save the original path so we can toggle back if unset
	ORIGINAL_PATH="$PATH"
	PATH="$jcmd:${PATH}"
	
	# We save the original JAVA_HOME so we can toggle back if unset
	ORIGINAL_JAVA_HOME="$JAVA_HOME"
	JAVA_HOME="$jhome"
	
	# Update command prompt mode tag to note JVM setting
	CURRENT_MODE_STRING="J$@"

	echo "Current Java:"
	java -version
}

function _unsetJava()
{
	if [ "$CURRENT_MODE_STRING" != "" ]; then
        	PATH="$ORIGINAL_PATH"
		JAVA_HOME="$ORIGINAL_JAVA_HOME"
		CURRENT_MODE_STRING=""
	fi
}

function unsetJava()
{
	echo "Configuring Shell Environment for default Java"
 	_unsetJava

	echo "Current Java:"
        java -version
}