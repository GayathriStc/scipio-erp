<#-- CATO -->
<@section title=uiLabelMap.AccountingPaymentInformation>
  <@table type="fields">
        <@thead>
            <@tr valign="bottom" class="header-row">
                <@th>${uiLabelMap.CommonType!}</@th>
                <@th>${uiLabelMap.CommonDue!}</@th>
                <@th>${uiLabelMap.CommonAmount!}</@th>
                <@th>${uiLabelMap.CommonPaid!}</@th>
                <@th>${uiLabelMap.CommonOutStanding!}</@th>
            </@tr>
        </@thead>
        <#list invoicePaymentInfoList as item>
            <#assign itemType = item.getRelatedOne("TermType", false)/>
            <@tr>
                <@td>${itemType.get("description",locale)!}</@td>
                <@td><@formattedDateTime date=item.dueDate /></@td>
                
                <@td><@ofbizCurrency isoCode=invoice.currencyUomId amount=item.amount!/></@td>
                <@td><@ofbizCurrency isoCode=invoice.currencyUomId amount=item.paidAmount!/></@td>
                <@td><strong><@ofbizCurrency isoCode=invoice.currencyUomId amount=item.outstandingAmount!/></strong></@td>
            </@tr>
        </#list>
  </@table>
</@section>