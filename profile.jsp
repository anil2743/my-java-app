<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>CYE Technology Private Limited</title>
    <link rel="stylesheet" href="css/profile.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.css">
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user"></i> Employee Profile</h1>
        </div>

        <div class="content">
            <div class="profile-card">
                <%
                    String email = (String) session.getAttribute("email");
                    if (email == null) {
                        response.sendRedirect("login.jsp");
                        return;
                    }
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String errorMessage = null;
                    String employeeName = "", employeeId = "", batch = "", registrationDateTime = "";
                    byte[] profilePhotoBytes = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/exam", "root", "Anilp@2024");
                        
                        String sql = "SELECT Name, ID, Batch, Registration_DateTime, Profile_Photo FROM employee_registrations WHERE email = ?";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, email);
                        rs = pstmt.executeQuery();
                        
                        if (rs.next()) {
                            employeeName = rs.getString("Name");
                            employeeId = rs.getString("ID");
                            batch = rs.getString("Batch");
                            SimpleDateFormat sdf = new SimpleDateFormat("MMMM d, yyyy, hh:mm a");
                            registrationDateTime = rs.getTimestamp("Registration_DateTime") != null ? sdf.format(rs.getTimestamp("Registration_DateTime")) : "N/A";
                            Blob profilePhoto = rs.getBlob("Profile_Photo");
                            if (profilePhoto != null) {
                                profilePhotoBytes = profilePhoto.getBytes(1, (int) profilePhoto.length());
                            }
                        } else {
                            errorMessage = "Employee profile not found.";
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                        errorMessage = "Error retrieving profile: " + e.getMessage();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
                <div class="profile-details">
                    <div class="profile-photo-container">
                        <img src="<%= profilePhotoBytes != null ? "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(profilePhotoBytes) : "images/default_profile.jpg" %>" 
                             alt="Profile Photo" class="profile-img" id="profileImg">
                        <div class="photo-actions">
                            <button class="btn btn-primary add-photo" onclick="document.getElementById('photoInput').click()">Add New</button>
                            <% if (profilePhotoBytes != null) { %>
                                <button class="btn btn-primary edit-photo" onclick="editPhoto()">Edit</button>
                                <button class="btn btn-danger remove-photo" onclick="showRemoveConfirm('<%= email %>')">Remove Photo</button>
                            <% } %>
                        </div>
                        <form id="photoForm" action="UploadEmployeePhotoServlet" method="post" enctype="multipart/form-data" style="display: none;">
                            <input type="file" id="photoInput" name="photo" accept="image/*" onchange="previewPhoto(event)">
                            <input type="hidden" name="email" value="<%= email %>">
                        </form>
                    </div>
                    <div class="profile-info">
                        <h2 class="profile-name"><%= employeeName %></h2>
                        <div class="info-section">
                            <h3>Contact Information</h3>
                            <div class="info-item">
                                <i class="fas fa-id-badge"></i>
                                <p><strong>Employee ID:</strong> <%= employeeId %></p>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-envelope"></i>
                                <p><strong>Email:</strong> <%= email %></p>
                            </div>
                        </div>
                        <div class="info-section">
                            <h3>General Information</h3>
                            <div class="info-item">
                                <i class="fas fa-users"></i>
                                <p><strong>Batch:</strong> <%= batch %></p>
                            </div>
                            <div class="info-item">
                                <i class="fas fa-calendar-plus"></i>
                                <p><strong>Registration Date:</strong> <%= registrationDateTime %></p>
                            </div>
                        </div>
                    </div>
                </div>
                <% if (errorMessage != null) { %>
                    <p class="error"><%= errorMessage %></p>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Crop Modal -->
    <div id="photoModal" class="modal">
        <div class="modal-content">
            <h3>Crop Your Photo</h3>
            <div class="crop-container">
                <img id="cropImage" src="" alt="Crop Preview">
            </div>
            <div class="modal-actions">
                <button class="btn btn-primary" onclick="saveCroppedPhoto()">Save</button>
                <button class="btn btn-danger" onclick="closeModal()">Cancel</button>
            </div>
        </div>
    </div>

    <!-- Remove Confirmation Modal -->
    <div id="removeConfirmModal" class="modal">
        <div class="modal-content small-modal">
            <p>Are you sure you want to remove your profile photo?</p>
            <div class="modal-actions">
                <button class="btn btn-primary" id="confirmYes">Yes</button>
                <button class="btn btn-danger" onclick="closeRemoveConfirm()">No</button>
            </div>
        </div>
    </div>

    <!-- Popup Message -->
    <div id="popup" class="popup"></div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.js"></script>
    <script>
        let cropper;
        let isEditing = false;
        const email = '<%= email %>';
        const defaultImage = 'images/default_profile.jpg';

        function previewPhoto(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const img = document.getElementById('cropImage');
                    img.src = e.target.result;
                    document.getElementById('photoModal').style.display = 'flex';
                    cropper = new Cropper(img, {
                        aspectRatio: 1,
                        viewMode: 1,
                        movable: true,
                        scalable: true,
                        zoomable: true,
                        autoCropArea: 0.8,
                        cropBoxResizable: true
                    });
                };
                reader.readAsDataURL(file);
            }
        }

        function editPhoto() {
            isEditing = true;
            document.getElementById('photoInput').click();
        }

        function saveCroppedPhoto() {
            const canvas = cropper.getCroppedCanvas({ width: 200, height: 200 });
            canvas.toBlob(function(blob) {
                const formData = new FormData();
                formData.append('photo', blob, 'profile.jpg');
                formData.append('email', email);
                fetch('UploadEmployeePhotoServlet', {
                    method: 'POST',
                    body: formData
                })
                .then(response => {
                    if (response.ok) {
                        document.getElementById('profileImg').src = canvas.toDataURL('image/jpeg', 0.7);
                        updatePhotoActions();
                        showPopup('Profile photo updated successfully!', true);
                    } else {
                        return response.text().then(text => { throw new Error('Failed to upload: ' + text); });
                    }
                })
                .catch(error => {
                    showPopup('Failed to upload photo: ' + error.message, false);
                });
            }, 'image/jpeg', 0.7);
            closeModal();
        }

        function closeModal() {
            document.getElementById('photoModal').style.display = 'none';
            if (cropper) {
                cropper.destroy();
                cropper = null;
            }
            document.getElementById('photoInput').value = '';
            isEditing = false;
        }

        function showRemoveConfirm(email) {
            const modal = document.getElementById('removeConfirmModal');
            const yesBtn = document.getElementById('confirmYes');
            modal.style.display = 'flex';
            yesBtn.onclick = function() {
                removePhoto(email);
                closeRemoveConfirm();
            };
        }

        function closeRemoveConfirm() {
            document.getElementById('removeConfirmModal').style.display = 'none';
        }

        function removePhoto(email) {
            fetch('RemoveEmployeePhotoServlet', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'email=' + encodeURIComponent(email)
            })
            .then(response => {
                if (response.ok) {
                    document.getElementById('profileImg').src = defaultImage;
                    updatePhotoActions();
                    showPopup('Profile photo removed successfully!', true);
                } else {
                    return response.text().then(text => { throw new Error('Failed to remove: ' + text); });
                }
            })
            .catch(error => {
                showPopup('Failed to remove photo: ' + error.message, false);
            });
        }

        function updatePhotoActions() {
            const container = document.querySelector('.photo-actions');
            const imgSrc = document.getElementById('profileImg').src;
            const hasPhoto = !imgSrc.includes('default_profile.jpg');
            let html = '<button class="btn btn-primary add-photo" onclick="document.getElementById(\'photoInput\').click()">Add New</button>';
            if (hasPhoto) {
                html += `
                    <button class="btn btn-primary edit-photo" onclick="editPhoto()">Edit</button>
                    <button class="btn btn-danger remove-photo" onclick="showRemoveConfirm('${email}')">Remove Photo</button>
                `;
            }
            container.innerHTML = html;
        }

        function showPopup(message, isSuccess) {
            const popup = document.getElementById('popup');
            popup.textContent = message;
            popup.style.backgroundColor = isSuccess ? '#27ae60' : '#e74c3c';
            popup.style.display = 'block';
            setTimeout(() => {
                popup.style.display = 'none';
            }, 3000);
        }
    </script>
</body>
</html>