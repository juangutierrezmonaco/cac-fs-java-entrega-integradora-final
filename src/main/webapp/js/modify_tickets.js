const modifyForms = document.querySelectorAll('.ticket');

for (const modifyForm of modifyForms) {
	modifyForm.addEventListener('submit', (e) => {
		e.preventDefault();
		if (e.submitter.value === "delete") {
			modifyForm.action = "delete_tickets.jsp";
		} else {
			modifyForm.action = "update_tickets.jsp";
		}
		modifyForm.submit();
	});
}