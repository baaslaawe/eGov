<c:if test="${!details.measurementSheets.isEmpty() }">
	<!--only for validity head start -->                         
    <table>
	    <tr>
	        <td colspan="15"><!--only for validity head end -->
	            <div class="view-content">Measurement Sheet <div class="pull-right"><span class="glyphicon glyphicon-remove-circle error-msg hide-ms" style="cursor:pointer;font-size:16px;"></span></div>
	            <table class=" table table-bordered" id="sorMbDetails[${item.index }].mstable">
	                <thead>
	                	<tr>
		                    <th colspan="1"></th>
		                    <th colspan="7">Estimated</th>
		                    <th colspan="6">Actuals</th>
	                    </tr>
	                    <tr>
		                    <th>S.no</th>
		                    <th>Description</th>
		                    <th>Number</th>
		                    <th>Length</th>
		                    <th>Width</th>
		                    <th>Depth/Height</th>
		                    <th>Quantity</th>
		                    <th>Deduction</th>
		                    <th>Remarks</th>
		                    <th>Number</th>
		                    <th>Length</th>
		                    <th>Width</th>
		                    <th>Depth/Height</th>
		                    <th>Quantity</th>
	                    </tr>
	                </thead>
	                <tbody>
	                	<c:forEach items="${details.measurementSheets}" var="mbms" varStatus="index">
	                		<tr>
			                	<td hidden="true">
			                        <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].id" id="sorMbDetails_${item.index }_measurementSheets_${index.index }_id" />
			                        <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].woMeasurementSheet" id="sorMbDetails_${item.index }_measurementSheets_${index.index }_woMeasurementSheet" />
			                    </td>
			                	<td id="msrowslNo_${item.index }_${index.index }">${mbms.woMeasurementSheet.measurementSheet.slNo }</td>
			                    <td id="msrowremarks_${item.index }_${index.index }">${mbms.woMeasurementSheet.measurementSheet.remarks }</td>
			                    <td id="msrowno_${item.index }_${index.index }">${mbms.woMeasurementSheet.no }</td>
			                    <td id="msrowlength_${item.index }_${index.index }">${mbms.woMeasurementSheet.length }</td>
			                    <td id="msrowwidth_${item.index }_${index.index }">${mbms.woMeasurementSheet.width }</td>
			                    <td id="msrowdepthOrHeight_${item.index }_${index.index }">${mbms.woMeasurementSheet.depthOrHeight }</td>
			                    <td id="msrowquantity_${item.index }_${index.index }">${mbms.woMeasurementSheet.quantity }</td>
			                    <c:if test="${mbms.woMeasurementSheet.measurementSheet.identifier == 'A'}">
									<c:set var="total" value="${total + mbms.woMeasurementSheet.quantity}" />
								</c:if>
								<c:if test="${mbms.woMeasurementSheet.measurementSheet.identifier == 'D'}">
									<c:set var="total" value="${total - mbms.woMeasurementSheet.quantity}" />
								</c:if>
			                    <td id="msrowidentifier_${item.index }_${index.index }">
			                    	<c:choose>
			                    		<c:when test="${mbms.woMeasurementSheet.measurementSheet.identifier == 'A'}">No</c:when>
			                    		<c:otherwise>Yes</c:otherwise>
			                    	</c:choose>
			                    </td>
			                    <td>
			                        <form:textarea path="sorMbDetails[${item.index }].measurementSheets[${index.index }].remarks" id="sorMbDetails[${item.index }].measurementSheets[${index.index }].remarks" class="form-control text-left patternvalidation runtime-update"
			                               data-pattern="alphanumeric" maxlength="1024" ></form:textarea>
			
			                    </td>
			                    <td>
			                        <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].no"  id="sorMbDetails[${item.index }].measurementSheets[${index.index }].no" class="form-control text-right patternvalidation runtime-update"
			                               data-pattern="decimalvalue" data-idx="0" />
			
			                    </td>
			                    <td>                                                                     
			                        <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].length" id="sorMbDetails[${item.index }].measurementSheets[${index.index }].length" class="form-control text-right patternvalidation runtime-update"
			                               data-pattern="decimalvalue" data-idx="0" />
			
			                    </td>
			                    <td>
			                        <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].width" id="sorMbDetails[${item.index }].measurementSheets[${index.index }].width" class="form-control text-right patternvalidation runtime-update"
			                               data-pattern="decimalvalue"  data-idx="0" />
			
			                    </td>
			                    <td>
				                    <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].depthOrHeight" id="sorMbDetails[${item.index }].measurementSheets[${index.index }].depthOrHeight" class="form-control text-right patternvalidation runtime-update"
				                           data-pattern="decimalvalue"  data-idx="0" />
			
			                	</td>
			                	<td>
				                    <form:input path="sorMbDetails[${item.index }].measurementSheets[${index.index }].quantity" id="sorMbDetails[${item.index }].measurementSheets[${index.index }].quantity" class="form-control text-right patternvalidation runtime-update"
				                           data-pattern="decimalvalue" onblur="findNet(this)" />
									<c:if test="${mbms.woMeasurementSheet.measurementSheet.identifier == 'A'}">
										<c:set var="net" value="${net + mbms.quantity}" />
									</c:if>
									<c:if test="${mbms.woMeasurementSheet.measurementSheet.identifier == 'D'}">
										<c:set var="net" value="${net - mbms.quantity}" />
									</c:if>
			                	</td>
			                </tr>
	                	</c:forEach>
		                <tr>
		                	<td colspan="5"></td>
		                    <td class="text-right">Total</td>
		                    <td class="text-right view-content">${total }</td>
		                    <td colspan="4" class="text-right">
		                        <button name="resetButton" id="resetButton" class="btn btn-xs btn-danger">Reset</button>
		                        <input type="button" value="Submit" id="sorMbDetails[${item.index }].mssubmit" class="btn btn-xs btn-primary ms-submit mssubmit_${item.index }"/> 
		                    </td>
		                    <td class="text-right">Total</td>
		                    <td id="sorMbDetails[${item.index }].msnet" class="text-right">${net}</td>
		                    <td></td>
		                </tr>
	                </tbody>
	            </table>
	        <!--only for validity tail start -->  
	        </td>
        </tr><!--only for validity -->
    </table> <!--only for validity tail end -->
</c:if>