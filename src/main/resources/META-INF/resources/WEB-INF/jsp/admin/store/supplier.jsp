<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<%@ taglib prefix="rapid" uri="http://www.rapid-framework.org.cn/rapid"%> 
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/> 

<rapid:override name="head">  
    <title>供应商列表-永昌e篮子</title>
    <script>
    function del(id) {
		if(!id || !confirm("确定要删除吗?")) return;
		$.ajax({
   			url: "/admin/store/"+id,
   			type: "POST",
   			cache: false,
   			dataType: "json",
   			success: function(data) {
   				if(!data.status){
   					alert(data.message);
   					return;
   				}
   				if(data.status){
   					window.location.href = "${ctx}/admin/supplier";
   				}
   			},
   			error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert("服务器错误码:"+XMLHttpRequest.status);
            }
   		});
	}
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
                        <span>供应商管理</span>
                    </li>
                </ul>
                <div class="page-content-inner">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="portlet light">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa "></i>供应商列表 </div>
                                    <div class="actions">
                                        <a href="javascript:;" class="btn btn-circle btn-info add-btn"
                                        	onclick="location.href='${ctx}/admin/store/0?type=supplier'">
                                            <i class="fa fa-plus"></i>
                                            <span class="hidden-xs add-user"> 添加 </span>
                                        </a>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <div class="table-container">
                                        <table class="table table-striped table-bordered table-hover table-checkable" id="datatable_products">
                                            <thead>
                                                <tr role="row" class="heading">
                                                    <th width="1%"><input type="checkbox" class="group-checkable"> </th>
                                                    <th width="10%"> 编号 </th>
                                                    <th width="10%"> 名称 </th>
                                                    <th width="15%"> LOGO </th>
                                                    <th width="15%"> 级别 </th>
                                                    <th width="15%"> 联系人 </th>
                                                    <th width="15%"> 联系电话 </th>
                                                    <th width="10%"> 状态 </th>
                                                    <th width="10%"> 操作 </th>
                                                </tr>
                                            </thead>
                                            <tbody> 
                                            	<c:forEach  items="${userList.content}" var="data" varStatus="loopCounter">
                                            	<tr role="row" class="filter">
                                                    <td>
                                                    	<input type="checkbox" class="group-checkable"> 
                                                    </td>
                                                    <td>${data.id}</td>
                                                    <td>${data.company}</td>
                                                    <td>
                                                    	<c:if test="${empty data.logo}">
										                <img src="${ctx}/images/noimages.png" alt="" width="200" height="150"> 
										                </c:if>
                                    					<c:if test="${not empty data.logo}">
                                    					<img src="${ctx}/img?img=?img=${data.logo}" alt="" width="200" height="150" /> 
                                    					</c:if>
                                                    </td>
                                                    <td>
                                                    	<c:if test="${data.level==1}">A</c:if>
									                    <c:if test="${data.level==2}">B</c:if>
									                    <c:if test="${data.level==3}">C</c:if>
									                    <c:if test="${data.level==4}">D</c:if>级
									                </td>
                                                    <td>${data.name}</td>
                                                    <td>${data.phone}</td>
                                                    <td>
                                                    	<c:if test="${data.state==0}">未审核</c:if>
                                                    	<c:if test="${data.state==1}">正常</c:if>
                                                    	<c:if test="${data.state==2}">停止</c:if>
                                                    </td>
                                                    <td>
                                                        <div class="margin-bottom-5">
                                                            <button class="btn btn-sm btn-success filter-submit margin-bottom" onclick="location.href='${ctx}/admin/store/${data.id}'">
                                                                <i class="fa "></i> 编辑
                                                            </button>
	                                                        <button class="btn btn-sm btn-default filter-cancel margin-bottom"
	                                                        onclick="del(${data.id})">
	                                                            <i class="fa "></i> 删除
	                                                        </button>
	                                                        <c:if test="${data.state==0}">
	                                                        <button class="btn btn-sm btn-success filter-submit margin-bottom" 
                                                            onclick="location.href='${ctx}/admin/store/${data.id}'">
                                                                <i class="fa "></i> 审核
                                                            </button>
	                                                        </c:if>
                                                        </div>
                                                        <div class="margin-bottom-5">
                                                        </div>
                                                    </td>
                                                </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                	
                                	<tags:pagination page="${userList}"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <a href="javascript:;" class="page-quick-sidebar-toggler">
        <i class="icon-login"></i>
    </a>
</div>
</rapid:override> 
    
<%@include file="../../common/layout.jsp" %>