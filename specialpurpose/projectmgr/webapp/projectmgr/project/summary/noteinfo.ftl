<#--
Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements.  See the NOTICE file
distributed with this work for additional information
regarding copyright ownership.  The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License.  You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied.  See the License for the
specific language governing permissions and limitations
under the License.
-->
  <#macro menuContent menuArgs={}>
    <@menu args=menuArgs>
      <#--if project?has_content>
        <@menuitem type="link" href=makeOfbizUrl("newNotesForProject?workEffortId=${project.workEffortId!}&amp;showForm=Y") text=uiLabelMap.ProjectMgrNotesCreateNew class="+${styles.action_nav!} ${styles.action_add!}" />
      <#else>
        <@menuitem type="link" href=makeOfbizUrl("newNotesForTask?workEffortId=${task.workEffortId!}&amp;showForm=Y") text=uiLabelMap.ProjectMgrNotesCreateNew class="+${styles.action_nav!} ${styles.action_add!}" />
      </#if-->
    </@menu>
  </#macro>
  <@section title=uiLabelMap.WorkEffortNotes menuContent=menuContent>
    <#if workEffortNoteandDetails?has_content>
    <@table type="data-complex" class="+${styles.table_spacing_tiny_hint!}" width="100%"> <#-- orig: class="" --> <#-- orig: cellpadding="1" --> <#-- orig: border="0" -->
      <#list workEffortNoteandDetails as note>
        <@tr>
          <@td valign="top" width="35%">
            <div>&nbsp;<b>${uiLabelMap.CommonBy}: </b>${Static["org.ofbiz.party.party.PartyHelper"].getPartyName(delegator, note.noteParty, true)}</div>
            <div>&nbsp;<b>${uiLabelMap.CommonAt}: </b>${Static["org.ofbiz.base.util.UtilDateTime"].timeStampToString(note.noteDateTime!,"dd-MM-yyyy HH:mm",Static["java.util.TimeZone"].getDefault(),context.get("locale"))}</div>
          </@td>
          <@td valign="top" width="50%">${note.noteInfo!}
          </@td>
          <@td align="right" valign="top" width="15%">
            <#if note.internalNote! == "N">
                <div>${uiLabelMap.ProjectMgrPrintableNote}</div>
                  <#if project?has_content>
                    <a href="<@ofbizUrl>updateProjectNote?workEffortId=${project.workEffortId!}&amp;noteId=${note.noteId}&amp;internalNote=Y</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_update!}">${uiLabelMap.OrderNotesPrivate}</a>
                  <#else>
                    <a href="<@ofbizUrl>updateTaskNoteSummary?workEffortId=${task.workEffortId!}&amp;noteId=${note.noteId}&amp;internalNote=Y</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_update!}">${uiLabelMap.OrderNotesPrivate}</a>
                  </#if>
            </#if>
            <#if note.internalNote! == "Y">
                <div>${uiLabelMap.OrderNotPrintableNote}</div>
                   <#if project?has_content>
                     <a href="<@ofbizUrl>updateProjectNote?workEffortId=${project.workEffortId!}&amp;noteId=${note.noteId}&amp;internalNote=N</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_update!}">${uiLabelMap.OrderNotesPublic}</a>
                  <#else>
                    <a href="<@ofbizUrl>updateTaskNoteSummary?workEffortId=${task.workEffortId!}&amp;noteId=${note.noteId}&amp;internalNote=N</@ofbizUrl>" class="${styles.link_run_sys!} ${styles.action_update!}">${uiLabelMap.OrderNotesPublic}</a>
                  </#if>
            </#if>
          </@td>
        </@tr>
        <#if note_has_next>
          <@tr type="util"><@td colspan="3"><hr/></@td></@tr>
        </#if>
      </#list>
    </@table>
    <#else>
      <#if project?has_content>
        <@commonMsg type="result-norecord">${uiLabelMap.ProjectMgrProjectNoNotes}.</@commonMsg>
      <#else>
        <@commonMsg type="result-norecord">${uiLabelMap.ProjectMgrTaskNoNotes}.</@commonMsg>
      </#if>
    </#if>
  </@section>
  
  <#if parameters.showForm??>
    <@section title=uiLabelMap.OrderAddNote>
      <#if project?has_content>
        <#assign formAction = makeOfbizUrl("createNewNotesForProject")>
      <#else>
        <#assign formAction = makeOfbizUrl("createNewNotesForTask")>
      </#if>
      <form name="createnoteform" method="post" action="${formAction}">
            <#if project?has_content>
              <input type="hidden" name="workEffortId" value="${project.workEffortId}" />
            <#else>
              <input type="hidden" name="workEffortId" value="${task.workEffortId}" />
            </#if>
          <@field type="textarea" label=uiLabelMap.OrderNote name="noteInfo" rows="5" cols="70"></@field>
          <@field type="select" label=uiLabelMap.OrderInternalNote name="internalNote" size="1">
              <option value=""></option>
              <option value="Y" selected>${uiLabelMap.CommonYes}</option>
              <option value="N">${uiLabelMap.CommonNo}</option>
          </@field>
          <@field type="display">
            <i>${uiLabelMap.OrderInternalNoteMessage}</i>
          </@field>
          <#if project?has_content>
            <@field type="submit" submitType="link" href="javascript:document.createnoteform.submit()" class="+${styles.link_run_sys!} ${styles.action_add!}" text=uiLabelMap.CommonSave />
          <#else>
            <@field type="submit" submitType="link" href="javascript:document.createnoteform.submit()" class="+${styles.link_run_sys!} ${styles.action_add!}" text=uiLabelMap.CommonSave />
          </#if>
      </form>
    </@section>
  </#if>
