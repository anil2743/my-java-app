function loadSection(sectionId) {
    const welcomeMessage = document.getElementById('welcomeMessage');
    const contentArea = document.getElementById('contentArea');
    const inlineSections = document.getElementById('inlineSections');
    const sections = inlineSections.querySelectorAll('.section-content');
    const iframe = document.getElementById('contentIframe');

    welcomeMessage.classList.add('hidden');
    iframe.classList.remove('active');
    contentArea.classList.add('active');

    sections.forEach(section => {
        section.classList.remove('active');
    });
    const activeSection = document.getElementById(sectionId);
    if (activeSection) {
        activeSection.classList.add('active');
    }
}

function loadIframe(url) {
    const welcomeMessage = document.getElementById('welcomeMessage');
    const contentArea = document.getElementById('contentArea');
    const iframe = document.getElementById('contentIframe');

    welcomeMessage.classList.add('hidden');
    contentArea.classList.remove('active');
    iframe.classList.add('active');
    iframe.src = url;
}

function viewEmployees(employeeId) {
    alert(`Viewing details for Employee ID: ${employeeId}`);
}

function publishLink(employeeId) {
    alert(`Publishing link for Employee ID: ${employeeId}`);
}

function removeRegistration(employeeId) {
    if (confirm(`Remove registration for Employee ID: ${employeeId}?`)) {
        alert(`Registration removed for ${employeeId}`);
    }
}

function revokeLink(examId) {
    if (confirm(`Revoke access for Exam ID: ${examId}?`)) {
        alert(`Link revoked for ${examId}`);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const welcomeMessage = document.getElementById('welcomeMessage');
    const contentArea = document.getElementById('contentArea');
    const iframe = document.getElementById('contentIframe');
    welcomeMessage.classList.remove('hidden');
    contentArea.classList.remove('active');
    iframe.classList.remove('active');
});