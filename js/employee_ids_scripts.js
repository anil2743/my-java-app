document.addEventListener("DOMContentLoaded", function () {
    const filterInput = document.getElementById("filterInput");
    const tableRows = document.querySelectorAll(".employee-ids-list tbody tr");

    filterInput.addEventListener("input", function () {
        const filterValue = filterInput.value.toLowerCase();

        tableRows.forEach(row => {
            const employeeId = row.querySelector("td").textContent.toLowerCase();
            if (employeeId.includes(filterValue)) {
                row.style.display = "";
            } else {
                row.style.display = "none";
            }
        });
    });
});