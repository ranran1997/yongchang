<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>商品汇总信息报表-永昌e篮子</title>
    <link href="${ctx}/msun/global/plugins/bootstrap-datepicker/css/bootstrap-datepicker3.min.css" rel="stylesheet" type="text/css" />
    <script src="${ctx}/js/bootstrap-datepicker.min.js" type="text/javascript"></script>
    
    <script>
    $(function () {
    	$(".btn-export").click(function() {
	    	var form=$("<form>");//定义一个form表单
	    	form.attr("style","display:none");
	    	form.attr("target","");
	    	form.attr("method","post");
	    	form.attr("action","${ctx}/admin/rpt/item");
	    	var input1=$("<input>");
	    	input1.attr("type","hidden");
	    	input1.attr("name","exportData");
	    	input1.attr("value",(new Date()).getMilliseconds());
	    	$("body").append(form);//将表单放置在web中
	    	form.append(input1);
	    	form.submit();
    	});
    	$(".btn-search").click(function() {
    		var start=$('#date-start').val();
    		var end=$('#date-end').val();
    		window.location.href = "${ctx}/admin/rpt/item?start="+start+"&end="+end;
    	});
    	
    	$('#date-picker-start').datetimepicker({  
	   	      format: 'yyyy-MM-dd hh:mm',  
	   	      language: 'ch',  
	   	      pickDate: true,  
	   	      pickTime: true,  
	   	      hourStep: 1,  
	   	      minuteStep: 15,  
	   	      secondStep: 30,  
	   	      inputMask: true  
   	    });
    	$('#date-picker-end').datetimepicker({  
	   	      format: 'yyyy-MM-dd hh:mm',  
	   	      language: 'ch',  
	   	      pickDate: true,  
	   	      pickTime: true,  
	   	      hourStep: 1,  
	   	      minuteStep: 15,  
	   	      secondStep: 30,  
	   	      inputMask: true  
 	    });
    })
    </script>
</rapid:override> 

<rapid:override name="content">     
<div class="page-container">
    <div class="page-content-wrapper">
        <div class="page-head">
            <div class="container"><div class="page-title"><h1></h1></div></div>
        </div>
        <div class="page-content">
            <div class="container">
                <ul class="page-breadcrumb breadcrumb">
                    <li>
                        <a href="${ctx}/">首页</a>
                        <i class="fa fa-circle"></i>
                    </li>
                    <li>
                        <span>商品信息汇总</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>商品信息汇总列表 </div>
                                    
                                </div>  
								<div class="portlet-title"> 
                                    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-4">开始日期</label>
								            <div class="col-md-2">
								                <div id="date-picker-start" class="input-group input-medium">
								                    <input type="text" id="date-start" class="form-control" value="${start}" readonly>
								                    <span class="input-group-btn add-on">
								                        <button class="btn default " type="button">
								                            <i class="fa fa-calendar"></i>
								                        </button>
								                    </span>
								                </div>
								            </div>
								        </div>
								    </div>
								 
								    <div class="col-md-4 col-sm-12">
								        <div class="table-group-actions pull-left">
								            <label class="control-label col-md-4">结束日期</label>
								            <div class="col-md-2">
								                <div id="date-picker-end" class="input-group input-medium">
								                    <input type="text" id="date-end" class="form-control" value="${end}" readonly>
								                    <span class="input-group-btn add-on">
								                        <button class="btn default " type="button">
								                            <i class="fa fa-calendar"></i>
								                        </button>
								                    </span>
								                </div>
								            </div>
								        </div>
								    </div>
								    
                                    <div class="actions">
									    <a href="javascript:;" class="btn btn-circle btn-info btn-search">
									        <i class="fa fa-search"></i>
									        <span class="hidden-xs"> 搜索 </span>
									    </a>
									    <div class="btn-group">
									        <a class="btn btn-circle btn-default dropdown-toggle" href="javascript:;" data-toggle="dropdown" aria-expanded="false">
									            <i class="fa fa-share"></i>
									            <span class="hidden-xs"> 导出 </span>
									            <i class="fa fa-angle-down"></i>
									        </a>
									        <div class="dropdown-menu pull-right">
									            <li>
									                <a href="javascript:;" class="hidden-xs btn-export"> 导出Excel </a>
									            </li>
									        </div>
									    </div>
									</div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="10%"> 编号 </th>
                                                    <th width="15%"> 商品名称 </th>
                                                    <th width="10%"> 销量(千克) </th>
                                                    <th width="10%"> 价格(元/千克) </th>
                                                    <th width="10%"> 金额(元) </th>
                                                    <th width="15%"> 供应商 </th>
                                                    <th width="15%"> 汇总日期 </th>
                                                    <th width="8%"> 成本(元) </th>
                                                    <th width="8%"> 运费(元) </th>
                                                    <th width="8%"> 损耗(元) </th>
                                                    <th width="8%"> 利润(元) </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach items="${itemSumList}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>${data.id}</td>
                                                    <td>
                                                    ${data.item.title}
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.item.getItemFullPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getItemFullPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>${data.item.user.company}</td>
                                                    <td><fmt:formatDate value="${data.createTime}" pattern="yyyy-MM-dd"/></td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getItemPrice()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getFreight()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getLoss()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                    <td>
                                                    	<fmt:formatNumber value="${data.count*data.item.getPriceAddAmount()}" type="currency" pattern="#0.00"/>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>