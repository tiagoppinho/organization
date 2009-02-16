<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr"%>

<h2><bean:message key="label.connection.rules" bundle="ORGANIZATION_RESOURCES" /></h2>
<h3><fr:view name="accountabilityType" property="name" /></h3>

<html:messages id="message" message="true" bundle="ORGANIZATION_RESOURCES">
	<span class="error0"> <bean:write name="message" /> </span>
	<br />
</html:messages>

<bean:define id="accountabilityTypeOid" name="accountabilityType" property="OID" />
<fr:form action='<%= "/organization.do?accountabilityTypeOid=" + accountabilityTypeOid.toString() %>'>
	<html:hidden property="method" value="associateConnectionRules"/>
	
	<script type="text/javascript">
	<!--
		function setCheckBoxValue(value) {
			elements = document.getElementsByTagName('input');
			for (i = 0; i < elements.length; i++) {
				if (elements[i].type == 'checkbox') {
					elements[i].checked = value;	
				}
			}
		}
	//-->
	</script>
	
	
	<a href="javascript:setCheckBoxValue(true)"><bean:message key="label.select.all" bundle="ORGANIZATION_RESOURCES" /></a> | <a href="javascript:setCheckBoxValue(false)"><bean:message key="label.select.none" bundle="ORGANIZATION_RESOURCES" /></a>
	<table class="tstyle2">
		<logic:iterate id="connectionRule" name="connectionRules">
			<tr>
				<td>
					<html:multibox name="module.organization.presentationTier.actions.OrganizationManagementAction$OrganizationForm" property="oids">
						<bean:write name="connectionRule" property="OID"/>
					</html:multibox>
				</td>
				<td>
					<bean:write name="connectionRule" property="description" />
				</td>
			</tr>
		</logic:iterate>
	</table>
	
	<html:submit><bean:message key="label.save" bundle="ORGANIZATION_RESOURCES" /></html:submit>
	<html:cancel onclick="this.form.method.value='viewAccountabilityTypes';return true;" ><bean:message key="label.back" bundle="ORGANIZATION_RESOURCES" /></html:cancel>
	
</fr:form>