<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html>
<head>

	    <link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">

	    <script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
	    <script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
	    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
	    
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
	
<title>Web - TCC</title>

<script type="text/javascript">

		$(document).ready(function() {
			
			//GET CURRENT URL
			var currentURL = window.location.pathname;
			console.log(currentURL);
			
			setTimeout(function() {
				$('.msg').fadeOut('slow');
			}, 1500);
			
		});

</script>

</head>
<body>

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="logged.jsp">Web TCC</a>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
          	<li><a href="${pageContext.request.contextPath}/project.jsp">Novo Projeto</a></li>
            <li><a href="${pageContext.request.contextPath}/project/findUserLogged">Meus Projetos</a></li>
            <li><a href="${pageContext.request.contextPath}/login/editUserLogged">Minha Conta</a></li>
            <li><a href="${pageContext.request.contextPath}/report">Relat�rios</a></li>
          </ul>
          
          <ul class="nav navbar-nav" style="margin-left:520px;">
            <li style="margin-top: 15px;font-size: 15px;color: darkgray;">Ol�, ${userLogged}!</li>
          </ul>
          
          <ul class="final" style="margin-left:1070px;">
          <li>
          <div class="col-md-12">
          		<a class="navbar-brand glyphicon glyphicon-off" href="logout.jsp"></a>
          </div>
          </li>
<!--           <a class="navbar-brand glyphicon glyphicon-off" href="logged.jsp">Sair</a></li> -->
<!--             <li><a href="login.jsp">Acesso ao Sistema</a></li> -->
<!--             <li><a href="register.jsp">Cadastrar</a></li> -->
<!--             <li><a href="#contact">Contato</a></li> -->
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </div>

    <div class="container">

    	<div class="starter-template" style="margin-top:150px;">
<!--         <h1>Bootstrap starter template</h1> -->
<!--         <p class="lead">Use this document as a way to quickly start any new project.<br> All you get is this text and a mostly barebones HTML document.</p> -->
<!--       </div> -->
      
      			<div class="col-md-12">
					<div id="dateCurrent" class="row dateCurrent">
					</div>
				</div>
				
				
		</div>
		
		<div class="msg" style="margin-top: 30px;margin-right: 50px;text-align: center;color:black;">${msg}</div>

    </div><!-- /.container -->

</body>
</html>