<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>

<fmt:setLocale value="${param.lang == 'en' ? 'en' : 'tr'}" scope="session"/>
<fmt:setBundle basename="messages" />

<layout:layout pageTitle="<fmt:message key='summary.title'/>">
    <div class="container mt-4">
        <h3><fmt:message key="summary.header"/></h3>

        <p><strong><fmt:message key="summary.testId"/></strong> ${testId}</p>
        <p><strong><fmt:message key="summary.correctCount"/></strong> ${correct}</p>
        <p><strong><fmt:message key="summary.incorrectCount"/></strong> ${incorrect}</p>

        <hr/>

        <ul class="list-group">
            <c:forEach var="ans" items="${answers}" varStatus="status">
                <li class="list-group-item">
                    <strong><fmt:message key="summary.question"/> ${status.index + 1}:</strong>
                    <c:choose>
                        <c:when test="${ans != null}">
                            ${ans}
                        </c:when>
                        <c:otherwise><fmt:message key="summary.emptyAnswer"/></c:otherwise>
                    </c:choose>
                </li>
            </c:forEach>
        </ul>

        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">
                <fmt:message key="summary.backToTestList"/>
            </a>
        </div>
    </div>
</layout:layout>