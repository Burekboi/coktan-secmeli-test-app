<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="layout" tagdir="/WEB-INF/tags" %>

<layout:layout pageTitle="Özet">
    <div class="container mt-4">
        <h3>Test Cevap Özeti</h3>
        <ul class="list-group">
            <c:forEach var="ans" items="${answers}" varStatus="status">
                <li class="list-group-item">
                    <strong>Soru ${status.index + 1}:</strong>
                    <c:choose>
                        <c:when test="${ans != null}">
                            ${ans}
                        </c:when>
                        <c:otherwise>Boş</c:otherwise>
                    </c:choose>
                </li>
            </c:forEach>
        </ul>
    </div>
</layout:layout>
