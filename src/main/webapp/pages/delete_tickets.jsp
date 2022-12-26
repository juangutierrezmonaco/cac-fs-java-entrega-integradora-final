<%@page import="model.Ticket"%>
<%@page import="model.TicketDAO"%>
<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Conf Bs As - Codo a Codo</title>
<link rel="shortcut icon" href="../assets/images/codoacodo.png">

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-iYQeCzEYFbKjA/T2uDLTpkwGzCiq6soy8tYaI1GyVh/UjpbCx/TYkiZhlZB6+fzT"
	crossorigin="anonymous">

<!-- CSS -->
<link rel="stylesheet" href="../css/style.css">
</head>

<body>
	<header class="header sticky-top">
		<!-- Navbar -->
		<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-lg-5">
			<div class="container-fluid">
				<!-- Logo -->
				<a class="navbar-brand" href="../index.html"> <img
					src="../assets/images/codoacodo.png" alt="Logo Codo a Codo">
					<span>Conf Bs As</span>
				</a>

				<!-- Ícono de hamburguesa -->
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<!-- Items del Navbar -->
				<div class="collapse navbar-collapse justify-content-end"
					id="navbarSupportedContent">
					<ul class="navbar-nav text-end text-lg-start">

						<li class="nav-item"><a class="nav-link" aria-current="page"
							href="../index.html">La conferencia</a></li>

						<li class="nav-item"><a class="nav-link"
							href="../index.html#speakers">Los oradores</a></li>

						<li class="nav-item"><a class="nav-link"
							href="../index.html#location">El lugar y la fecha</a></li>

						<li class="nav-item"><a class="nav-link"
							href="../index.html#joinToSpeakers">Conviértete en orador</a></li>

						<li class="nav-item"><a
							class="nav-link text-success text-decoration-underline"
							href="../pages/buy_tickets.html">Comprar tickets</a></li>
					</ul>
				</div>

			</div>
		</nav>
	</header>
	<%
	int id = Integer.parseInt(request.getParameter("ticketId"));
	TicketDAO t_dao = new TicketDAO();
	boolean result = t_dao.deactivateTicket(id);
	%>

	<%
	if (!result) {
		out.println("<main><h1>No se pudo eliminar el ticket debido a un error.</h1></main>");
	} else {
	%>

	<main>
		<h1>¡Eliminaste tus tickets correctamente!</h1>
		
		<a href="buy_tickets.html" class="text-center mt-5">Volver</a>
	</main>
	
	<%
	}
	%>
	<footer>
		<div class="container p-4">
			<div
				class="footer text-center px-5 d-flex justify-content-between align-items-center row">

				<div class="col-12 col-lg-1">
					<a href="#">Preguntas frecuentes</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Contáctanos</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Prensa</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Conferencias</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Términos y condiciones</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Privacidad</a>
				</div>

				<div class="col-12 col-lg-1">
					<a href="#">Estudiantes</a>
				</div>
			</div>
		</div>
	</footer>

	<!-- Bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>

	<!-- Sweet Alert -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>

</html>