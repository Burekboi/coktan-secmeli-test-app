<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>

<fmt:setLocale value="${param.lang == 'en' ? 'en' : 'tr'}" scope="session"/>
<fmt:setBundle basename="messages" />
<c:set var="ctx" value="${pageContext.request.contextPath}" />

<layout:layout pageTitle="<fmt:message key='label.homePage'/>">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-success text-white">
                    <h4><fmt:message key="header.solvePanel"/></h4>
                </div>
                <div class="card-body">
                    <c:choose>
                        <c:when test="${not empty tests}">
                            <ul class="list-group list-group-flush">
                                <c:forEach var="test" items="${tests}">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${test.name}
                                        <a href="<c:url value='/tests/solve/${test.id}'/>"
                                           class="btn btn-sm btn-success">
                                            <fmt:message key="button.solveTest"/>
                                        </a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="alert alert-info text-center">
                                <fmt:message key="message.noAvailableTests"/>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</layout:layout>
