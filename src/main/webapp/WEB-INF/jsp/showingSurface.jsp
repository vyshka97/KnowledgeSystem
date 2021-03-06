<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<jsp:include page="partOne.jsp"/>

<style>
    .tree, .tree ul {
        margin: 0;
        padding: 0;
        list-style: none
    }
    .tree ul {
        margin-left: 1em;
        position: relative
    }
    .tree ul ul {
        margin-left: .5em
    }
    .tree ul:before {
        content: "";
        display: block;
        width: 0;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        border-left: 1px solid
    }
    .tree li {
        margin: 0;
        padding: 0 1em;
        line-height: 2em;
        color: #369;
        font-weight: 700;
        position: relative
    }
    .tree ul li:before {
        content: "";
        display: block;
        width: 10px;
        height: 0;
        border-top: 1px solid;
        margin-top: -1px;
        position: absolute;
        top: 1em;
        left: 0
    }
    .tree ul li:last-child:before {
        background: #f0f0f0;
        height: auto;
        top: 1em;
        bottom: 0
    }
    .indicator {
        margin-right: 5px;
    }
    .tree li a {
        text-decoration: none;
        color: #369;
    }
    .tree li button, .tree li button:active, .tree li button:focus {
        text-decoration: none;
        color: #369;
        border: none;
        background: transparent;
        margin: 0px 0px 0px 0px;
        padding: 0px 0px 0px 0px;
        outline: 0;
    }
    div.nested {
        display: inline;
    }
    #menu {
        float: left;
        background: #f0f0f0;
        width: 20%;
        height: 100%;
    }
    #content {
        float: right;
        width: 75%;
    }
    #settings{
        float: right;
        display: inline-block;
        position: relative;
        top: 20px;
        right: 50px;
    }
</style>



<script>
    function del()//?????????? ??????????????
    {
        if(confirm('???????????????'))
        /*?????????????? ???? ?????????????????????? ??????????
        ?? ?????????????? ???????????????? "????" ?????? "????????????"*/
        {

        }
    }
</script>


<div id="content">
    <form method="get" action="/surfaces/${surface.id}/findPages">

        <p><input name="word" type="text" placeholder="?????????????? ???????????????? ????????????????"/></p>

        <p><button type="submit" class="btn btn-primary" value="Find">????????????</button></p>

    </form>

    <h1 style="display: inline-block">
        ${surface.name}
        <c:choose>
            <c:when test="${surface.accessType == 'public'}">
                (????????????????)
            </c:when>
            <c:when test="${surface.accessType == 'private'}">
                (????????????????)
            </c:when>
        </c:choose>
    </h1>
    <h2>????????????????</h2>
    <c:choose>
        <c:when test="${surface.description != null && surface.description != ''}">
    <p>${surface.description}</p>
        </c:when>
        <c:otherwise>
            <p>?? ?????????? ???????????????????????? ?????????????????????? ????????????????</p>
        </c:otherwise>
    </c:choose>
    <h2>????????????????????????:</h2>
    <c:forEach var="user" items="${users}">
        <p>
                ${user.surname}
            <c:if test="${user.id == surface.adminId}">
                (??????????????????)
            </c:if>
        </p>
    </c:forEach>
    <div class="dropdown" id="settings">
        <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
            ??????????
        </button>
        <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
            <c:if test="${user.id == surface.adminId}">
            <a class="dropdown-item" href="/surfaces/delete/${surface.id}" onclick="return del()">??????????????</a>
            </c:if>
            <c:if test="${surface.adminId == user.id || surface.accessType == 'private'}">
            <a class="dropdown-item" href="/surfaces/${surface.id}/pages/new">???????????????? ???????????????? ????????????????</a>
            </c:if>
            <a class="dropdown-item" href="/surfaces/${surface.id}/findPages">?????????? ??????????????</a>
            <c:if test="${user.id == surface.adminId}">
            <a class="dropdown-item" href="/surfaces/edit/${surface.id}">??????????????????????????</a>
            </c:if>
            <c:if test="${user.id == surface.adminId}">
                <a class="dropdown-item" href="/surfaces/${surface.id}/findUser">???????????????? ???????????? ????????????????????????</a>
            </c:if>
            <c:if test="${surface.accessType == 'public' && !surface.users.contains(user)}">
                <a class="dropdown-item" href="/surfaces/${surface.id}/addUser/${user.id}">????????????????????????????</a>
            </c:if>
        </div>
    </div>
</div>

<div id="menu">
    <p style="color:#369">????????????????</p>
    <div class="container" style="margin-top:30px;">
        <div class="row">
            <div class="col-md-4">
                <ul id="tree3">
                    <c:set var="level" value="${1}"/>
                    <c:forEach var="page" items="${pageList}">

                    <c:if test="${page.level==level}">
                    </li>
                    <li>
                        <a href="/surfaces/${page.surface.id}/pages/show/${page.id}">${page.name}</a>
                        </c:if>

                        <c:if test="${page.level>level}">
                        <div class="nested">
                            <ul>
                                <li>
                                    <a href="/surfaces/${page.surface.id}/pages/show/${page.id}">${page.name}</a>

                                    <c:set var="level" value="${page.level}"/>
                                    </c:if>

                                    <c:if test="${page.level<level}">
                                    <c:forEach var="i" begin="1" end="${level - page.level}">
                                </li>
                            </ul>
                        </div>
                    </li>
                    </c:forEach>
                    <c:set var="level" value="${page.level}"/>
                    <li>
                        <a href="/surfaces/${page.surface.id}/pages/show/${page.id}">${page.name}</a>

                        </c:if>


                        </c:forEach>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</div>


<script language="JavaScript">
    $.fn.extend({
        treed: function (o) {
            var openedClass = 'glyphicon-minus-sign';
            var closedClass = 'glyphicon-plus-sign';
            if (typeof o != 'undefined') {
                if (typeof o.openedClass != 'undefined') {
                    openedClass = o.openedClass;
                }
                if (typeof o.closedClass != 'undefined') {
                    closedClass = o.closedClass;
                }
            }
            ;
//initialize each of the top levels
            var tree = $(this);
            tree.addClass("tree");
            tree.find('.nested').has("ul").each(function () {
                var branch = $(this); //li with children ul
                branch.prepend("<i class='indicator glyphicon " + closedClass + "'></i>");
                branch.addClass('branch');
                branch.on('click', function (e) {
                    if (this == e.target) {
                        var icon = $(this).children('i:first');
                        icon.toggleClass(openedClass + " " + closedClass);
                        $(this).children().children().toggle();
                    }
                })
                branch.children().children().toggle();
            });
//fire event from the dynamically added icon
            tree.find('.branch .indicator').each(function () {
                $(this).on('click', function () {
                    $(this).closest('.nested').click();
                });
            });
//fire event to open branch if the li contains an anchor instead of text
            tree.find('.branch>a').each(function () {
                $(this).on('click', function (e) {
                    $(this).closest('.nested').click();
                    e.preventDefault();
                });
            });
//fire event to open branch if the li contains a button instead of text
            tree.find('.branch>button').each(function () {
                $(this).on('click', function (e) {
                    $(this).closest('.nested').click();
                    e.preventDefault();
                });
            });
        }
    });
    //Initialization of treeviews
    $('#tree1').treed();
    $('#tree2').treed({openedClass: 'glyphicon-folder-open', closedClass: 'glyphicon-folder-close'});
    $('#tree3').treed({openedClass: 'glyphicon-chevron-right', closedClass: 'glyphicon-chevron-down'});
</script>
<jsp:include page="partTwo.jsp"/>