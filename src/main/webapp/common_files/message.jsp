<%
    //get data from http session
    String msg = (String) session.getAttribute("msg");
    String color = (String) session.getAttribute("color");

    if (msg != null) {
%>

<!--alert message for success or failure in any condition-->
<div class="alert alert-<%= color%> alert-dismissible fade show text-center" role="alert">
    <strong><%= msg%></strong>

    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
    </button>
</div>

<%
    }
    session.removeAttribute("msg");
    session.removeAttribute("color");
%>