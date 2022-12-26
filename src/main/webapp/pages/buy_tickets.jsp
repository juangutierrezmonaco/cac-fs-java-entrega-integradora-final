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
	Ticket ticket = new Ticket();
	ticket.setFirstname(request.getParameter("firstname"));
	ticket.setLastname(request.getParameter("lastname"));
	ticket.setEmail(request.getParameter("email"));
	ticket.setQuantity(Integer.parseInt(request.getParameter("ticketsQuantity")));
	ticket.setCategory(request.getParameter("selectedCategory"));
	TicketDAO t_dao = new TicketDAO();
	int id = t_dao.createTicket(ticket);

	String selectedCategory = request.getParameter("selectedCategory");
	String[] categorys = { "Estudiante", "Trainee", "Junior" };
	%>

	<%
	if (id < 0) { // the ticket isn't created
		out.println("<main><h1>No se pudo realizar la compra debido a un error.</h1></main>");
	} else {
	%>

	<main>
		<h1>¡Compraste tus tickets correctamente!</h1>

		<form class="ticket" action="">
			<div class="input-group">
				<span class="input-group-text bg-white">ID de la operación:</span> <input
					class="form-control" name="ticketId" id="ticketId" type="text"
					value="<%=id%>" readonly>
			</div>

			<div class="input-group">
				<span class="input-group-text bg-white">Nombre:</span> 
				<input class="form-control" type="text"
					value="<%=request.getParameter("firstname")%>" id="firstname"
					name="firstname">
			</div>

			<div class="input-group">
				<span class="input-group-text bg-white">Apellido:</span> <input
					class="form-control" type="text"
					value="<%=request.getParameter("lastname")%>" id="lastname"
					name="lastname">
			</div>

			<div class="input-group">
				<span class="input-group-text bg-white">Email:</span> <input
					class="form-control" type="email"
					value="<%=request.getParameter("email")%>" id="email" name="email">
			</div>

			<div class="input-group">
				<span class="input-group-text bg-white">Cantidad de tickets:</span>
				<input class="form-control" type="number"
					value="<%=request.getParameter("ticketsQuantity")%>"
					id="ticketsQuantity" name="ticketsQuantity">
			</div>

			<div class="input-group">
				<span class="input-group-text bg-white">Categoría:</span> <select
					id="selectedCategory" name="selectedCategory" class="form-select">
					<%
					for (String category : categorys) {
						if (selectedCategory.equals(category)) {
							out.println("<option value=\"" + category + "\" selected>" + category + "</option>");
						} else {
							out.println("<option value=" + category + ">" + category + "</option>");
						}
					}
					%>
				</select>
			</div>

			<div class="d-flex gap-2 justify-content-stretch mt-5">
				<button type="submit" class="btn btn-submit flex-grow-1"
					value="update">Modificar</button>
				<button type="submit" class="btn btn-submit flex-grow-1"
					value="delete">Eliminar</button>
			</div>
		</form>
		
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

	<!-- JS -->
	<script src="../js/modify_tickets.js"></script>

	<!-- Bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-u1OknCvxWvY5kfmNBILK2hRnQC3Pr17a+RTT6rIHI7NnikvbZlHgTPOOmMi466C8"
		crossorigin="anonymous"></script>

	<!-- Sweet Alert -->
	<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>

</html>