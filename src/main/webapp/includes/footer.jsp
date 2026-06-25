<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    </div> <!-- /main-content -->
    
    <footer class="footer text-muted small">
        <div class="container-fluid d-flex justify-content-between">
            <span>&copy; 2026 Hospital XYZ. Todos los derechos reservados.</span>
            <span>Versión 1.0.0 | <i class="fas fa-shield-halved text-success"></i> Sistema Seguro</span>
        </div>
    </footer>

</div> <!-- /content -->
</div> <!-- /wrapper -->

<!-- Scripts -->
<script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.all.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
    $(document).ready(function () {
        // Toggle Sidebar
        $('#sidebarCollapse').on('click', function () {
            $('#sidebar').toggleClass('active');
            if($('#sidebar').hasClass('active')) {
                $('#sidebar').css('margin-left', '-250px');
            } else {
                $('#sidebar').css('margin-left', '0');
            }
        });

        // Set active class based on URL
        const currentPath = window.location.pathname;
        let found = false;
        $('#sidebar ul li a').each(function() {
            if ($(this).attr('href') !== '#' && currentPath.includes($(this).attr('href'))) {
                $('#sidebar ul li').removeClass('active');
                $(this).parent().addClass('active');
                found = true;
            }
        });
        
        // Default to index if no match
        if(!found && currentPath.endsWith('/')) {
             $('#sidebar ul li').first().addClass('active');
        }
    });
</script>
</body>
</html>
