<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/fenix-renderers.tld" prefix="fr" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/chart.tld" prefix="chart" %>
<%@page import="myorg.presentationTier.component.OrganizationChart"%>
<%@page import="module.organization.domain.Unit"%>


<%@page import="module.organization.domain.Accountability"%>
<%@page import="module.organization.domain.Party"%>
<%@page import="module.organization.domain.UnconfirmedAccountability"%><bean:define id="partyChart" name="partyChart" type="module.organization.presentationTier.actions.OrganizationModelAction.PartyChart"/>
<logic:notEmpty name="partyChart">
	<logic:present name="partyChart" property="unit">
		<bean:define id="unit" name="partyChart" property="unit"/>
		<logic:present role="myorg.domain.RoleType.MANAGER">
			<bean:define id="url">/organizationModel.do?method=prepareEditUnit&amp;organizationalModelOid=<bean:write name="organizationalModel" property="externalId"/>&amp;viewName=default</bean:define>
			<html:link action="<%= url %>" paramId="partyOid" paramName="unit" paramProperty="externalId">
				<bean:message key="label.unit.edit" bundle="ORGANIZATION_RESOURCES"/>
			</html:link>
			|
			<bean:define id="url">/organizationModel.do?method=managePartyPartyTypes&amp;organizationalModelOid=<bean:write name="organizationalModel" property="externalId"/>&amp;viewName=default</bean:define>
			<html:link action="<%= url %>" paramId="partyOid" paramName="unit" paramProperty="externalId">
				<bean:message key="label.unit.partyTypes.manage" bundle="ORGANIZATION_RESOURCES"/>
			</html:link>
			|
		</logic:present>
		<bean:define id="url">/organizationModel.do?method=prepareAddUnit&amp;organizationalModelOid=<bean:write name="organizationalModel" property="externalId"/>&amp;viewName=default</bean:define>
		<html:link action="<%= url %>" paramId="partyOid" paramName="unit" paramProperty="externalId">
			<bean:message key="label.unit.child.add" bundle="ORGANIZATION_RESOURCES"/>
		</html:link>
		|
		<bean:define id="url">/organizationModel.do?method=prepareCreateUnit&amp;organizationalModelOid=<bean:write name="organizationalModel" property="externalId"/>&amp;viewName=default</bean:define>
		<html:link action="<%= url %>" paramId="partyOid" paramName="unit" paramProperty="externalId">
			<bean:message key="label.unit.child.create" bundle="ORGANIZATION_RESOURCES"/>
		</html:link>
		<logic:present role="myorg.domain.RoleType.MANAGER">
			|
			<bean:define id="url">/organizationModel.do?method=deleteUnit&amp;organizationalModelOid=<bean:write name="organizationalModel" property="externalId"/>&amp;viewName=default</bean:define>
			<html:link action="<%= url %>" paramId="partyOid" paramName="unit" paramProperty="externalId">
				<bean:message key="label.unit.delete" bundle="ORGANIZATION_RESOURCES"/>
			</html:link>
		</logic:present>
	</logic:present>

	<% boolean passedElement = false; %>
	<table width="100%" align="center">
		<tr>
			<td align="center">
				<chart:orgChart id="object" name="partyChart" type="java.lang.Object">
					<%
						if (partyChart.getElement() == object) {
						    passedElement = true;
					%>
							<div class="orgTBox orgTBoxLight">
								<bean:write name="object" property="partyName"/>
							</div>
					<%
						} else {
						    Party party = null;
						    String styleCass = "orgTBox orgTBoxLight";
						    String title = null;
						    if (object instanceof Accountability) {
								final Accountability accountability = (Accountability) object;
								party = passedElement ? accountability.getChild() : accountability.getParent();
								if (object instanceof UnconfirmedAccountability) {
								    styleCass = "orgTBox orgTBoxRed";
								}
								title = accountability.getDetailsString();
						    } else {
								party = (Party) object;
						    }
					%>
							<div class="<%= styleCass %>" <% if (title != null) { %>title="<%= title %>"<% } %>>
								<bean:define id="url">/organizationModel.do?method=viewModel&amp;viewName=default&amp;partyOid=<%= party.getExternalId() %></bean:define>
								<html:link action="<%= url %>" paramId="organizationalModelOid" paramName="organizationalModel" paramProperty="externalId">
									<%= party.getPartyName().getContent() %>
								</html:link>
							</div>
					<%
						}
					%>
				</chart:orgChart>
			</td>
		</tr>
	</table>
</logic:notEmpty>