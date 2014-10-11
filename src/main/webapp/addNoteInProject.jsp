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
<script type="text/javascript" src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<title>Web - TCC</title>
<script type="text/javascript">

$(document).ready(function() {
	
	var url   = window.location.search.replace("?", "");
	window.history.pushState(null, null, 'http://localhost:8080/web-test/indexUser.jsp');
	var id = url.split("&");
	
	$('.container').data('projectid', id);
	$('#description').focus();
    
    $.ajax({
			url : "project/searchNotes/"+id,
			type : "GET",
			success : function(response) {
				console.log(response);
				var tr 	= '<tr>';
				var i = 1;
				$.each(response, function(index, value) {
					tr 	+= '	<td class="id">'+i+'</td>'
						+  '	<td class="name">'+value.userCreator+'</td>'
						+  '	<td class="data">'+value.dateCreated+'</td>'
						+  '	<td class="description" style="word-break: break-all;">'+value.description+'</td>'
						+  ' </tr>';
						i++;
				});
			
				$('.tbNotes').append(tr);
			}
		});
		
	
	$('.btnSaveNote').off('click');
	$('.btnSaveNote').on('click', function(){
		var projectId = $('.container').data('projectid');
		var description = $('.container').find('#description').val();
		var intProjectId = parseInt(projectId);
		var nextId = $( "tr:last" ).find('.id').text();
		nextId++;
		$.ajax({
			url : "project/createNote",
			type : "POST",
			data: { "projectId":intProjectId,
	            	"description":description},
			success : function(response) {
// 				console.log(reponse);
				var tr 	= '<tr>'
						+ '		<td class="id">'+nextId+'</td>'
						+ '		<td class="name">'+response.userCreator+'</td>'
						+ '		<td class="data">'+response.dateCreated+'</td>'
						+ '		<td class="description" style="word-break: break-all;">'+response.description+'</td>'
						+ '</tr>';
				$('.tbNotes').append(tr);
				
			},
			error : function(data){
				console.log(data);
			}
		});
	});
	
	$('.btnClean').off('click');
	$('.btnClean').on('click', function(){
		$('#description').val('');
		$('#description').focus();
	});
	
});
</script>
</head>
<body>
	
	<!--  CHAMADA MENU FIXO PARA USU�RIO COM ACESSO E SCRIPT/LINK BOOTSTRAP E JQUERY -->
	<div id="header">
    	<jsp:include page="menuUserLogged.jsp"/>
	</div>
	<div class="container" style="margin-top: -20px" data-projectid="">
		<div class="col-md-12 panel panel-default" style="margin-top: 30px;">
			<table class="table">
				<thead>
					<tr>
						<th style="text-transform: uppercase;">#</th>
						<th style="text-transform: uppercase;">Usu�rio</th>
						<th style="text-transform: uppercase;">Data</th>
						<th style="text-transform: uppercase;width: 50%;">Coment�rios</th>
					</tr>
				</thead>
				<tbody class="tbNotes" data-projectId="">
				</tbody>
			</table>
		</div>
		
		<div class="row">
			<div class="col-md-12">
				<span style="color: darkblue;font-style: italic;" id="coment">Coment�rios</span>
				<textarea rows="5" cols="200" maxlength="255" class="form-control" id="description" name="description" style="width: 100%;margin-bottom: 15px;max-width: 100%;" placeholder="Descri��o"></textarea>
			</div>
<!-- 			<div class="col-md-2"> -->
<!-- 				<span style="color: darkblue;font-style: italic;">Data</span> -->
<!-- 				<input id="dataCriacao" name="dataCriacao" type="date" class="form-control"> -->
<!-- 			</div> -->
		</div>
		<div class="form-group">
			<div class="col-md-12" style="margin-bottom: 20px">
				<div>
					<button type="submit" class="btn btn-success btnSaveNote">Salvar</button>
					<button type="submit" class="btn btn-warning btnClean">Limpar</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>