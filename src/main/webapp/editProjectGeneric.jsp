<!DOCTYPE html>
<html>
<head>
<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet">
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
<script src="https://raw.githubusercontent.com/hongymagic/jQuery.serializeObject/master/dist/jquery.serializeObject.min.js" type="text/javascript"></script>

<title>Web - TCC</title>

<script type="text/javascript">
$(document).ready(function(){
	
	$.fn.serializeObject=function(){"use strict";var a={},b=function(b,c){var d=a[c.name];"undefined"!=typeof d&&d!==null?$.isArray(d)?d.push(c.value):a[c.name]=[d,c.value]:a[c.name]=c.value};return $.each(this.serializeArray(),b),a};
	
	var url   = window.location.search.replace("?", "");
	window.history.pushState(null, null, 'http://localhost:8080/web-test/indexUser.jsp');
	var id = url.split("&");
	$.ajax({
		url : "project/findById/"+id,
		type : "GET",
		success : function(response) {
			
			$('.textCenterAcess').find('.name').val(response.title);
			$('.textCenterAcess').find('.description').val(response.description);
			$('.textCenterAcess').find('.keyWords').val(response.keyWords);
			$('.textCenterAcess').find('.discipline').val(response.discipline);
			$('.textCenterAcess').find('.deliveryDate').val(response.deliveryDate);
			$('.textCenterAcess').find('.id').val(response.projectId);
				
			}
		});
	
	$('.textCenterAcess').find('.btn-warning').off('click');
	$('.textCenterAcess').find('.btn-warning').on('click', function(){
			window.location.href='http://localhost:8080/web-test/myProjects.jsp';
	});
	
	$('.textCenterAcess').find('.btn-success').off('click');
	$('.textCenterAcess').find('.btn-success').on('click', function(){
// 		var postData = $(this).closest('form').serializeObject();
		var name = $('.textCenterAcess').find('.name').val();
		var description = $('.textCenterAcess').find('.description').val();
		var keyWords = $('.textCenterAcess').find('.keyWords').val();
		var discipline = $('.textCenterAcess').find('.discipline').val();
		var deliveryDate = $('.textCenterAcess').find('.deliveryDate').val();
		var id = $('.textCenterAcess').find('.id').val();
		$.ajax({
			url : "project/update",
			type : "POST",
			data : {"name":name,
        			"description":description,
        			"keyWords":keyWords,
       				"discipline":discipline,
      				"deliveryDate":deliveryDate,
      				"id":id},
			success : function(response) {
// 				console.log(reponse);
// 				console.log(reponse);
// 				$('.textCenterAcess').find('.name').val(response.title);
// 				$('.textCenterAcess').find('.description').val(response.description);
// 				$('.textCenterAcess').find('.keyWords').val(response.keyWords);
// 				$('.textCenterAcess').find('.discipline').val(response.discipline);
// 				$('.textCenterAcess').find('.deliveryDate').val(response.deliveryDate);
// 				$('.textCenterAcess').find('.id').val(response.id);
			},
			error : function(erro){
				console.log(erro);
			}
		});
	});
	
	
	
});
</script>

</head>
<body>
	<!--  CHAMADA MENU FIXO PARA USU�RIO SEM ACESSO E SCRIPT/LINK BOOTSTRAP E JQUERY -->
	<div id="header">
    	<jsp:include page="menuUserLogged.jsp"/>
	</div>
	
	<div class="msg" style="margin: auto; text-align: center; color: red;margin-bottom: 10px;">
			${message}
	</div>
	
	 <div class="container" style="margin-top: -30px;">
	
		<div class="titleTCC" style="width: 70%;margin: auto;">
	
			<h3 style="padding: 10px 15px;text-align: center;">
				Editar Dados do Projeto
			</h3>
		</div>
		
		<div class="textCenterAcess" style="text-align: center;">
			<div class="col-md-12">
				<form:form>
					<div class="form-inline">
						<div class="col-md-12">
							<div>
								<span style="color: darkblue;font-style: italic;">T�tulo</span>
							</div>
							<input id="title" maxlength="200" name="title" type="text" class="form-control name" style="width: 100%;margin-bottom: 15px;">
						</div>
						<div class="col-md-6">
							<div>
								<span style="color: darkblue;font-style: italic;">Descri��o</span>
							</div>
							<textarea rows="4" cols="50" maxlength="3000" class="form-control description" id="description" name="description" style="width: 100%;margin-bottom: 15px;" placeholder="Descri��o"></textarea>
<!-- 							<input id="description" name="description" type="text" class="form-control" style="margin:auto;margin-bottom: 15px;" placeholder="Descri��o"> -->
						</div>
						<div class="col-md-6">
							<div>
								<span style="color: darkblue;font-style: italic;">Palavras Chaves</span>
							</div>
							<input id="keyWords" name="keyWords" maxlength="200" type="text" class="form-control keyWords" style="width: 100%;margin-bottom: 15px;" placeholder="Palavras Chaves">
						</div>
						<div class="col-md-6">
							<div>
								<span style="color: darkblue;font-style: italic;">Disciplina</span>
							</div>
							<input id="discipline" name="discipline" maxlength="200" type="text" class="form-control discipline" style="width: 100%;margin-bottom: 15px;" placeholder="Disciplina">
						</div>
						<div class="col-md-12" style="text-align: left;">
							<div>
								<span style="color: darkblue;font-style: italic;">Data da Entrega</span>
							</div>
							<input id="deliveryDate" name="deliveryDate" type="date" class="form-control deliveryDate" style="margin:auto;margin-bottom: 15px;min-width: 197px;" placeholder="Data da Entrega">
						</div>
						<div class="col-md-12" style="text-align: left;">
							<div>
								<span style="color: darkblue;font-style: italic;">ID</span>
							</div>
							<input id="id" name="id" readonly type="text" class="form-control id" style="margin:auto;margin-bottom: 15px;min-width: 197px;" placeholder="id">
						</div>
					</div>
					<div class="form-group">
						<div class="col-md-12" style="margin-bottom : 100px;">
							<div>
								<button type="submit" class="btn btn-success" style="width:150px">Atualizar</button>
								<button type="submit" class="btn btn-warning" style="margin-left: 15px;">Voltar</button>
							</div>
						</div>
					</div>
				</form:form>
			</div>
		</div>

	</div>

</body>
</html>