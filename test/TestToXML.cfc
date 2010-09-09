<cfcomponent extends="com.rocketboots.rocketunit.Test">

	<cfset CLASS_NAME="toXML">

	<cffunction access="public" returntype="void" name="setup">
		<cfset instance = createObject("component", CLASS_NAME)>
	</cffunction>

	<cffunction access="public" returntype="void" name="teardown">
		<cfset structDelete(variables, "instance")>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_instance">
		<cfscript>
			assert("isDefined('instance')");
			assert("getMetadata(instance).name eq CLASS_NAME");
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_simple_string_value">
		<cfscript>
			xml = instance.toXml("hello-world");
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="string">hello-world</data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_simple_empty_string_value">
		<cfscript>
			xml = instance.toXml("");
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="string"/>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_simple_boolean_value">
		<cfscript>
			xml = instance.toXml(false);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="boolean">0</data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_simple_numeric_value">
		<cfscript>
			xml = instance.toXml(1024);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="numeric">1024</data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_array_with_simple_values">
		<cfscript>
			array = [ "hello-world", 1024, true, "" ];
			xml = instance.toXml(array);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="array"><item type="string" order="1">hello-world</item><item type="numeric" order="2">1024</item><item type="boolean" order="3">1</item><item type="string" order="4"/></data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_struct_with_simple_values">
		<cfscript>
			struct = { string = "hello-world", integer = 1024, boolean = true, emptyString = "" };
			xml = instance.toXml(struct);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="struct"><INTEGER type="numeric">1024</INTEGER><BOOLEAN type="boolean">1</BOOLEAN><STRING type="string">hello-world</STRING><EMPTYSTRING type="string"/></data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_struct_with_complex_values">
		<cfscript>
			array = [ "hello-world", 1024, true, "" ];
			struct = { "string" = "hello-world", "integer" = 1024, "boolean" = true, "emptyString" = "", "array" = array };
			xml = instance.toXml(struct);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="struct"><integer type="numeric">1024</integer><boolean type="boolean">1</boolean><array type="array"><item type="string" order="1">hello-world</item><item type="numeric" order="2">1024</item><item type="boolean" order="3">1</item><item type="string" order="4"/></array><string type="string">hello-world</string><emptyString type="string"/></data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>

	<cffunction access="public" returntype="void" name="test_toXml_object_with_simple_values">
		<cfscript>
			object = CreateObject("component", "Object");
			xml = instance.toXml(object);
			expected = '<?xml version="1.0" encoding="UTF-8"?><data type="component" name="Object"><LASTNAME type="string">Gibson</LASTNAME><FIRSTNAME type="string">James</FIRSTNAME></data>';
			assert('Compare(xml, expected) eq 0');
		</cfscript>
	</cffunction>
	
	<cffunction name="$dump" returntype="void" access="public" output="true">
		<cfargument name="var" type="any" required="true">
		<cfargument name="abort" type="boolean" required="false" default="true">
		<cfdump var="#arguments.var#">
		<cfif arguments.abort>
			<cfabort>
		</cfif>
	</cffunction>
	
</cfcomponent>