document.addEventListener('DOMContentLoaded', () => {
    const batchFilter = document.getElementById('batchFilter');
    const dateFilter = document.getElementById('dateFilter');
    const statusFilter = document.getElementById('statusFilter');
    const empIdSearch = document.getElementById('empIdSearch');
    const rows = document.querySelectorAll('tbody tr');

    // Debugging: Check if elements are found
    console.log('batchFilter:', batchFilter);
    console.log('dateFilter:', dateFilter);
    console.log('statusFilter:', statusFilter);
    console.log('empIdSearch:', empIdSearch);
    console.log('Rows found:', rows.length);

    if (!empIdSearch) {
        console.error('empIdSearch element not found!');
        return;
    }

    function applyFilters() {
        const batchValue = batchFilter.value.trim().toLowerCase();
        const dateValue = dateFilter.value.trim();
        const statusValue = statusFilter.value.trim();
        const empIdValue = empIdSearch.value.trim().toLowerCase();

        console.log('Filter Values:', { batchValue, dateValue, statusValue, empIdValue });

        rows.forEach((row, index) => {
            const rowBatch = (row.getAttribute('data-batch') || '').toLowerCase();
            const rowDate = row.getAttribute('data-date') || '';
            const rowStatus = row.getAttribute('data-status') || '';
            const rowEmpId = (row.getAttribute('data-id') || '').toLowerCase();
            const rowAttempts = row.getAttribute('data-attempts') || 'N/A';

            const matchesBatch = batchValue === '' || rowBatch.includes(batchValue);
            const matchesDate = dateValue === '' || rowDate === dateValue;
            const matchesStatus = statusValue === '' || rowStatus === statusValue;
            const matchesEmpId = empIdValue === '' || rowEmpId.includes(empIdValue);

            const isVisible = matchesBatch && matchesDate && matchesStatus && matchesEmpId;
            row.style.display = isVisible ? '' : 'none';

            if (index < 5) {
                console.log(`Row ${index + 1}: Batch=${rowBatch}, Date=${rowDate}, Status=${rowStatus}, EmpId=${rowEmpId}, Attempts=${rowAttempts}, MatchesEmpId=${matchesEmpId}, Visible=${isVisible}`);
            }
        });
    }

    batchFilter.addEventListener('input', applyFilters);
    dateFilter.addEventListener('change', applyFilters);
    statusFilter.addEventListener('change', applyFilters);
    empIdSearch.addEventListener('input', () => {
        console.log('Employee ID Search triggered:', empIdSearch.value);
        applyFilters();
    });

    applyFilters();
});